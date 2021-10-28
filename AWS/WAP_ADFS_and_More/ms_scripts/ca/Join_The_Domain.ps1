## import vars
. ..\ps_var_file.ps1

## joins the Computer to The Domain
$cred  = new-object -typename System.Management.Automation.PSCredential `
                    -argumentlist "$domain_name\$domain_admin", $(ConvertTo-SecureString -string $domain_admin_password -AsPlainText -Force)
Add-Computer $domain_name -Credential $cred

## Restart The Computer
Restart-Computer