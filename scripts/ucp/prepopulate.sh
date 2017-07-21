# Get an auth token and save in config.yaml
/vagrant/scripts/ucp/get_auth_token.sh

# Create users
# 0 = No Access, 1 = View Only, 2 = Restricted Control, 3 = Full Control
echo "Populating UCP with sample users"
/vagrant/scripts/ucp/create_user.sh "april" "password" "April" 0
/vagrant/scripts/ucp/create_user.sh "bob" "password" "Bob" 0
/vagrant/scripts/ucp/create_user.sh "charlie" "password" "Charlie" 0
/vagrant/scripts/ucp/create_user.sh "owen" "password" "Owen" 0
/vagrant/scripts/ucp/create_user.sh "quin" "password" "Quin" 0
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
/vagrant/scripts/ucp/add_access_label_to_team.sh $qa_id "qa" 2
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "dev" 1
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "qa" 1
/vagrant/scripts/ucp/add_access_label_to_team.sh $sec_id "prod" 1

# Add April, Bob and Charlie to the dev team
echo "Adding April, Bob and Charlie to the Development team"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "april"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "bob"
/vagrant/scripts/ucp/add_user_to_team.sh $dev_id "charlie"

echo "Adding Owen to the Operations team"
/vagrant/scripts/ucp/add_user_to_team.sh $ops_id "owen"

echo "Adding Quin to the QA team"
/vagrant/scripts/ucp/add_user_to_team.sh $qa_id "quin"

echo "Adding Sarah to the Security team"
/vagrant/scripts/ucp/add_user_to_team.sh $sec_id "sarah"
