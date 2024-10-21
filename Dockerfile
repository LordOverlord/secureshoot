FROM alpine:latest

# Copy build scripts to /tmp
COPY build/ /tmp/

RUN set -ex && \
    # Install necessary packages
    apk add --no-cache ca-certificates && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash \
    busybox-extras \
    curl \
    drill \
    file \
    iftop \
    iperf3 \
    jq \
    mtr \
    openssl \
    speedtest-cli \
    openssh \
    git \
    nano \
    dos2unix \
    htop && \
    # Install Oh My Bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    # Check if fetch_binaries.sh exists and is executable
    ls -l /tmp/ && \
    if [ -f /tmp/fetch_binaries.sh ]; then \
        dos2unix /tmp/fetch_binaries.sh; \
        echo "fetch_binaries.sh exists"; \
        chmod +x /tmp/fetch_binaries.sh; \
        bash /tmp/fetch_binaries.sh; \
    else \
        echo "fetch_binaries.sh not found"; \
        exit 1; \
    fi && \
    # Cleanup after execution
    rm /tmp/fetch_binaries.sh && \
    mv /tmp/.bashrc root/.bashrc

# Run bash by default
CMD ["/bin/bash"]
