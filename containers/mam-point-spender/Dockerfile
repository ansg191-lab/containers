FROM debian:13.1-slim@sha256:66b37a5078a77098bfc80175fb5eb881a3196809242fd295b25502854e12cbec

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD --chmod=0755 spend.sh /app/spend.sh

CMD [ "/app/spend.sh" ]
