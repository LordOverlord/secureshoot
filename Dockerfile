FROM alpine:3.18.5
COPY build/ /tmp/
RUN set -ex && \
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
    htop && \
    # Install oh my bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    chmod +x /tmp/*.sh && \
    /tmp/fetch_binaries.sh && \
    # cleanup 
    rm /tmp/fetch_binaries.sh && \
    mv /tmp/.bashrc root/.bashrc
# Run bash
CMD ["/bin/bash"]