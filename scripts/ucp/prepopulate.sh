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
dev_id=$(/vagrant/scripts/ucp/create_team.sh "development" | jq -r .id)
qa_id=$(/vagrant/scripts/ucp/create_team.sh "qa" | jq -r .id)
ops_id=$(/vagrant/scripts/ucp/create_team.sh "operations" | jq -r .id)
sec_id=$(/vagrant/scripts/ucp/create_team.sh  "security" | jq -r .id)

# Add UCP Access Labels
# 0 = No Access, 1 = View Only, 2 = Restricted Control, 3 = Full Control
echo "Assigning Access Labels to Teams"
/vagrant/scripts/ucp/add_access_label_to_team.sh $dev_id "dev" 3
/vagrant/scripts/ucp/add_access_label_to_team.sh $dev_id "qa" 1
/vagrant/scripts/ucp/add_access_label_to_team.sh $dev_id "prod" 0
/vagrant/scripts/ucp/add_access_label_to_team.sh $ops_id "dev" 3
/vagrant/scripts/ucp/add_access_label_to_team.sh $ops_id "qa" 3
/vagrant/scripts/ucp/add_access_label_to_team.sh $ops_id "prod" 3
/vagrant/scripts/ucp/add_access_label_to_team.sh $qa_id "jenkins" 2
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "dev" 1
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "qa" 1
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "prod" 1

# Add Betty, Charlie and Dave to the dev team
echo "Adding Betty, Charlie and Dave to the Development team"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "betty"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "charlie"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "dave"

echo "Adding Owen to the Operations team"
/vagrant/scripts/ucp/add_user_to_team.sh $ops_id "owen"

echo "Adding Jenkins to the QA team"
/vagrant/scripts/ucp/add_user_to_team.sh $qa_id "jenkins"

echo "Adding Sarah to the Security team"
/vagrant/scripts/ucp/add_user_to_team.sh $sec_id "sarah"

# Create secrets
echo "Populating UCP with sample secrets"
/vagrant/scripts/ucp/create_secret.sh "DEV_DB_PASS" "pa55w0rd" "dev"
/vagrant/scripts/ucp/create_secret.sh "PROD_DB_PASS" "12345" "prod"
/vagrant/scripts/ucp/create_secret.sh "AWS_ACCESS_KEY" "AKIAIOSFODNN7EXAMPLE" "prod"
/vagrant/scripts/ucp/create_secret.sh "AWS_ACCESS_SECRET" "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY" "prod"
