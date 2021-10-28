$FirstName = $DisplayName -replace '\s.*',''
$FirstNameLowerCase = $FirstName.ToLower() 
$LastName = $DisplayName  -replace '.*\s',''
$LastNameLowerCase = $LastName.ToLower()

try {$check_if_user_exist = Get-AzureADUser -ObjectId "$FirstNameLowerCase@$DomainName.com"}
catch [Microsoft.Open.AzureAD16.Client.ApiException] {"API error- meaning no user like this exist (in most cases) "}
If ($check_if_user_exist.objectid -gt 1)
{
	Write-Output("user already exist, adding first letter of surename to the UPN")
	$FirstNameLowerCase = $FirstNameLowerCase+$LastNameLowerCase[0]
} Else {"user does not exist"}



New-AzureADUser -DisplayName $DisplayName -PasswordProfile $PasswordProfile -UserPrincipalName "$FirstNameLowerCase@$DomainName.com" -AccountEnabled $true -MailNickName $FirstNameLowerCase -GivenName $FirstName -Surname $LastName -Department $Department -JobTitle $JobTitle -UsageLocation $UsageLocation