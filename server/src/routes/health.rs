use axum::extract::State;
use axum::http::StatusCode;
use axum::response::IntoResponse;
use axum::routing::get;
use axum::{Json, Router};
use serde_json::{json, Value};

use crate::AppState;

pub fn router() -> Router<AppState> {
    Router::new().route("/ready", get(ready))
}

/// Liveness probe: no dependencies, never fails while the process is up.
pub async fn health() -> impl IntoResponse {
    (
        StatusCode::OK,
        Json(json!({ "status": "ok", "service": "qyic-server" })),
    )
}

/// Readiness probe: requires a round-trip to PostgreSQL.
pub async fn ready(State(state): State<AppState>) -> Result<Json<Value>, crate::error::ApiError> {
    let one: i32 = sqlx::query_scalar("SELECT 1")
        .fetch_one(&state.pool)
        .await?;
    Ok(Json(json!({ "status": "ready", "db": one == 1 })))
}
