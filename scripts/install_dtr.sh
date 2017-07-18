# Variable Assignment
dtr_version=$1
tld=$2
password=$3

# Vagrant workaround, docker run without a cached image
# colors output red which looks like an error
echo "Pulling DTR image"
docker pull docker/dtr:${dtr_version}

#echo "Installing DTR"
docker run --rm docker/dtr:${dtr_version} install \
    --ucp-node manager1.${tld} \
    --replica-http-port 8080 \
    --replica-https-port 9443 \
    --ucp-insecure-tls \
    --dtr-external-url https://dtr.${tld} \
    --ucp-url https://ucp.${tld} \
    --ucp-username admin \
    --ucp-password $password
