# -*- mode: ruby -*-
# vi: set ft=ruby :
require 'yaml'

abort "landrush required, TYPE vagrant plugin install landrush" unless Vagrant.has_plugin?("landrush")
abort "vagrant-triggers required, TYPE vagrant plugin install vagrant-triggers" unless Vagrant.has_plugin?("vagrant-triggers")

unless File.exists? ("#{File.dirname(__FILE__)}/config.yaml")
  FileUtils.cp("#{File.dirname(__FILE__)}/config.yaml.example", "#{File.dirname(__FILE__)}/config.yaml")
  abort "Example config.yaml copied. You MUST update with your EE License and URL"
end

# YAML config section
yaml_config = YAML::load(File.read("#{File.dirname(__FILE__)}/config.yaml"))
dtr_version = yaml_config['dtr_version']
ee_url = yaml_config['ee_url']
ee_version = yaml_config['ee_version']
license = yaml_config['license'].to_json
password = yaml_config['password']
tld = yaml_config['tld']
ucp_version = yaml_config['ucp_version']

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  # Cache the apt packages for fast builds
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      owner: "_apt",
      mount_options: ["dmode=777", "fmode=666"]
    }
  end

  # Network configuration
  config.vm.network "private_network", type: "dhcp"
  config.landrush.enabled = true
  config.landrush.tld = tld
  config.landrush.guest_redirect_dns = false
  config.landrush.host_interface_excludes = [
    /lo[0-9]*/, /docker[0-9]+/, /tun[0-9]+/, /docker_gwbridge/
  ]

  config.vm.provider "virtualbox" do |vb|
    # Give each vm 2GB RAM
    vb.memory = 2048
    # Redirect vm dns queries to landrush dns server
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    # Sync the vm clock if skew is > 1 second (1000 ms)
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 1000]
  end

  # Install Docker Engine on all vms
  config.vm.provision "shell", args: [ee_url, ee_version], path: "scripts/install_docker_engine.sh"

  # Manager (UCP and DTR)
  config.vm.define "manager1" do |manager1|
    manager1.vm.hostname = "manager1.#{tld}"

    manager1.vm.provision "trigger" do |trigger|
      trigger.fire do
        run "vagrant landrush set ucp.#{tld} manager1.#{tld}"
        run "vagrant landrush set dtr.#{tld} manager1.#{tld}"
      end
    end

    manager1.vm.provision "shell", path: "scripts/install_haproxy.sh"
    manager1.vm.provision "shell", path: "scripts/ucp/install.sh"
    manager1.vm.provision "shell", path: "scripts/ucp/configure.sh"
    manager1.vm.provision "shell", path: "scripts/ucp/prepopulate.sh"
    manager1.vm.provision "shell", path: "scripts/dtr/install.sh"
    manager1.vm.provision "shell", path: "scripts/dtr/configure.sh"
    manager1.vm.provision "shell", path: "scripts/dtr/prepopulate.sh"
  end

  # Worker nodes
  config.vm.define "worker1" do |worker1|
    worker1.vm.hostname = "worker1.#{tld}"
    worker1.vm.provision "shell", path: "scripts/join_swarm.sh"
  end

  config.vm.define "worker2" do |worker2|
    worker2.vm.hostname = "worker2.#{tld}"
    worker2.vm.provision "shell", path: "scripts/join_swarm.sh"
  end

  config.vm.define "worker3" do |worker3|
    worker3.vm.hostname = "worker3.#{tld}"
    worker3.vm.provision "shell", path: "scripts/join_swarm.sh"
  end

end
