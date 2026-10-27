//! Qyic API server.
//!
//! Axum + SQLx + PostgreSQL. Offline-first clients only ever talk to this API to
//! *sync* — never to study. See `docs/adr/` for the architectural invariants.

pub mod config;
pub mod error;
pub mod mail;
pub mod routes;

use axum::Router;
use sqlx::postgres::PgPoolOptions;
use sqlx::PgPool;

use config::Config;

/// Application-wide state shared by all handlers.
#[derive(Clone)]
pub struct AppState {
    pub pool: PgPool,
    pub config: Config,
}

/// Build the full HTTP router.
pub fn router(state: AppState) -> Router {
    routes::router(state)
}

/// Connect to PostgreSQL with a small, tightly-held connection pool.
///
/// Transactions must stay short: connection hold time — not CPU — is the
/// classic bottleneck (see `docs/adr/0004-postgres-only-infrastructure.md`).
pub async fn connect_db(database_url: &str) -> anyhow::Result<PgPool> {
    let pool = PgPoolOptions::new()
        .max_connections(10)
        .connect(database_url)
        .await?;
    Ok(pool)
}

#[cfg(test)]
pub fn test_state() -> AppState {
    // Lazy pool: no connection is opened, which keeps handler tests DB-free.
    let pool = PgPoolOptions::new()
        .connect_lazy("postgres://qyic:qyic@localhost:5432/qyic_test")
        .expect("lazy pool");
    AppState {
        pool,
        config: Config::for_tests(),
    }
}

#[cfg(test)]
mod tests {
    use axum::body::Body;
    use axum::http::{Request, StatusCode};
    use tower::ServiceExt;

    #[tokio::test]
    async fn healthz_is_reachable() {
        let app = crate::router(crate::test_state());
        let response = app
            .oneshot(
                Request::builder()
                    .uri("/healthz")
                    .body(Body::empty())
                    .unwrap(),
            )
            .await
            .unwrap();
        assert_eq!(response.status(), StatusCode::OK);
    }

    #[tokio::test]
    async fn unknown_route_is_404() {
        let app = crate::router(crate::test_state());
        let response = app
            .oneshot(
                Request::builder()
                    .uri("/definitely-not-a-route")
                    .body(Body::empty())
                    .unwrap(),
            )
            .await
            .unwrap();
        assert_eq!(response.status(), StatusCode::NOT_FOUND);
    }
}
