# Variable Assignment
user_name=$1
password=$2
full_name=$3
role=$4

token=$(curl -sk -d '{"username":"admin","password":"password"}' https://ucp.demo/auth/login | jq -r .auth_token)

curl -k -X POST -H "Authorization: Bearer $token" \
  --header "Content-Type: application/json;charset=UTF-8" \
  -d "{
      \"first_name\": \"${full_name}\",
      \"password\": \"${password}\",
      \"role\": $role,
      \"username\": \"${user_name}\"
    }", \
    "https://ucp.demo/api/accounts"
