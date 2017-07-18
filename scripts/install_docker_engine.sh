# Variable Assignment
docker_ee_url=$1
ee_version=$2

# Setup Docker to use local registry mirror to speed up installs
echo "Configuring Docker to use local registry mirror"
sudo mkdir -m 600 /etc/docker
sudo sh -c "echo '{
  \"registry-mirrors\": [\"http://172.28.128.1:5000\"]
}'" >> /etc/docker/daemon.json

# Add Docker's official GPG key
echo "Adding Docker's GPG key"
curl -fsSL ${docker_ee_url}/ubuntu/gpg | sudo apt-key add -

# Setup the Docker EE stable repository
echo "Adding Docker EE repository to Apt"
sudo add-apt-repository \
    "deb [arch=amd64] ${docker_ee_url}/ubuntu \
    $(lsb_release -cs) \
    ${ee_version}"

# Update the apt package index
echo "Running apt-get update"
sudo apt-get update

# Install Docker EE
echo "Installing Docker Engine"
sudo apt-get install -y jq docker-ee

# Allow docker commands to run without sudo
# Add vagrant to the "docker" group
sudo usermod -aG docker vagrant
