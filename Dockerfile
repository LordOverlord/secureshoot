FROM alpine:3.18.0
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
    file \
    iftop \
    iperf3 \
    jq \
    openssl \
    openssh \
    git \
    pgcli \
    py3-pip \
    build-base \
    postgresql-dev \
    python3-dev\
    nano && \
    # Install oh my bash
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && \
    chmod +x /tmp/*.sh && \
    /tmp/fetch_binaries.sh && \
    # cleanup 
    rm /tmp/fetch_binaries.sh && \
    mv /tmp/.bashrc root/.bashrc &&\
    pip3 install psycopg2 typing-extensions
# Run bash
CMD ["/bin/bash"]