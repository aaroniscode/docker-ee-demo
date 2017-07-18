# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{ print $2}')
org_name=$1
repo_name=$2
visibility=$3
description=$4

curl -sk -H "Content-Type: application/json;charset=UTF-8" \
  --user admin:${password} \
  -d "{
      \"name\": \"${repo_name}\",
      \"scanOnPush\": false,
      \"shortDescription\": \"${description}\",
      \"visibility\": \"${visibility}\"
    }", \
  "https://dtr.${tld}/api/v0/repositories/${org_name}"
