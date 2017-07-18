# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{ print $2}')
org_name=$1

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"isOrg\": true,
      \"name\": \"${org_name}\"
    }", \
  "https://ucp.${tld}/enzi/v0/accounts"
