FROM alpine:3.23.3@sha256:25109184c71bdad752c8312a8623239686a9a2071e8825f20acb8f2198c3f659 AS base

FROM base AS  build

# Install build dependencies
RUN --mount=type=cache,target=/var/cache/apk \
    apk --update add \
        gcc \
        libc-dev \
        make \
        openssl \
        openssl-dev \
        zlib-dev \
        e2fsprogs-dev

WORKDIR /app

# Download tarsnap source code and verify its integrity
# renovate: datasource=github-tags packageName=Tarsnap/tarsnap
ARG TARSNAP_VERSION="1.0.41"
ADD --checksum=sha256:bebdbe1e6e91233755beb42ef0b4adbefd9573455258f009fb331556c799b3d0 \
    https://www.tarsnap.com/download/tarsnap-autoconf-$TARSNAP_VERSION.tgz /app/

# Build and install tarsnap
RUN tar -xzf tarsnap-autoconf-$TARSNAP_VERSION.tgz && \
    cd tarsnap-autoconf-$TARSNAP_VERSION && \
    ./configure --prefix /app && \
    make -j $(nproc) all && \
    make install

# Final stage
FROM base AS final

# Create a non-privileged user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

# Copy binaries from the build stage
COPY --from=build /app/bin/* /usr/local/bin/
# Copy the tarsnap.conf file
COPY tarsnap.conf /app/etc/tarsnap.conf

USER appuser

CMD [ "tarsnap" ]
