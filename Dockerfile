FROM debian:stable-slim as fetcher
COPY build/fetch_binaries.sh /tmp/fetch_binaries.sh

RUN apt-get update && apt-get install -y curl wget && \
    chmod +x /tmp/fetch_binaries.sh && \ 
    /tmp/fetch_binaries.sh

FROM alpine:3.16.2

RUN set -ex && \
    apk add --no-cache ca-certificates && \
    update-ca-certificates && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories && \
    apk update && \
    apk upgrade && \
    apk add --no-cache \
    bash \ 
    bind-tools \
    busybox \
    curl \
    drill \
    file \
    iftop \
    iperf3 \
    jq \
    mtr \
    openjdk11 \
    openssl \
    py3-pip \
    py3-setuptools \ 
    speedtest-cli \
    openssh \
    tcptraceroute \
    util-linux \
    vim \
    git \
    zsh \
    traceroute

# Install ctop
COPY --from=fetcher /tmp/ctop /usr/local/bin/ctop
# Install calicoctl
COPY --from=fetcher /tmp/calicoctl /usr/local/bin/calicoctl
# Install kafka
COPY --from=fetcher /tmp/kafka /usr/local/bin/kafka
# Install Confluent CLI
RUN curl -sL --http1.1 https://cnfl.io/cli | sh -s -- v2.23.0 && mv -v ./bin/confluent /usr/local/bin/confluent

# ZSH config
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
COPY zshrc .zshrc

#Copy motd
COPY motd motd

# Run zsh
CMD ["zsh"]