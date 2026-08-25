FROM debian:13.6-slim@sha256:d7e12182ce18b85b93007c1dedf31f2d29e01ccf3182cc4017c709b6259bc132

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        netcat-openbsd \
        curl \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

ADD --chmod=0755 check.sh /app/check.sh

ENTRYPOINT ["/app/check.sh"]
