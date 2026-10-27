use axum::routing::get;
use axum::Router;

use crate::AppState;

pub mod auth;
pub mod health;

/// Top-level router: `/healthz`, `/api/v1/*`.
///
/// Builds an `Router<AppState>` from the sub-routers and folds the state in at
/// the end, returning a ready-to-serve `Router<()>`.
pub fn router(state: AppState) -> Router {
    Router::new()
        .route("/healthz", get(health::health))
        .nest("/api/v1/health", health::router())
        .nest("/api/v1/auth", auth::router())
        // CORS is wide open for local development; tighten it behind a reverse
        // proxy (or an explicit allow-list) before public launch — see docs/infra.md.
        .layer(
            tower_http::cors::CorsLayer::new()
                .allow_origin(tower_http::cors::Any)
                .allow_methods(tower_http::cors::Any)
                .allow_headers(tower_http::cors::Any),
        )
        .layer(tower_http::trace::TraceLayer::new_for_http())
        .fallback(not_found)
        .with_state(state)
}

async fn not_found() -> crate::error::ApiError {
    crate::error::ApiError::NotFound("route not found".into())
}
