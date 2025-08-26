FROM rust:1.82 as builder
WORKDIR /app
COPY . .
RUN cargo build --release

# استفاده از Debian جدید با GLIBC بالاتر (>=2.36)
FROM debian:bookworm-slim
WORKDIR /app
COPY --from=builder /app/target/release/hello-koyeb /app/
# برای جلوگیری از خطای اجرا، نیاز داریم libssl و ca-certificates نصب باشن
RUN apt-get update && apt-get install -y \
    libssl3 \
    ca-certificates \
 && rm -rf /var/lib/apt/lists/*
EXPOSE 8080
CMD ["./hello-koyeb"]