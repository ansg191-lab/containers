FROM python:3.14.2-trixie@sha256:dadbe13e4d921ffd7f10dfe21c4b5bd18f7d322740309f42a8b7a22480f3bdff

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

ADD requirements.txt .

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
        build-essential \
        cmake \
        libgirepository-2.0-dev \
        libgstreamer1.0-dev \
        gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
        flac \
        vim && \
    pip install --no-cache-dir -r requirements.txt

CMD [ "/bin/bash" ]
