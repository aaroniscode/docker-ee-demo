# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{ print $2}')
team_id=$1
user=$2

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -X PUT https://ucp.${tld}/api/teams/${team_id}/members/add/${user}
