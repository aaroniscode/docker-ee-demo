# Trust DTR Cert
openssl s_client -connect dtr.vm:443 -showcerts </dev/null 2>/dev/null \
    | openssl x509 -outform PEM \
    | sudo tee /usr/local/share/ca-certificates/dtr.vm.crt
sudo update-ca-certificates

# Download Client bundle
AUTHTOKEN=$(curl -sk -d '{"username":"admin","password":"password"}' https://ucp.vm/auth/login | jq -r .auth_token)
curl -k -H "Authorization: Bearer $AUTHTOKEN" https://ucp.vm/api/clientbundle -o /var/jenkins_home/bundle.zip
unzip /var/jenkins_home/bundle.zip -d /var/jenkins_home/.docker

sudo sed -i "\$aexport DOCKER_TLS_VERIFY=1\nexport DOCKER_HOST=tcp://ucp.vm:443" /etc/profile

#sudo cat <<EOT >> /etc/profile
#export DOCKER_TLS_VERIFY=1
#export DOCKER_HOST=tcp://ucp.vm:443
#EOT
