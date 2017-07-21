# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{print $2}')
org_name=$1
team_name=$2

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"name\": \"${team_name}\",
      \"type\": \"managed\"
    }", \
  "https://ucp.${tld}/enzi/v0/accounts/${org_name}/teams"
