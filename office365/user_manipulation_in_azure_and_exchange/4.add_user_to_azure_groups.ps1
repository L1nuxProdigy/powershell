$GroupsObjectIds = Get-AzureADUser -SearchString $TemplateUser | Get-AzureADUserMembership | select objectid
$NewUserObjectID = Get-AzureADUser -SearchString "$FirstNameLowerCase@$DomainName.com" | select objectid

Foreach ($GroupId in $GroupsObjectIds) {Add-AzureADGroupMember -ObjectId $GroupId.ObjectId  -RefObjectId $NewUserObjectID.ObjectId}