## joins the Computer to The Domain
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist "ads.com\AppAdmin", $(ConvertTo-SecureString -string "Dd123456" -AsPlainText -Force)
Add-Computer "ads.com" -Credential $cred

## Restart The Computer
Restart-Computer