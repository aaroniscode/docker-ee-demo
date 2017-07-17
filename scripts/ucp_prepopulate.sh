# Create users
# 0 = No Access, 1 = View Only, 2 = Restricted Control, 3 = Full Control
/vagrant/scripts/ucp_create_user.sh "april" "password" "April" 3
/vagrant/scripts/ucp_create_user.sh "bob" "password" "Bob" 3
/vagrant/scripts/ucp_create_user.sh "charlie" "password" "Charlie" 3
/vagrant/scripts/ucp_create_user.sh "victor" "password" "Victor" 1
/vagrant/scripts/ucp_create_user.sh "rachel" "password" "Rachel" 2

# Create teams
/vagrant/scripts/ucp_create_team.sh "development"
/vagrant/scripts/ucp_create_team.sh "qa"
/vagrant/scripts/ucp_create_team.sh "security"
