Vagrant.configure("2") do |config|

    # Box to create VM from
    config.vm.box = "devopsgroup-io/windows_server-2012r2-standard-amd64-nocm"

    # Set VM guest OS type
    config.vm.guest = :windows
    
    # Communicator type to use with guest VM
    config.vm.communicator = "winrm"
    
    # Username to use WinRM
    config.winrm.username = "vagrant"
    
    # Password to use WinRM
    config.winrm.password = "vagrant"

    # Set VM hostname
    config.vm.hostname = "DevSrv01"

    # Execute external script
    config.vm.provision "shell", path: "script.ps1" 

    # Seconds to wait during gracefull halt
    config.windows.halt_timeout = "120"

    # Message after vagrant up
    config.vm.post_up_message = "Development Server is Ready"

end