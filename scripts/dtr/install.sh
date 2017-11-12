# Variable Assignment
dtr_version=$(grep 'dtr_version:' /vagrant/config.yaml | awk '{print $2}')
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')

# Vagrant workaround, docker run without a cached image
# colors output red which looks like an error
echo "Pulling DTR image"
docker pull docker/dtr:${dtr_version}

echo "Installing DTR"
docker run --rm docker/dtr:${dtr_version} install \
    --ucp-node manager1 \
    --replica-http-port 8080 \
    --replica-https-port 9443 \
    --ucp-insecure-tls \
    --dtr-external-url https://dtr.${tld} \
    --ucp-url https://ucp.${tld} \
    --ucp-username admin \
    --ucp-password $password

# Store DTR's self-signed certificate
echo "Storing DTR's certificate"
curl -sk https://dtr.${tld}/ca -o /vagrant/certs/dtr.crt
