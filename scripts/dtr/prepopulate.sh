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
