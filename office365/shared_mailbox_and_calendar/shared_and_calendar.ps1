New-Mailbox -Shared -Name "Mailbox Name" -PrimarySmtpAddress MailboxName@domain.com -DisplayName "Mailbox Name"

Get-MailboxCalendarFolder -identity MailboxName:\calendar
Get-MailboxFolderPermission -identity MailboxName:\calendar


Add-MailboxFolderPermission -Identity MailboxName@domain.com:\calendar -User user@domain.com -AccessRights Owner