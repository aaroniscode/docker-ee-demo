# Setup Docker to use local registry mirror to speed up installs
sudo mkdir -m 600 /etc/docker
sudo sh -c "echo '{
  \"registry-mirrors\": [\"http://172.28.128.1:5000\"]
}'" >> /etc/docker/daemon.json

# Install Docker EE
echo "Installing Docker Engine"
docker_ee_url=$(cat /vagrant/userdata/docker_ee_url)

# Add Docker's official GPG key
curl -fsSL ${docker_ee_url}/gpg | sudo apt-key add -

# Setup the Docker EE stable repository
sudo add-apt-repository \
    "deb [arch=amd64] $docker_ee_url \
    $(lsb_release -cs) \
    stable-17.03"

# Update the apt package index
sudo apt-get update

# Install Docker EE
sudo apt-get install -y docker-ee

# Allow docker commands to run without sudo
# Add vagrant to the "docker" group
sudo usermod -aG docker vagrant
