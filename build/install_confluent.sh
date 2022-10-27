#!/usr/bin/env bash
set -euo pipefail
# Get Binary
get_confluent() {
  curl -sL --http1.1 https://cnfl.io/cli | sh -s -- v2.30.1
  mv -v bin/confluent /usr/local/bin/confluent
  chmod +x /usr/local/bin/confluent
  mkdir ~/.confluent
  touch ~/.confluent/config.json
  echo '"disable_plugins: true"' > ~/.confluent/config.json
  echo "Confluent downloaded"
}
get_confluent
confluent --version