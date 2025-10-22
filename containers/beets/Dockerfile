FROM python:3.14.0-trixie@sha256:6098c3241d19532bdb439d8c211e3e1c6cfa93c512fbd9118fa0b3d02a418a3e

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
        gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly && \
    pip install --no-cache-dir -r requirements.txt

CMD [ "/bin/bash" ]
