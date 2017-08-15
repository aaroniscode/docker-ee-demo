# Get an auth token and save in config.yaml
/vagrant/scripts/ucp/get_auth_token.sh

# Create users
# 0 = No Access, 1 = View Only, 2 = Restricted Control, 3 = Full Control
echo "Populating UCP with sample users"
/vagrant/scripts/ucp/create_user.sh "betty" "password" "Betty" 0
/vagrant/scripts/ucp/create_user.sh "charlie" "password" "Charlie" 0
/vagrant/scripts/ucp/create_user.sh "dave" "password" "Dave" 0
/vagrant/scripts/ucp/create_user.sh "owen" "password" "Owen" 0
/vagrant/scripts/ucp/create_user.sh "jenkins" "password" "Jenkins" 0
/vagrant/scripts/ucp/create_user.sh "sarah" "password" "Sarah" 0

# Create teams
echo "Populating UCP with sample teams"
development_team=$(/vagrant/scripts/ucp/create_team.sh "development" | jq -r .id)
ops_team=$(/vagrant/scripts/ucp/create_team.sh "operations" | jq -r .id)
qa_team=$(/vagrant/scripts/ucp/create_team.sh "qa" | jq -r .id)
security_team=$(/vagrant/scripts/ucp/create_team.sh  "security" | jq -r .id)

# Add Betty, Charlie and Dave to the dev team
echo "Adding Betty, Charlie and Dave to the Development team"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "development" "betty"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "development" "charlie"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "development" "dave"

echo "Adding Owen to the Operations team"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "operations" "owen"

echo "Adding Jenkins to the QA team"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "qa" "jenkins"

echo "Adding Sarah to the Security team"
/vagrant/scripts/ucp/add_user_to_team.sh "docker-datacenter" "security" "sarah"

# Create collections
echo "Populating UCP with sample collections"
dev_collection=$(/vagrant/scripts/ucp/create_collection.sh "dev" "swarm" | jq -r .id)
qa_collection=$(/vagrant/scripts/ucp/create_collection.sh "qa" "swarm" | jq -r .id)
prod_collection=$(/vagrant/scripts/ucp/create_collection.sh "prod" "swarm" | jq -r .id)

# Create secrets
echo "Populating UCP with sample secrets"
/vagrant/scripts/ucp/create_secret.sh "DEV_DB_PASS" "pa55w0rd" "/dev"
/vagrant/scripts/ucp/create_secret.sh "PROD_DB_PASS" "12345" "/prod"
/vagrant/scripts/ucp/create_secret.sh "AWS_ACCESS_KEY" "AKIAIOSFODNN7EXAMPLE" "/prod"
/vagrant/scripts/ucp/create_secret.sh "AWS_ACCESS_SECRET" "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" "/prod"

# Create grants
echo "Creating grants assigning collections with roles to teams"
/vagrant/scripts/ucp/create_grant.sh $development_team $dev_collection "fullcontrol"
/vagrant/scripts/ucp/create_grant.sh $qa_team $dev_collection "restrictedcontrol"
/vagrant/scripts/ucp/create_grant.sh $development_team $dev_collection "fullcontrol"
/vagrant/scripts/ucp/create_grant.sh $ops_team $dev_collection "fullcontrol"
/vagrant/scripts/ucp/create_grant.sh $ops_team $qa_collection "fullcontrol"
/vagrant/scripts/ucp/create_grant.sh $ops_team $prod_collection "fullcontrol"
/vagrant/scripts/ucp/create_grant.sh $qa_team $qa_collection "restrictedcontrol"
/vagrant/scripts/ucp/create_grant.sh $security_team $dev_collection "viewonly"
/vagrant/scripts/ucp/create_grant.sh $security_team $qa_collection "viewonly"
/vagrant/scripts/ucp/create_grant.sh $security_team $prod_collection "viewonly"
