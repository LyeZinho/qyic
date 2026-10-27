use std::env;

use anyhow::Context;
use tokio::net::TcpListener;
use tracing_subscriber::EnvFilter;

use qyic_server::config::Config;
use qyic_server::{connect_db, router, AppState};

#[tokio::main]
async fn main() -> anyhow::Result<()> {
    dotenvy::dotenv().ok();

    let filter = env::var("RUST_LOG").unwrap_or_else(|_| "qyic_server=info,tower_http=info".into());
    tracing_subscriber::fmt()
        .with_env_filter(EnvFilter::new(filter))
        .init();

    let config = Config::from_env().context("invalid configuration")?;
    let pool = connect_db(&config.database_url)
        .await
        .context("database unreachable")?;

    // Migrations run on boot: append-only, backward compatible (AGENTS.md).
    sqlx::migrate!("./migrations")
        .run(&pool)
        .await
        .context("migrations failed")?;

    let bind_addr = config.bind_addr.clone();
    let app = router(AppState { pool, config });

    let listener = TcpListener::bind(&bind_addr)
        .await
        .with_context(|| format!("failed to bind {bind_addr}"))?;
    tracing::info!("qyic-server listening on http://{bind_addr}");

    axum::serve(listener, app).await.context("server error")?;
    Ok(())
}
