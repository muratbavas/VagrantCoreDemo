<#
.SYNOPSIS
  <Install Default Applicatin on Vagrant VM Server>
.DESCRIPTION
  <Download all PreRequest application and component from Internet and Install automatically at first time.>
.NOTES
  Version:        1.3
  Author:         Murat Dogan Bavas
  Creation Date:  2018.04.28
  #>

#-----------------------------------------------------------[Execution]------------------------------------------------------------

## Set TimeZone to Istanbul GMT+3
tzutil.exe /s "Turkey Standard Time"

## Create a new folder name "MyApp" under C: Drive
Mkdir C:/MyApp

## Go To C:\MyApp path on cmd
cd "C:\MyApp"

## Set Tls version to 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]'Tls12'

## Download DotNet-sdk-2.1.105 x64 under C:\MyApp
Invoke-WebRequest 'https://download.microsoft.com/download/2/E/C/2EC018A0-A0FC-40A2-849D-AA692F68349E/dotnet-sdk-2.1.105-win-x64.exe' -OutFile C:\MyApp\dotnet-sdk-2.1.105-win-x64.exe

## Download Git 2.17 x64 under C:\MyApp
Invoke-WebRequest 'https://github.com/git-for-windows/git/releases/download/v2.17.0.windows.1/Git-2.17.0-64-bit.exe' -OutFile C:\MyApp\Git-2.17.0-64-bit.exe

## Download Web Platform Installer
Invoke-WebRequest 'http://download.microsoft.com/download/C/F/F/CFF3A0B8-99D4-41A2-AE1A-496C08BEB904/WebPlatformInstaller_amd64_en-US.msi' -OutFile C:\MyApp\WebPlatformInstaller_amd64_en-US.msi

## Download ARR
Invoke-WebRequest 'http://download.microsoft.com/download/E/9/8/E9849D6A-020E-47E4-9FD0-A023E99B54EB/requestRouter_amd64.msi' -OutFile C:\MyApp\requestRouter_amd64.msi

## Download ReWrite
Invoke-WebRequest 'http://download.microsoft.com/download/6/7/D/67D80164-7DD0-48AF-86E3-DE7A182D6815/rewrite_amd64_en-US.msi' -OutFile C:\MyApp\rewrite_amd64_en-US.msi

## Download Web Deploy
Invoke-WebRequest 'https://download.microsoft.com/download/8/9/B/89B754A5-56F7-45BD-B074-8974FD2039AF/WebDeploy_2_10_amd64_en-US.msi' -OutFile C:\MyApp\WebDeploy_2_10_amd64_en-US.msi

## Enable IIS default feature
Add-WindowsFeature web-server -IncludeManagementTools

## Install for DotNet-SDK
Start-Process 'C:\MyApp\dotnet-sdk-2.1.105-win-x64.exe' /passive -PassThru | Wait-Process

## Install for Git
Start-Process 'C:\MyApp\Git-2.17.0-64-bit.exe' /Silent -PassThru | Wait-Process

## Install Web Platform
Start-Process 'C:/MyApp/WebPlatformInstaller_amd64_en-US.msi' '/qn' -PassThru | Wait-Process

## Install for URL ReWrite
Start-Process 'C:\MyApp\rewrite_amd64_en-US.msi' '/qn' -PassThru | Wait-Process

## Install for WebDeploy
Start-Process 'C:\MyApp\WebDeploy_2_10_amd64_en-US.msi' /passive -PassThru | Wait-Process

## Install for ARR
Start-Process 'C:\MyApp\requestRouter_amd64.msi' '/qn' -PassThru | Wait-Process

## enable AAR Proxy
Set-WebConfigurationProperty -pspath 'MACHINE/WEBROOT/APPHOST' -filter "system.webServer/proxy" -name "enabled" -value "True"

## Create URL Rewrite Rules
Add-WebConfigurationProperty -PSPath 'IIS:\Sites\Default Web Site' -filter 'system.webServer/rewrite/rules' -name '.' -value @{name="TestRule1"; patterSyntax='Regular Expressions'; stopProcessing='True'};
Set-WebConfigurationProperty -PSPath 'IIS:\Sites\Default Web Site' -filter "system.webServer/rewrite/rules/rule[@name='TestRule1']/match" -name 'url' -value '(.*)';
Set-WebConfigurationProperty -pspath 'IIS:\Sites\Default Web Site' -filter '/system.webserver/rewrite/rules/rule[@name="TestRule1"]/action' -name . -value @{ type="Rewrite"; url='{C:1}://localhost:5000/{R:1}'};
Add-WebConfigurationProperty -pspath 'IIS:\Sites\Default Web Site' -filter '/system.webserver/rewrite/rules/rule[@name="TestRule1"]/conditions' -name "." -value @{input="{CACHE_URL}"; pattern='^(https?)://'};

## Create GitPull Batch file
New-Item -Path 'C:\MyApp' -ItemType file -Name 'gitclone.bat' -Value `n
$exampleFile = @"
git clone https://github.com/muratbavas/VagrantCoreDemo.git c:\MyApp\VagrantCoreDemo
cd c:\MyApp\VagrantCoreDemo
start iexplore.exe http://Localhost:5000
dotnet run
"@
$exampleFile | Add-Content C:\MyApp\gitclone.bat

## Create GitPull Batch file
New-Item -Path 'C:\MyApp' -ItemType file -Name 'gitpull.bat' -Value `n
$exampleFile = @"
cd c:\MyApp\VagrantCoreDemo
taskkill /IM dotnet.exe /T /F
git pull
start iexplore.exe http://Localhost:5000
dotnet run
"@
$exampleFile | Add-Content C:\MyApp\gitpull.bat

## Create DotNetCore WebPage URL shortcut on desktop
$Shell = New-Object -ComObject ("WScript.Shell")
$Favorite = $Shell.CreateShortcut($env:USERPROFILE + "\Desktop\CoreDotnetProject.url")
$Favorite.TargetPath = "http://Localhost:5000";
$Favorite.Save()