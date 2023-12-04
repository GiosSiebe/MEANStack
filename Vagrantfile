  # -*- mode: ruby -*-
# vi: set ft=ruby :


#This sets up the Vagrant configuration. The number "2" represents the configuration version and is not recommended to be changed unless you know what you're doing.
Vagrant.configure("2") do |config|

  #Specifies the base box for the virtual machine. In this case, it's using the "generic/ubuntu2204" box, which is an Ubuntu 22.04 LTS image.
  config.vm.box = "generic/ubuntu2204"

  #Configures the VirtualBox provider settings. It sets the VM name, memory (RAM) to 4096 MB, number of CPUs to 2, and enables the GUI.
  config.vm.provider "virtualbox" do |v|
      v.name = "Milestone2-Vagrant"
      v.memory = 4096
      v.cpus = 2
      v.gui = true
  end

  #Specifies that provisioning will be done using a shell script located at "script.sh".
  config.vm.provision "shell", path: "script.sh"

  #Creates a port forwarding rule, mapping port 80 on the guest machine to port 8080 on the host machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  #Creates a private network with a static IP address "192.168.56.5" for host-only access.
  config.vm.network "private_network", type: "static", ip: "192.168.56.5"

  #Syncs the current folder (where the Vagrantfile is located) with the "/vagrant" folder inside the virtual machine.
  config.vm.synced_folder ".", "/vagrant"
end
