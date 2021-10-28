$A = New-ScheduledTaskAction -Execute "<Program, Path, etc>"
$T = New-ScheduledTaskTrigger -AtStartup
$P = New-ScheduledTaskPrincipal "<UserName>"
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask T1 -InputObject $D

Unregister-ScheduledTask -TaskName "T1" -confirm:$False

## Register a task to configure users post startup
$Trigger= New-ScheduledTaskTrigger -AtStartup
$Action= New-ScheduledTaskAction -Execute "PowerShell.exe" `
                                 -Argument "c:\users\administrator\desktop\script.ps1" `
                                 -WorkingDirectory "c:\users\administrator\desktop\"
Register-ScheduledTask -TaskName $task_name -Action $action -Trigger $trigger `
                       -RunLevel Highest -User "DC\$AWS_starting_admin_name" -Password $domain_admin_password



## unrelated sketch

New-LocalUser "admin" -Password $(ConvertTo-SecureString -string $domain_admin_password -AsPlainText -Force)
Add-LocalGroupMember -Group "Administrators" -Member "admin"