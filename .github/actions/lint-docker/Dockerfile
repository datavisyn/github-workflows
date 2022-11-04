FROM ghcr.io/hadolint/hadolint:latest-alpine

COPY ./.github/actions/lint-docker/entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ]
