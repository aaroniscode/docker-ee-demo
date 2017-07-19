# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')

# Enable Scanning
echo "Enabling Image Scanning in DTR"
curl -sk -H "Content-Type: application/json;charset=UTF-8" \
  --user admin:${password} \
  -d '{"scanningEnabled": true}', \
  "https://dtr.${tld}/api/v0/meta/settings"
