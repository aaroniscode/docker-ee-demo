# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
token=$(grep 'ucp_token:' /vagrant/config.yaml | awk '{ print $2}')

# Enable HRM
echo "Enabling HTTP Routing Mesh"
curl -sk -H "Authorization: Bearer $token" \
  -H "Content-Type: application/json;charset=UTF-8" \
  -d '{
      "HTTPPort": 8080,
      "HTTPSPort": 10443
    }', \
  "https://ucp.${tld}/api/hrm"
