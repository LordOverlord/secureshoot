#!/bin/bash
# Get Binary
get_confluent() {
  curl -sL --http1.1 https://cnfl.io/cli | sh -s -- v2.23.0
  mv -v bin/confluent /bin/confluent
  chmod +x /bin/confluent
  echo "Confluent downloaded"
  confluent --version
}
get_confluent