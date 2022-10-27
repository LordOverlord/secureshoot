# Path to your oh-my-bash installation.
export OSH=~/.oh-my-bash
# set utf-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Set name of the theme to load.
OSH_THEME="n0qorg"
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
source $OSH/oh-my-bash.sh
alias kafka-install='. tmp/kafka_install.sh'
alias ufetch='. tmp/ufetch.sh'
ufetch
echo "Welcome to the SecureShoot Docker container!"
echo "This container is based on Alpine Linux."
echo "To install Kafka, run 'kafka-install'."
echo "Includes: Kafka, Confluent, and troubleshooting tools."

