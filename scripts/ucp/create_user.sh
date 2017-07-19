# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{ print $2}')
user_name=$1
password=$2
full_name=$3
role=$4

curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"first_name\": \"${full_name}\",
      \"password\": \"${password}\",
      \"role\": $role,
      \"username\": \"${user_name}\"
    }", \
  "https://ucp.${tld}/api/accounts"
