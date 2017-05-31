# -*- mode: ruby -*-
# vi: set ft=ruby :
abort "Vagrant plugin landrush required" unless Vagrant.has_plugin?("landrush")

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-16.04"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.synced_folder_opts = {
      owner: "_apt"
    }
  end

  config.vm.provider "virtualbox" do |v|
    v.memory = 2048
  end

  # Network configuration
  config.vm.network "private_network", type: "dhcp"
  config.landrush.enabled = true
  config.landrush.tld = 'vm'
  config.landrush.guest_redirect_dns = false
  config.landrush.host_interface_excludes = [
    /lo[0-9]*/, /docker[0-9]+/, /tun[0-9]+/, /docker_gwbridge/
  ]

  # This will redirect vm dns queries to landrush dns server
  config.vm.provider "virtualbox" do |v|
     v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  $docker_ee_url = File.read("userdata/docker_ee_url")

  # Install Docker Engine on all vms
  config.vm.provision "shell", args: [$docker_ee_url], path: "scripts/install_docker_engine.sh"

  # UCP
  config.vm.define "ucp" do |ucp|
    ucp.vm.hostname = "ucp.vm"
    $license =  File.read("userdata/docker_subscription.lic")
    ucp.vm.provision "shell", args: [$license], path: "scripts/install_ucp.sh"
  end

  $token =  File.read("rundata/swarm-join-token-worker")

  # DTR
  config.vm.define "dtr" do |dtr|
    dtr.vm.hostname = "dtr.vm"
    dtr.vm.provision "shell", args: [$token], path: "scripts/join_swarm.sh"
    dtr.vm.provision "shell", path: "scripts/install_dtr.sh"
  end

  # Worker nodes
  config.vm.define "node1" do |node1|
    node1.vm.hostname = "node1.vm"
    node1.vm.provision "shell", args: [$token], path: "scripts/join_swarm.sh"
  end

  config.vm.define "node2" do |node2|
    node2.vm.hostname = "node2.vm"
    node2.vm.provision "shell", args: [$token], path: "scripts/join_swarm.sh"
  end

  config.vm.define "node3" do |node3|
    node3.vm.hostname = "node3.vm"
    node3.vm.provision "shell", args: [$token], path: "scripts/join_swarm.sh"
  end

end
