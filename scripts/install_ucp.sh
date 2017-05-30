echo "Installing UCP"
docker pull docker/ucp:2.1.4
docker run --rm --name ucp \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/ucp:2.1.4 install \
    --host-address `hostname -I | cut -d' ' -f2` \
    --admin-password password \
    --san ucp.vm \
    --license $1

# Get the SWARM manager join token
docker swarm join-token manager \
    | awk -F " " '/token/ {print $2}' \
    > /vagrant/rundata/swarm-join-token-mgr

# Get the SWARM worker join token
docker swarm join-token worker \
    | awk -F " " '/token/ {print $2}' \
    > /vagrant/rundata/swarm-join-token-worker
