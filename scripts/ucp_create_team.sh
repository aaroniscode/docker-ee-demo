# Variable Assignment
team_name=$1

token=$(curl -sk -d '{"username":"admin","password":"password"}' https://ucp.demo/auth/login | jq -r .auth_token)

curl -k -X POST -H "Authorization: Bearer $token" \
  --header "Content-Type: application/json;charset=UTF-8" \
  -d "{\"name\": \"${team_name}\"}", \
    "https://ucp.demo/enzi/v0/accounts/docker-datacenter/teams"
