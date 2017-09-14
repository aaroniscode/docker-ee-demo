Install-PackageProvider -Name NuGet -Force
Install-Module -Name DockerMsftProvider -Force
Unregister-PackageSource -ProviderName DockerMsftProvider -Name DockerDefault -Erroraction Ignore
Register-PackageSource -ProviderName DockerMsftProvider -Name Docker -Location https://download.docker.com/components/engine/windows-server/index.json
Install-Package -Name docker -ProviderName DockerMsftProvider -Source Docker -Force
Restart-Computer
