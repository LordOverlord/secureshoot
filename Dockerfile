FROM alpine:3.16.2
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
    dig \
    file \
    iftop \
    iperf3 \
    jq \
    mtr \
    openssl \
    speedtest-cli \
    openssh \
    git \
    htop && \
    # Install oh my bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    chmod +x /tmp/*.sh && \
    /tmp/install_confluent.sh && \
    /tmp/fetch_binaries.sh && \
    # cleanup 
    rm /tmp/fetch_binaries.sh && \
    rm /tmp/install_confluent.sh 
    # alias install-kafka='bash /tmp/install_kafka.sh'
# Run bash
# CMD ["bash"]