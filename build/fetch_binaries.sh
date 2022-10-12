#!/usr/bin/env bash
set -euo pipefail
#Get the architecure of the machine
ARCH=$(uname -m)
case $ARCH in
    x86_64)
        ARCH=amd64
        ;;
    aarch64)
        ARCH=arm64
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac
#Get latest version
get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}
#Get ctop function
get_ctop() {
    echo "Getting ctop"
    VERSION=$(get_latest_release bcicen/ctop | sed -e 's/^v//')
    LINK="https://github.com/bcicen/ctop/releases/download/v${VERSION}/ctop-${VERSION}-linux-${ARCH}"
    wget "$LINK" -O /tmp/ctop && chmod +x /tmp/ctop
}
#Get calicoctl function
get_calicoctl() {
  VERSION=$(get_latest_release projectcalico/calicoctl)
  LINK="https://github.com/projectcalico/calicoctl/releases/download/${VERSION}/calicoctl-linux-${ARCH}"
  wget "$LINK" -O /tmp/calicoctl && chmod +x /tmp/calicoctl
}
get_kafka() {
  LINK="https://downloads.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz"
  wget "$LINK" -O /tmp/kafka.tar.gz
  mkdir -p /tmp/kafka
  tar -xzf /tmp/kafka.tar.gz -C /tmp/kafka --strip-components 1
}
get_jackson() {
  LINK="https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.14.0-rc2/jackson-databind-2.14.0-rc2.jar"
  wget "$LINK" -O /tmp/jackson-databind-2.12.3.jar
}
get_ctop
get_calicoctl
get_kafka
get_jackson