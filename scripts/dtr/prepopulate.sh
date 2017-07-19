# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{ print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{ print $2}')

# Get an auth token and save in config.yaml
/vagrant/scripts/get_ucp_token.sh

# Create organizations
echo "Populating DTR with sample organizations"
/vagrant/scripts/dtr/create_organization.sh "it"
/vagrant/scripts/dtr/create_organization.sh "dev"
/vagrant/scripts/dtr/create_organization.sh "prod"

# Create teams
echo "Populating DTR with sample teams"
/vagrant/scripts/dtr/create_team.sh "it" "it"
/vagrant/scripts/dtr/create_team.sh "dev" "dev"
/vagrant/scripts/dtr/create_team.sh "prod" "prod"

# Add April, Bob and Charlie to the dev team
echo "Adding April, Bob and Charlie to the dev team"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "april"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "bob"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "charlie"

# Create repositories
echo "Populating DTR with sample repositories"
/vagrant/scripts/dtr/create_repo.sh "it" "nginx" "public" "IT approved NGINX"
/vagrant/scripts/dtr/create_repo.sh "it" "node" "public" "IT approved Node.js"
/vagrant/scripts/dtr/create_repo.sh "dev" "node-web-app" "public"
/vagrant/scripts/dtr/create_repo.sh "prod" "node-web-app" "public"

# Add team access to repositories
echo "Adding team access to repositories"
/vagrant/scripts/dtr/add_repo_to_team.sh "dev" "node-web-app" "dev" "read-write"

# Populate repositories with images
echo "Loading images in DTR"
docker login dtr.${tld} -u admin -p ${password}
docker pull nginx
docker pull node
docker pull bkauf/node-web-app
docker tag nginx dtr.${tld}/it/nginx
docker tag node dtr.${tld}/it/node
docker tag bkauf/node-web-app dtr.${tld}/dev/node-web-app
docker push dtr.${tld}/it/nginx
docker push dtr.${tld}/it/node
docker push dtr.${tld}/dev/node-web-app
