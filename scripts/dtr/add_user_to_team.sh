# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{ print $2}')
org_name=$1
team_name=$2
user_name=$3

curl -sk -X PUT -H "Content-Type: application/json;charset=UTF-8" \
  --user admin:${password} \
  "https://dtr.${tld}/api/v0/accounts/${org_name}/teams/${team_name}/members/${user_name}"
