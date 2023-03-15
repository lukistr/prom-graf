# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant"
  config.vm.box="luki_strike/Ubuntu"
  config.vm.box_version = "1.0.0"
  config.vm.provision "shell", path: "update.sh"
  config.vm.provision "shell", path: "docker.sh"
  config.vm.provider :virtualbox do |v|
	v.memory = 2560
	v.cpus = 1
  end

  config.vm.define "docker1" do |docker1|
    docker1.vm.hostname = "docker1.do1.lab"
    docker1.vm.network "private_network", ip: "192.168.11.101"
	docker1.vm.provision "shell", path: "docker1.sh"
  end
  
  config.vm.define "docker2" do |docker2|
    docker2.vm.hostname = "docker2.do1.lab"
    docker2.vm.network "private_network", ip: "192.168.11.102"
	docker2.vm.provision "shell", path: "docker2.sh"
  end
  
end