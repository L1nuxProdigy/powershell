## import vars
. ..\ps_var_file.ps1

## configures machine IP - In AWS the private ip is first given from a logical component and thus the private ip configured in terraform
#New-NetIpAddress -InterfaceAlias 'Ethernet' -IpAddress 10.0.1.5 -PrefixLength 24;
Set-DnsClientServerAddress -Interfacealias 'Ethernet' -ServerAddresses ("10.0.1.4");

## Rename The Computer
Rename-Computer WAP;

## Change the name of the built in local administrator and set it with a simple initial password
Rename-LocalUser -Name "Administrator" -NewName $local_admin_name
Set-LocalUser -Name $local_admin_name -Password $(ConvertTo-SecureString -string $local_admin_password -AsPlainText -Force)

## Restart The Computer
Restart-Computer