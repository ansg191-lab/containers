FROM debian:13.2-slim@sha256:4bcb9db66237237d03b55b969271728dd3d955eaaa254b9db8a3db94550b1885

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        jq && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
ADD --chmod=0755 spend.sh /app/spend.sh

CMD [ "/app/spend.sh" ]
