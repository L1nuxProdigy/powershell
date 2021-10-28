## import vars
. ..\ps_var_file.ps1

## configures machine IP - In AWS the private ip is first given from a logical component and thus the private ip configured in terraform
#New-NetIpAddress -InterfaceAlias 'Ethernet' -IpAddress 10.0.1.3 -PrefixLength 24;

## Rename The Computer
Rename-Computer DC

## AWS Default admin name is "administrator", change its initial password
Set-LocalUser -Name $AWS_starting_admin_name -Password $(ConvertTo-SecureString -string $domain_admin_password -AsPlainText -Force)

## Register a task to configure the DC role post startup
$Trigger= New-ScheduledTaskTrigger -AtStartup
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                 -Argument "$scripts_path\dc_adfs\dc_role_configuration.ps1" `
                                 -WorkingDirectory "$scripts_path\dc_adfs"
Register-ScheduledTask -TaskName $task_name -Action $action -Trigger $trigger `
                       -RunLevel Highest -User "$env:USERDOMAIN\$AWS_starting_admin_name" -Password $domain_admin_password

## Restart The Computer
Restart-Computer