FROM debian:13.7-slim@sha256:62bd423aeee912639ca8ee681c2b762cb3e25137e0a92b20be455898a9f034ad

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
