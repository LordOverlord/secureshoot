#!/usr/bin/env bash
set -euo pipefail
# Get Binary
get_confluent() {
  curl -sL --http1.1 https://cnfl.io/cli | sh -s -- v2.23.0
  mv -v bin/confluent /usr/local/bin/confluent
  chmod +x /usr/local/bin/confluent
  echo "Confluent downloaded"
}
get_confluent
confluent --version