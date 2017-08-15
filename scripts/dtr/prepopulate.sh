# Variable Assignment
tld=$(grep 'tld:' /vagrant/config.yaml | awk '{print $2}')
password=$(grep 'password:' /vagrant/config.yaml | awk '{print $2}')

# Get an auth token and save in config.yaml
/vagrant/scripts/ucp/get_auth_token.sh

# Create organizations
echo "Populating DTR with sample organizations"
/vagrant/scripts/dtr/create_organization.sh "dev"
/vagrant/scripts/dtr/create_organization.sh "prod"
/vagrant/scripts/dtr/create_organization.sh "secops"

# Create teams
echo "Populating DTR with sample teams"
/vagrant/scripts/dtr/create_team.sh "dev" "dev"
/vagrant/scripts/dtr/create_team.sh "prod" "prod"
/vagrant/scripts/dtr/create_team.sh "secops" "secops"

# Add April, Bob and Charlie to the dev team
echo "Adding Betty, Charlie and Dave to the dev team"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "betty"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "charlie"
/vagrant/scripts/dtr/add_user_to_team.sh "dev" "dev" "dave"

# Add Owen (Operations) to the prod and secops team
echo "Adding Owen to the prod and SecOps team"
/vagrant/scripts/dtr/add_user_to_team.sh "prod" "prod" "owen"
/vagrant/scripts/dtr/add_user_to_team.sh "secops" "secops" "owen"

# Add Sarah (Security) to the secops team
echo "Adding Sarah to the SecOps team"
/vagrant/scripts/dtr/add_user_to_team.sh "secops" "secops" "sarah"

# Create repositories
echo "Populating DTR with sample repositories"
/vagrant/scripts/dtr/create_repo.sh "secops" "alpine" "public"
/vagrant/scripts/dtr/create_repo.sh "secops" "nginx" "public"
/vagrant/scripts/dtr/create_repo.sh "dev" "whalesay" "public"
/vagrant/scripts/dtr/create_repo.sh "dev" "nginx-hello-world" "public"
/vagrant/scripts/dtr/create_repo.sh "prod" "flask-demo" "public"

# Add team access to repositories
echo "Adding team access to repositories"
/vagrant/scripts/dtr/add_repo_to_team.sh "secops" "alpine" "secops" "read-write"
/vagrant/scripts/dtr/add_repo_to_team.sh "secops" "nginx" "secops" "read-write"
/vagrant/scripts/dtr/add_repo_to_team.sh "dev" "whalesay" "dev" "read-write"
/vagrant/scripts/dtr/add_repo_to_team.sh "dev" "nginx-hello-world" "dev" "read-write"
/vagrant/scripts/dtr/add_repo_to_team.sh "prod" "flask-demo" "prod" "read-write"

# Populate repositories with images
echo "Loading images in DTR"
docker login dtr.${tld} -u admin -p ${password}
# Alpine
docker pull alpine:3.5
docker pull alpine:3.6
docker tag alpine:3.5 dtr.${tld}/secops/alpine:3.5
docker tag alpine:3.6 dtr.${tld}/secops/alpine:3.6
docker push dtr.${tld}/secops/alpine:3.5
docker push dtr.${tld}/secops/alpine:3.6
# Nginx
docker pull nginx:alpine
docker tag nginx:alpine dtr.${tld}/secops/nginx
docker push dtr.${tld}/secops/nginx
# dev/whalesay
docker pull dockeramiller/whalesay
docker tag dockeramiller/whalesay dtr.${tld}/dev/whalesay
docker push dtr.${tld}/dev/whalesay
# prod/flask-demo
docker pull dockeramiller/flask-demo
docker tag dockeramiller/flask-demo dtr.${tld}/prod/flask-demo
docker push dtr.${tld}/prod/flask-demo
