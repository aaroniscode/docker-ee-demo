# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{print $2}')
org=$1
team=$2
user=$3

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{}" \
  -X PUT https://ucp.${tld}/accounts/{$org}/teams/${team}/members/${user}
