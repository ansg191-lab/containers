FROM python:3.14.7-trixie@sha256:3df083612dec28cf1456da4f38064469561fc2e55da4ebf47e9f0110c62f80e2

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
