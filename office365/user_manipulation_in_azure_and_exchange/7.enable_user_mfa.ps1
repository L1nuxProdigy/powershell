$mf= New-Object -TypeName Microsoft.Online.Administration.StrongAuthenticationRequirement
$mf.RelyingParty = "*"
$mfa = @($mf)

Set-MsolUser -UserPrincipalName "$FirstNameLowerCase@$DomainName.com" -StrongAuthenticationRequirements $mfa