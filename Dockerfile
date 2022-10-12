FROM alpine:3.16.2 as fetcher
COPY build/fetch_binaries.sh /tmp/fetch_binaries.sh
RUN apk add --no-cache curl wget tar bash && \
    chmod +x /tmp/fetch_binaries.sh && \ 
    /tmp/fetch_binaries.sh && \
    rm /tmp/fetch_binaries.sh
FROM alpine:3.16.2
# Install all the things
COPY --from=fetcher /tmp/ /usr/local/bin
COPY copy-files/ ~/
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
    openjdk11 \
    openssl \
    speedtest-cli \
    openssh \
    tcptraceroute \
    git \
    htop && \
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    chmod +x /usr/local/bin/kafka/bin/*.sh && \
    curl -sL --http1.1 https://cnfl.io/cli | sh -s -- v2.23.0 && \
    mv -v ./bin/confluent /usr/local/bin/confluent
# Run bash
CMD ["bash"]