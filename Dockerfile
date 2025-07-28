FROM alpine:latest
COPY build/ /tmp/
RUN set -ex && \
    apk add --no-cache ca-certificates && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade --available && \
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
    htop && \
    # Install oh my bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    chmod +x /tmp/*.sh && \
    /tmp/fetch_binaries.sh && \
    # cleanup
    rm /tmp/fetch_binaries.sh && \
    mv /tmp/.bashrc root/.bashrc

RUN addgroup --system securegroup && \
    adduser -D -G securegroup secureshoot && \
    mkdir -p /app && \
    chown -R secureshoot:securegroup /app

USER secureshoot

WORKDIR /app

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD [ "ctop", "--version" ] || exit 1

# Run bash by default
CMD ["/bin/bash"]