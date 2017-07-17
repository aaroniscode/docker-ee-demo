# Variable Assignment
ucp_version=$1
tld=$2
password=$3
license=$4

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

/vagrant/scripts/get_swarm_tokens.sh
