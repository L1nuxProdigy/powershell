# Finding the groups of the "template users"- using MS Msol service
$Groups_list = foreach ($Group in (Get-MsolGroup -all)) {if (Get-MsolGroupMember -all -GroupObjectId $Group.ObjectId | where {$_.Emailaddress -eq $TemplateUser}) {$Group.DisplayName}}

#Commands: (the first for security and distribution groups, the second for 365 groups)
Foreach ($Group in $Groups_List) {Add-DistributionGroupMember -Identity $Group -Member "$FirstNameLowerCase@$DomainName.com"}
Foreach ($Group in $Groups_List) {Add-UnifiedGroupLinks -Identity $group -LinkType Members -Links "$FirstNameLowerCase@$DomainName.com"}

#Add the user to a specific 365 group
Add-UnifiedGroupLinks -Identity $SpecificGroup -LinkType Members -Links "$FirstNameLowerCase@$DomainName.com"
#Remove-UnifiedGroupLinks -Identity $SpecificGroup -LinkType Members -Links "$FirstNameLowerCase@$DomainName.com"