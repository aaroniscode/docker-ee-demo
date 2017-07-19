# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')
org_name=$1
repo_name=$2
team_name=$3
access_level=$4

curl -sk --user admin:${password} \
  -H "Content-Type: application/json;charset=UTF-8" \
  -X PUT \
  -d "{\"accessLevel\": \"${access_level}\"}", \
  "https://dtr.${tld}/api/v0/repositories/${org_name}/${repo_name}/teamAccess/${team_name}"
