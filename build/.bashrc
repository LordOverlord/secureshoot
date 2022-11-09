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
alias confluent-install='. tmp/install_confluent.sh'
alias ufetch='. tmp/ufetch.sh'
# sleep 2
ufetch
echo "Welcome to the SecureShoot Docker container!"
echo "This container is based on Alpine Linux."
echo "To install Kafka, run 'kafka-install'."
echo "To install Confluent, run 'confluent-install'."
echo "Includes: troubleshooting tools, and a few other goodies."