use std::env;

/// Runtime configuration, loaded from the environment (and `.env` if present).
#[derive(Clone, Debug)]
pub struct Config {
    /// Socket the API binds to, e.g. `0.0.0.0:8080`.
    pub bind_addr: String,
    /// PostgreSQL connection string.
    pub database_url: String,
    /// Public base URL of the web client — magic links point here.
    pub app_base_url: String,
    /// From-address used for auth e-mails.
    pub auth_from_email: String,
    /// SMTP settings; `None` means dev mode (magic links are logged, not sent).
    pub smtp: Option<SmtpConfig>,
}

#[derive(Clone, Debug)]
pub struct SmtpConfig {
    pub host: String,
    pub port: u16,
    pub username: String,
    pub password: String,
}

impl Config {
    pub fn from_env() -> anyhow::Result<Self> {
        let database_url = env::var("DATABASE_URL")
            .unwrap_or_else(|_| "postgres://qyic:qyic_dev@localhost:5432/qyic_dev".to_string());

        let smtp = match env::var("SMTP_HOST") {
            Ok(host) if !host.is_empty() => Some(SmtpConfig {
                host,
                port: env::var("SMTP_PORT")
                    .ok()
                    .and_then(|p| p.parse().ok())
                    .unwrap_or(587),
                username: env::var("SMTP_USERNAME").unwrap_or_default(),
                password: env::var("SMTP_PASSWORD").unwrap_or_default(),
            }),
            _ => None,
        };

        Ok(Self {
            bind_addr: env::var("BIND_ADDR").unwrap_or_else(|_| "0.0.0.0:8080".to_string()),
            database_url,
            app_base_url: env::var("APP_BASE_URL")
                .unwrap_or_else(|_| "http://localhost:5173".to_string()),
            auth_from_email: env::var("AUTH_FROM_EMAIL")
                .unwrap_or_else(|_| "no-reply@qyic.com".to_string()),
            smtp,
        })
    }

    /// Without SMTP configured the server logs magic links instead of sending
    /// them, and exposes them in the login response for local development.
    pub fn dev_mode(&self) -> bool {
        self.smtp.is_none()
    }

    /// Config used by unit tests (never reads the real environment).
    pub fn for_tests() -> Self {
        Self {
            bind_addr: "127.0.0.1:0".to_string(),
            database_url: "postgres://qyic:qyic@localhost:5432/qyic_test".to_string(),
            app_base_url: "http://localhost:5173".to_string(),
            auth_from_email: "no-reply@qyic.test".to_string(),
            smtp: None,
        }
    }
}
