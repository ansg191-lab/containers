FROM debian:13.7-slim@sha256:f6b08b09a05725f9431502d3b5714f5c4576e82c1a84fa1debe0c24a7e0c3ec4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD --chmod=0755 spend.sh /app/spend.sh

CMD [ "/app/spend.sh" ]
