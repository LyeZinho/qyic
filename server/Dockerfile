# --- Build stage ---
FROM rust:1-slim AS builder
WORKDIR /app

# Warm the dependency cache before copying sources.
COPY Cargo.toml ./
RUN mkdir -p src && echo "fn main() {}" > src/main.rs \
    && cargo build --release \
    && rm -rf src

COPY migrations ./migrations
COPY src ./src
RUN touch src/main.rs && cargo build --release

# --- Runtime stage ---
FROM debian:bookworm-slim
RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --system --no-create-home qyic

WORKDIR /app
COPY --from=builder /app/target/release/qyic-server /usr/local/bin/qyic-server

USER qyic
EXPOSE 8080
ENV RUST_LOG=info
CMD ["qyic-server"]
