# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
ucp_password=$(grep 'password:' /vagrant/config.yaml | awk '{ print $2}')

# Get an auth token
token=$(curl -sk -d "{\"username\":\"admin\",\"password\":\"${ucp_password}\"}" https://ucp.${tld}/auth/login | jq -r .auth_token)

# Write the ucp tokens to the config file
sed -i "s/^ucp_token:.*/ucp_token: $token/" /vagrant/config.yaml
