## import vars
. ..\ps_var_file.ps1

# unregister the task that called the script
Unregister-ScheduledTask -TaskName $task_name -Confirm:$false

## Register a task to configure users post startup
$Trigger= New-ScheduledTaskTrigger -AtStartup
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                 -Argument "$scripts_path\dc_adfs\user_and_groups_configurations.ps1" `
                                 -WorkingDirectory "$scripts_path\dc_adfs"
Register-ScheduledTask -TaskName $task_name -Action $action -Trigger $trigger `
                       -RunLevel Highest -User "$env:USERDOMAIN\$AWS_starting_admin_name" -Password $domain_admin_password

## install AD DS role
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools;

## Promote and Configures The Machine to a Domain Controller
Install-ADDSForest `
-DomainName $domain_name `
-DomainNetbiosName $DomainNetbiosName `
-DomainMode "WinThreshold" `
-ForestMode "WinThreshold" `
-SafeModeAdministratorPassword (ConvertTo-SecureString $AD_DS_Safe_Mode_Password -AsPlainText -Force) `
-InstallDns:$true `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-SysvolPath "C:\Windows\SYSVOL" `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-Force:$true