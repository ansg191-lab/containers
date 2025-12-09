FROM debian:13.2@sha256:0d01188e8dd0ac63bf155900fad49279131a876a1ea7fac917c62e87ccb2732d AS base

FROM rust:1.86-bookworm@sha256:300ec56abce8cc9448ddea2172747d048ed902a3090e6b57babb2bf19f754081 AS helix-builder

# renovate: datasource=github-releases packageName=cargo-bins/cargo-binstall
ARG BINSTALL_VERSION="v1.12.4"
# renovate: datasource=crate packageName=cargo-deb
ARG CARGO_DEB_VERSION="2.12.1"

WORKDIR /app
ADD --chmod=0755 \
    --checksum=sha256:0a8a9f249aaee1901c147feb70b94dfcbc31423f89cf722279f44ed63927611e \
    https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh install-from-binstall-release.sh
RUN bash install-from-binstall-release.sh && \
    cargo binstall cargo-deb@${CARGO_DEB_VERSION}

# renovate: datasource=github-releases packageName=helix-editor/helix versioning=loose
ARG HELIX_VERSION="25.01.1"
RUN git clone https://github.com/helix-editor/helix.git --branch ${HELIX_VERSION} --depth 1
WORKDIR /app/helix

RUN --mount=type=cache,target=/usr/local/cargo/git/db \
    --mount=type=cache,target=/usr/local/cargo/registry/ \
    case "$(dpkg --print-architecture)" in \
        amd64) ARCH="x86_64" ;; \
        arm64) ARCH="aarch64" ;; \
        *) echo "Unsupported architecture"; exit 1 ;; \
    esac && \
    wget -L https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-${ARCH}-linux.tar.xz && \
    tar -xf helix-${HELIX_VERSION}-${ARCH}-linux.tar.xz && \
    mv helix-${HELIX_VERSION}-${ARCH}-linux helix && \
    mkdir -p target/release && \
    mv helix/hx target/release && \
    mv helix/runtime/grammars/* runtime/grammars/ && \
    cargo deb --no-build

FROM base AS final

# Install useful tools and utilities
RUN apt-get update && \
    apt-get install -y \
        build-essential \
        git \
        curl \
        wget \
        vim \
        nano \
        less \
        htop \
        bat \
        net-tools \
        iputils-ping \
        dnsutils \
        man-db \
        strace \
        lsof \
        tcpdump \
        nmap \
        procps \
        sysstat \
        gdb \
        ncdu \
        file \
        tree \
        jq \
        whois \
        ncat \
        traceroute \
        mtr \
        iperf3 \
        # swaks: A tool for SMTP testing and debugging
        swaks && \
    rm -rf /var/lib/apt/lists/* && \
    # Rename batcat to bat
    ln -s /usr/bin/batcat /usr/local/bin/bat

ARG TARGETARCH
# renovate: datasource=github-releases packageName=kubernetes/kubernetes
ARG KUBECTL_VERSION="v1.33.0"
ADD --chmod=0755 \
    "https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/$TARGETARCH/kubectl" \
    /usr/local/bin/kubectl

COPY --from=helix-builder /app/helix/target/debian/helix*.deb /tmp/
RUN dpkg -i /tmp/helix*.deb && rm -rf /tmp/helix*.deb

COPY root/ /
