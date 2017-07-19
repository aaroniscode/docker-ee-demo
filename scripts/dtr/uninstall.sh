# Variable Assignment
dtr_version=$(grep 'dtr_version:' /vagrant/config.yaml | awk '{ print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')
replica_id=$(docker ps | grep dtr-api | awk '{split($(NF), a, "-"); print a[3]}')
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')

echo "Uninstalling DTR"
docker run --rm docker/dtr:${dtr_version} destroy \
    --replica-id $replica_id \
    --ucp-url https://ucp.${tld} \
    --ucp-username admin \
    --ucp-password $password \
    --ucp-insecure-tls
