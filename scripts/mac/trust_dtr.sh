#!/bin/bash
# Add DTR certificate to the login keychain
echo "Adding DTR certificate to the login keychain. Password likely required..."
sudo security add-trusted-cert -d -r trustRoot -k "$HOME/Library/Keychains/login.keychain" \
    ${BASH_SOURCE%/*}/../../certs/dtr.crt

# Restart the Docker Daemon -- Required to use the new trusted cert
echo "Restarting Docker Daemon"
sudo killall -HUP com.docker.hyperkit
