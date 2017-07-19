# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{ print $2}')
team_id=$1
label=$2
permission=$3

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d $permission \
  https://ucp.${tld}/api/teamlabels/${team_id}/${label}
