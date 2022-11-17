#!/bin/bash
# Get Binary
get_kafka() {
  LINK="https://downloads.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz"
  wget "$LINK" -O /tmp/kafka.tar.gz
  mkdir -p /tmp/kafka
  tar -xzf /tmp/kafka.tar.gz -C /tmp/kafka --strip-components 1
  rm /tmp/kafka.tar.gz
  rm /tmp/kafka/LICENSE
  rm /tmp/kafka/NOTICE
  rm -rf /tmp/kafka/licenses
  rm -rf /tmp/kafka/site-docs
  rm -rf /tmp/kafka/bin/windows
  echo "Kafka downloaded"
}
add_kafka() {
  echo "Adding Kafka"
  mv tmp/kafka/bin /bin/kafka
  chmod +x /bin/kafka/bin/*.sh
  echo "Kafka added"
}
# Install Kafka
get_kafka
add_kafka
apk add --no-cache openjdk11