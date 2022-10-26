# Path to your oh-my-bash installation.
echo motd
export OSH=~/.oh-my-bash
# Set name of the theme to load.
OSH_THEME="n0qorg"
# Custom plugins may be added to ~/.oh-my-bash/custom/plugins/
source $OSH/oh-my-bash.sh
alias kafka-install='. tmp/kafka_install.sh'
alias ufetch='. tmp/ufetch.sh'
echo "Welcome to the SecureShoot Docker container!"
echo "This container is based on Alpine Linux."
echo "To install Kafka, run 'kafka-install'."
echo "Includes: Kafka, Confluent, and troubleshooting tools."

