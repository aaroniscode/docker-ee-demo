# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')

# Read the join token
echo "Reading the join token"
token=$(grep 'worker_token:' /vagrant/config.yaml \
  | awk '{ print $2}')

# Join the Swarm cluster
echo "Joining Swarm"
docker swarm join --token $token ucp.${tld}:2377
