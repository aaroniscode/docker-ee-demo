# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{print $2}')
secret=$1
data=$2
collection=$3

data=`echo $data | base64`

labels="{\"com.docker.ucp.access.label\": \"${collection}\"}"

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"Name\": \"${secret}\",
      \"Data\": \"${data}\",
      \"Labels\": ${labels}
    }", \
  https://ucp.${tld}/secrets/create
