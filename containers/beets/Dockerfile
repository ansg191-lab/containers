FROM python:3.13.9-trixie@sha256:a88217d7ea4c9e19058e56c54bdd4a9db9c7884f65b21445a710fd4c9b0a21fc

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
