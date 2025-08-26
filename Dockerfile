FROM rust:1.82 as builder
WORKDIR /app
COPY . .
RUN cargo build --release

FROM debian:bullseye-slim
WORKDIR /app
COPY --from=builder /app/target/release/hello-koyeb /app/
EXPOSE 8080
CMD ["./hello-koyeb"]