//! E-mail delivery for the passwordless login flow.
//!
//! SMTP is optional: when `SMTP_HOST` is not configured the server runs in dev
//! mode and logs the magic link instead of sending it, so the whole flow stays
//! testable without e-mail credentials.

use crate::config::{Config, SmtpConfig};

const MAGIC_LINK_SUBJECT: &str = "Your Qyic sign-in link";

/// Send (or, in dev mode, log) a magic sign-in link.
pub async fn send_magic_link(config: &Config, to: &str, link: &str) -> anyhow::Result<()> {
    let Some(smtp) = config.smtp.clone() else {
        tracing::warn!(
            to,
            link,
            "SMTP not configured — magic link logged instead of sent (dev mode)"
        );
        return Ok(());
    };

    let from = config.auth_from_email.clone();
    let to = to.to_string();
    let body = format!(
        "Sign in to Qyic:\n\n{link}\n\n\
         This link expires in 15 minutes and can only be used once.\n\
         If you didn't request it, you can safely ignore this e-mail."
    );

    // SMTP I/O off the async runtime: the response to the user never waits on
    // the mail server, and no async task holds a connection while blocked.
    tokio::task::spawn_blocking(move || -> anyhow::Result<()> { send(&smtp, &from, &to, &body) })
        .await??;

    Ok(())
}

fn send(smtp: &SmtpConfig, from: &str, to: &str, body: &str) -> anyhow::Result<()> {
    use lettre::transport::smtp::authentication::Credentials;
    use lettre::{Message, SmtpTransport, Transport};

    let message = Message::builder()
        .from(from.parse()?)
        .to(to.parse()?)
        .subject(MAGIC_LINK_SUBJECT)
        .body(body.to_string())?;

    let credentials = Credentials::new(smtp.username.clone(), smtp.password.clone());
    let transport = SmtpTransport::relay(&smtp.host)?
        .port(smtp.port)
        .credentials(credentials)
        .build();

    transport.send(&message)?;
    Ok(())
}
