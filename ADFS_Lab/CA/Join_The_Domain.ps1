## joins the Computer to The Domain
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist "Contoso.com\Administrator", $(ConvertTo-SecureString -string "Dd1234" -AsPlainText -Force)
Add-Computer "contoso.com" -Credential $cred

## Restart The Computer
Restart-Computer