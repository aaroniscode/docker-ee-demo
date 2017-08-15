# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{print $2}')
name=$1
parent=$2

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"name\": \"${name}\",
      \"parent_id\": \"${parent}\"
    }", \
  https://ucp.${tld}/collections
