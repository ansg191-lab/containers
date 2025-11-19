FROM debian:13.2-slim@sha256:18764e98673c3baf1a6f8d960b5b5a1ec69092049522abac4e24a7726425b016

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD --chmod=0755 spend.sh /app/spend.sh

CMD [ "/app/spend.sh" ]
