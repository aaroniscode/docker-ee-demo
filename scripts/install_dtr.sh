# Give time for the join to complete
echo "Waiting for swarm node registration to complete..."
sleep 30

# Install DTR
echo "Installing DTR"
docker run --rm docker/dtr:2.2.4 install \
    --ucp-node dtr \
    --ucp-insecure-tls \
    --dtr-external-url https://dtr.vm \
    --ucp-url https://ucp.vm \
    --ucp-username admin \
    --ucp-password password
