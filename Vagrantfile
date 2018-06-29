# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

#Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vm.provider "virtualbox" do |v|
#    v.customize ["modifyvm", :id, "--memory", 512]
#  end
#
#  config.vm.define "k8s-master" do |centos|
#    centos.vm.box = "centos/7"
#    centos.vm.hostname = 'k8s-master'
#    centos.vm.box_url = "centos/7"
#
#    centos.vm.network :private_network, ip: "192.168.56.102"
#
#    centos.vm.provider :virtualbox do |v|
#      v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
#      v.customize ["modifyvm", :id, "--memory", 512]
#    end
#
#    centos.vm.provision :ansible do |ansible|
#      ansible.extra_vars = {
#        user: "vagrant",
#      }
#      ansible.playbook = "site.yml"
#    end
#  end
#
#end
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

#  config.vm.provider "virtualbox" do |v|
#    v.customize ["modifyvm", :id, "--memory", 512]
#  end

  N = 4
  (1..N).each do |machine_id|
    config.vm.define "machine#{machine_id}" do |machine|
      machine.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--memory", 2048]
      end
      machine.vm.box = "centos/7"
      machine.vm.hostname = "machine#{machine_id}"
      machine.vm.network "private_network", ip: "192.168.56.#{102+machine_id-1}"

      # Only execute once the Ansible provisioner,
      # when all the machines are up and ready.
      if machine_id == N
        machine.vm.provision :ansible do |ansible|
          # Disable default limit to connect to all the machines
          ansible.limit = "all"
          ansible.extra_vars = {
            user: "vagrant",
          }
          ansible.groups = {
            "k8s-primary-master" => [
              "machine1"
            ],
            "k8s-masters" => [
            ],
            "k8s-workers" => [
              "machine2",
              "machine3",
              "machine4",
            ]
          }
          ansible.playbook = "site.yml"
        end
      end
    end
  end
end
