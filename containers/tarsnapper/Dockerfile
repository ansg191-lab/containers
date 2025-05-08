FROM ghcr.io/ansg191-lab/containers/tarsnap:v1.0.41.2@sha256:fc62440e7413315bca49e7d15fe2e6c6ad033a37b9c5890547555dc58e57d852 AS tarsnap-base

FROM python:3.13.3-alpine3.21@sha256:18159b2be11db91f84b8f8f655cd860f805dbd9e49a583ddaac8ab39bf4fe1a7

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

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

# Copy tarsnap binary and config from tarsnap-base
WORKDIR /app
COPY --from=tarsnap-base /usr/local/bin/* /usr/local/bin/
COPY --from=tarsnap-base /app/etc/tarsnap.conf /app/etc/tarsnap.conf

# Install tarsnapper
# renovate: datasource=pypi packageName=tarsnapper
ARG TARSNAPPER_VERSION="0.5.0"
RUN --mount=type=cache,target=/root/.cache/pip \
    python -m pip install tarsnapper==${TARSNAPPER_VERSION}

USER appuser

CMD [ "tarsnapper" ]
