FROM ghcr.io/hadolint/hadolint:v2.10.0-debian

COPY hadolint-matcher.json /
COPY entrypoint.sh /usr/local/bin/hadolint.sh

ENTRYPOINT ["/usr/local/bin/hadolint.sh"]
