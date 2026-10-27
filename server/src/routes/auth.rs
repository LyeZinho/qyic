//! Passwordless authentication: e-mail magic links (ADR-0005).
//!
//! Wire format: proto3 canonical JSON of `qyic.v1.LoginRequest`,
//! `qyic.v1.LoginResponse`, `qyic.v1.VerifyRequest`, `qyic.v1.Session`
//! (camelCase keys) — see `shared/proto/qyic/v1/auth.proto`.

use axum::extract::{Query, State};
use axum::http::StatusCode;
use axum::response::IntoResponse;
use axum::routing::{get, post};
use axum::{Json, Router};
use chrono::{DateTime, Duration, Utc};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use uuid::Uuid;

use crate::error::ApiError;
use crate::{mail, AppState};

/// Magic-link lifetime. Short on purpose: single use, 15 minutes.
const MAGIC_LINK_TTL_MINUTES: i64 = 15;
/// Session lifetime (30 days), refreshed by re-login.
const SESSION_TTL_DAYS: i64 = 30;

pub fn router() -> Router<AppState> {
    Router::new()
        .route("/request", post(request_login))
        .route("/verify", get(verify_link).post(verify_token))
}

// ---------------------------------------------------------------------------
// DTOs (proto3 canonical JSON)
// ---------------------------------------------------------------------------

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct LoginRequest {
    pub email: String,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct LoginResponse {
    pub accepted: bool,
    #[serde(skip_serializing_if = "Option::is_none")]
    pub dev_magic_link: Option<String>,
}

#[derive(Debug, Deserialize)]
#[serde(rename_all = "camelCase")]
pub struct VerifyRequest {
    pub token: String,
}

#[derive(Debug, Serialize)]
#[serde(rename_all = "camelCase")]
pub struct Session {
    pub token: String,
    pub expires_at: DateTime<Utc>,
    pub user_id: Uuid,
    pub email: String,
}

#[derive(Debug, Deserialize)]
struct VerifyQuery {
    token: String,
}

// ---------------------------------------------------------------------------
// POST /api/v1/auth/request
// ---------------------------------------------------------------------------

async fn request_login(
    State(state): State<AppState>,
    Json(body): Json<LoginRequest>,
) -> Result<impl IntoResponse, ApiError> {
    let email = body.email.trim().to_lowercase();
    if !is_valid_email(&email) {
        return Err(ApiError::BadRequest("invalid e-mail address".into()));
    }

    // Upsert: logging in for the first time creates the account.
    let user_id: Uuid = sqlx::query_scalar(
        "INSERT INTO users (email) VALUES ($1) \
         ON CONFLICT (email) DO UPDATE SET updated_at = now() \
         RETURNING id",
    )
    .bind(&email)
    .fetch_one(&state.pool)
    .await?;

    // Only the hash of the token is stored; the raw token exists in transit only.
    let token = Uuid::new_v4().to_string();
    let expires_at = Utc::now() + Duration::minutes(MAGIC_LINK_TTL_MINUTES);
    sqlx::query(
        "INSERT INTO auth_tokens (user_id, token_hash, kind, expires_at) \
         VALUES ($1, $2, 'magic_link', $3)",
    )
    .bind(user_id)
    .bind(hash_token(&token))
    .bind(expires_at)
    .execute(&state.pool)
    .await?;

    let link = format!("{}/auth/verify?token={}", state.config.app_base_url, token);
    mail::send_magic_link(&state.config, &email, &link).await?;

    tracing::info!(%email, "magic link issued");

    let response = LoginResponse {
        accepted: true,
        dev_magic_link: state.config.dev_mode().then_some(link),
    };
    Ok((StatusCode::ACCEPTED, Json(response)))
}

// ---------------------------------------------------------------------------
// GET /api/v1/auth/verify?token=…   (magic-link click-through)
// POST /api/v1/auth/verify          (typed token / OTP)
// ---------------------------------------------------------------------------

async fn verify_link(
    State(state): State<AppState>,
    Query(query): Query<VerifyQuery>,
) -> Result<impl IntoResponse, ApiError> {
    let session = verify(&state, &query.token).await?;
    Ok(Json(session))
}

async fn verify_token(
    State(state): State<AppState>,
    Json(body): Json<VerifyRequest>,
) -> Result<impl IntoResponse, ApiError> {
    let session = verify(&state, &body.token).await?;
    Ok(Json(session))
}

async fn verify(state: &AppState, token: &str) -> Result<Session, ApiError> {
    // Atomic claim: the `used_at IS NULL` predicate makes the token single-use
    // even under concurrent verification attempts.
    let user_id: Uuid = sqlx::query_scalar(
        "UPDATE auth_tokens SET used_at = now() \
         WHERE token_hash = $1 AND used_at IS NULL AND expires_at > now() \
         RETURNING user_id",
    )
    .bind(hash_token(token))
    .fetch_optional(&state.pool)
    .await?
    .ok_or_else(|| ApiError::Unauthorized("invalid or expired token".into()))?;

    let email: String = sqlx::query_scalar("SELECT email FROM users WHERE id = $1")
        .bind(user_id)
        .fetch_one(&state.pool)
        .await?;

    let session_token = Uuid::new_v4().to_string();
    let expires_at = Utc::now() + Duration::days(SESSION_TTL_DAYS);
    sqlx::query("INSERT INTO sessions (user_id, token_hash, expires_at) VALUES ($1, $2, $3)")
        .bind(user_id)
        .bind(hash_token(&session_token))
        .bind(expires_at)
        .execute(&state.pool)
        .await?;

    tracing::info!(%email, "session issued");

    Ok(Session {
        token: session_token,
        expires_at,
        user_id,
        email,
    })
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/// Raw tokens are never stored — only this digest.
fn hash_token(token: &str) -> String {
    hex::encode(Sha256::digest(token.as_bytes()))
}

/// Deliberately minimal e-mail shape check (no DNS lookups, no dependencies).
fn is_valid_email(email: &str) -> bool {
    if email.is_empty() || email.len() > 254 || email.contains(' ') {
        return false;
    }
    let Some((local, domain)) = email.split_once('@') else {
        return false;
    };
    // Exactly one '@' (split_once only splits at the first one).
    if domain.contains('@') {
        return false;
    }
    !local.is_empty()
        && !domain.is_empty()
        && domain.contains('.')
        && !domain.starts_with('.')
        && !domain.ends_with('.')
        && !domain.contains("..")
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn token_hashing_is_stable_and_hex() {
        let a = hash_token("secret-token");
        let b = hash_token("secret-token");
        assert_eq!(a, b);
        assert_eq!(a.len(), 64);
        assert!(a.chars().all(|c| c.is_ascii_hexdigit()));
        assert_ne!(a, hash_token("other-token"));
    }

    #[test]
    fn email_validation_accepts_normal_addresses() {
        assert!(is_valid_email("ana@example.com"));
        assert!(is_valid_email("a.b+tag@sub.example.co"));
    }

    #[test]
    fn email_validation_rejects_malformed_addresses() {
        for bad in [
            "",
            "nope",
            "no@tld",
            "@example.com",
            "user@",
            "user @example.com",
            "user@.example.com",
            "user@example.",
            "user@@example.com",
            "user@exam..ple.com",
        ] {
            assert!(!is_valid_email(bad), "should reject: {bad}");
        }
    }
}
