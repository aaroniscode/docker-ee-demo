# Variable Assignment
ucp_version=$(grep 'ucp_version:' /vagrant/config.yaml | awk '{print $2}')
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')
license=$(grep 'license:' /vagrant/config.yaml | awk '{print $2}')

# Vagrant workaround, docker run without a cached image
# colors output red which looks like an error
echo "Pulling UCP image"
docker pull docker/ucp:${ucp_version}

# Install UCP
echo "Installing UCP"
docker run --rm --name ucp \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/ucp:${ucp_version} install \
    --host-address `hostname -I | cut -d' ' -f2` \
    --admin-password $password \
    --controller-port 8443 \
    --san ucp.${tld} \
    --license $license

# Store UCP's self-signed certificate
echo "Storing UCP's certificate"
curl -sk https://ucp.${tld}/ca -o /vagrant/certs/ucp.crt

# Get the auth token and save in config.yaml
/vagrant/scripts/ucp/get_auth_token.sh

# Get the swarm join tokens and save in config.yaml
echo "Save swarm join tokens"
/vagrant/scripts/get_swarm_tokens.sh
