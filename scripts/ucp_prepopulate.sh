# Get an auth token and save in config.yaml
/vagrant/scripts/ucp_get_token.sh

# Create users
# 0 = No Access, 1 = View Only, 2 = Restricted Control, 3 = Full Control
echo "Populating UCP with sample users"
/vagrant/scripts/ucp_create_user.sh "april" "password" "April" 2
/vagrant/scripts/ucp_create_user.sh "bob" "password" "Bob" 2
/vagrant/scripts/ucp_create_user.sh "charlie" "password" "Charlie" 2
/vagrant/scripts/ucp_create_user.sh "victor" "password" "Victor" 1
/vagrant/scripts/ucp_create_user.sh "felicity" "password" "Felicity" 3
/vagrant/scripts/ucp_create_user.sh "frank" "password" "Frank" 3

# Create teams
echo "Populating UCP with sample teams"
dev_id=$(/vagrant/scripts/ucp_create_team.sh "development" | jq -r .id)
qa_id=$(/vagrant/scripts/ucp_create_team.sh "qa" | jq -r .id)
ops_id=$(/vagrant/scripts/ucp_create_team.sh "operations" | jq -r .id)
sec_id=$(/vagrant/scripts/ucp_create_team.sh  "security" | jq -r .id)

# Add April, Bob and Charlie to the dev team
echo "Adding April, Bob and Charlie to the Development team"
/vagrant/scripts/ucp_add_user_to_team.sh $dev_id "april"
/vagrant/scripts/ucp_add_user_to_team.sh $dev_id "bob"
/vagrant/scripts/ucp_add_user_to_team.sh $dev_id "charlie"

echo "Adding (View only) Victor to the QA team"
/vagrant/scripts/ucp_add_user_to_team.sh $qa_id "victor"

echo "Adding (Full Control) Felicity to the Security team"
/vagrant/scripts/ucp_add_user_to_team.sh $sec_id "felicity"

echo "Adding (Full Control) Frank to the Operations team"
/vagrant/scripts/ucp_add_user_to_team.sh $ops_id "frank"
