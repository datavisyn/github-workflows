FROM ghcr.io/hadolint/hadolint:v2.10.0-debian

WORKDIR /app

COPY entrypoint.sh /app/entrypoint.sh

RUN ls -lah /app/ && chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
