#!/bin/bash
set -euo pipefail
# Get Binary
get_kafka() {
  LINK="https://downloads.apache.org/kafka/3.3.1/kafka_2.13-3.3.1.tgz"
  wget "$LINK" -O /tmp/kafka.tar.gz
  mkdir -p /tmp/kafka
  tar -xzf /tmp/kafka.tar.gz -C /tmp/kafka --strip-components 1
  rm /tmp/kafka.tar.gz
  rm /tmp/kafka/libs/jackson-databind-2.13.3.jar
  rm /tmp/kafka/libs/scala-library-2.13.8.jar
  rm /tmp/kafka/libs/netty-handler-4.1.78.Final.jar
  echo "Kafka downloaded"
}
get_jackson() {
  LINK="https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.14.0-rc2/jackson-databind-2.14.0-rc2.jar"
  wget "$LINK" -O /tmp/jackson-databind-2.14.0-rc2.jar
  mv /tmp/jackson-databind-2.14.0-rc2.jar /tmp/kafka/libs/
  echo "Jackson downloaded"
}
get_scala-library() {
  LINK="https://repo1.maven.org/maven2/org/scala-lang/scala-library/2.13.10/scala-library-2.13.10.jar"
  wget "$LINK" -O /tmp/scala-library-2.13.10.jar
  mv /tmp/scala-library-2.13.10.jar /tmp/kafka/libs/
  echo "Scala-library downloaded"
}
get_netty() {
  LINK="https://repo1.maven.org/maven2/io/netty/netty-handler/4.1.82.Final/netty-handler-4.1.82.Final.jar"
  wget "$LINK" -O /tmp/netty-handler-4.1.82.Final.jar
  mv /tmp/netty-handler-4.1.82.Final.jar /tmp/kafka/libs/
  echo "Netty downloaded"
}
add_kafka() {
  echo "Adding Kafka"
  mv tmp/kafka /usr/bin/kafka
  chown -R root:root /usr/bin/kafka
  chmod -R 755 /usr/bin/kafka
  chmod +x /usr/bin/kafka/bin/*.sh
  echo "Kafka added"
}
# Install Kafka
get_kafka
get_jackson
get_scala-library
get_netty
add_kafka
apk add --no-cache openjdk11