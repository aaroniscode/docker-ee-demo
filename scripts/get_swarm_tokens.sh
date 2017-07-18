# Get the Swarm WORKER join token
worker_token=$(docker swarm join-token worker \
    | awk -F " " '/token/ {print $2}')

# Get the Swarm MANAGER join token
manager_token=$(docker swarm join-token manager \
    | awk -F " " '/token/ {print $2}')

# Write the join tokens to the config file
sed -i "s/^worker_token:.*/worker_token: $worker_token/" /vagrant/config.yaml
sed -i "s/^manager_token:.*/manager_token: $manager_token/" /vagrant/config.yaml
