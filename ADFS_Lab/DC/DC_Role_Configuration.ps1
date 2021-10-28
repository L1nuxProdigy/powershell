## install AD DS role
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools;

## Promote and Configures The Machine to a Domain Controller
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS"`
-SafeModeAdministratorPassword (ConvertTo-SecureString "Dd123456" -AsPlainText -Force) -DomainMode "Win2012R2"`
-DomainName "contoso.com" -DomainNetbiosName "CONTOSO" -ForestMode "Win2012R2" -InstallDns:$true -LogPath "C:\Windows\NTDS"`
-NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -force;