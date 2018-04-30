# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "devopsgroup-io/windows_server-2012r2-standard-amd64-nocm"

  # Set VM guest OS type
  config.vm.guest = :windows

  # Execute external script
  config.vm.provision "shell", path: "script.ps1" 

  # Message after vagrant up
  config.vm.post_up_message = "Development Server is Ready"
end
