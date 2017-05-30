# Join the Swarm cluster
echo "Joining Swarm"
docker swarm join --token $1 ucp.vm:2377
