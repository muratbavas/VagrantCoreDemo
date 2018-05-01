# VagrantCoreDemo

This project is an empty dotnet core application running on VirtualBox using Vagrant. 

Empty dotnet core application project created from [This link](https://social.technet.microsoft.com/wiki/contents/articles/40043.asp-net-core-2-0-mvc-from-scratch-empty-web-project-in-vs-code.aspx).

# Requirement list to get your Development Server Ready

## Following steps will be applying to your Local Computer;

`!!! Imported Notice !!!`

`Check your computer disk space for download and running a VM. Image size is ~15 GB and also Vagrant VM size is ~25 GB.`

### Oracle VirtualBox Installation
Install VirtualBox application to your local computer on the [Oracle VirtualBox web site](https://www.virtualbox.org/wiki/Downloads).

### Vagrant Installation
Install Vagrant application to your local computer on the [Vagrant web site](https://www.vagrantup.com/downloads.html).

### Git Installation
Install git application to your local computer on the [Git web site](https://git-scm.com/downloads).


## Run the Vagrant

type the following commands in cmd on the Project file path 
```
vagrant init devopsgroup-io/windows_server-2012r2-standard-amd64-nocm
vagrant up
```

## Following steps will be applying to VirtualBox VM;
VirtualBox server needs internet connection to download and install automaticaly DotNet-SDK, Git and other dependence applications from internet.

Clone Project from Git
```
C:\MyApp\gitclone.bat
```

Pull Project from Git
```
C:\MyApp\gitpull.bat
```

Anytime to see project output, use the CoreDotnetProject.url file on the desktop.