FROM python:3.14.0-trixie@sha256:efde2ffbe55ff8120ef87129f0b880471eccd9581882fbaa40b9f98ea2ebb5f2

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
