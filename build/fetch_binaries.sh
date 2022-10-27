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
  mv /tmp/ctop /usr/local/bin/ctop
  echo "Ctop downloaded"
}
#Get calicoctl function
get_calicoctl() {
  VERSION=$(get_latest_release projectcalico/calicoctl)
  LINK="https://github.com/projectcalico/calico/releases/download/${VERSION}/calicoctl-linux-${ARCH}"
  wget "$LINK" -O /tmp/calicoctl && chmod +x /tmp/calicoctl
  mv /tmp/calicoctl /usr/local/bin/calicoctl
  echo "Calicoctl downloaded"
}
get_ctop
get_calicoctl
