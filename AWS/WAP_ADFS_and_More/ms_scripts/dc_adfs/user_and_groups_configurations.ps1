## import vars
. ..\ps_var_file.ps1

## Creates an AD DS Group
New-ADGroup -Name "Finance" -SamAccountName "SAM Finance"`
-GroupCategory Security -GroupScope Global -DisplayName "Display Name Finance"`
-Path "CN=Users,DC=Contoso,DC=Com" -Description "Finance Group"

## Creates an AD DS User
New-ADUser -Name "Robert Hatley" -GivenName "Robert" -Surname "Hatley" -SamAccountName "RobertH" `
-UserPrincipalName "RobertH@Contoso.com" `
-AccountPassword (ConvertTo-SecureString -string $user_password -AsPlainText -Force) -Enabled $True

## Adds the User to The Group
Add-ADGroupMember -Identity "SAM Finance" -Members RobertH

## Create GMSA Account
#Add-KdsRootKey -EffectiveTime (Get-Date).AddHours(-10)
#New-ADServiceAccount FsGmsa -DNSHostName adfs1.contoso.com -ServicePrincipalNames http/adfs1.contoso.com

## change the domain admin name
Get-Aduser $AWS_starting_admin_name | Rename-ADObject -NewName $domain_admin_name

# remove the schedualed task
Unregister-ScheduledTask -TaskName $task_name -Confirm:$false