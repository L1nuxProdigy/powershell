# with powershell
$From = "XXX@gmail.com"
$To = "XXX@gmail.com"
#$Cc = "YourBoss@YourDomain.com"
#$Attachment = "C:\temp\Some random file.txt"
$Subject = "Tests"
$Body = "body test"
$SMTPServer = "smtp.gmail.com"
$SMTPPort = "587"
#Send-MailMessage -From $From -to $To -Cc $Cc -Subject $Subject `
#-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
#-Credential (Get-Credential) -Attachments $Attachment
$cred  = new-object -typename System.Management.Automation.PSCredential `
                    -argumentlist $From, $(ConvertTo-SecureString -string "" -AsPlainText -Force)

Send-MailMessage -From $From -to $To -Subject $Subject `
-Body $Body -SmtpServer $SMTPServer -port $SMTPPort -UseSsl `
-Credential $cred

#2nd method
$email = "XXX@gmail.com" 
$pass = "" 
$smtpServer = "smtp.gmail.com"

$msg = new-object Net.Mail.MailMessage 
$smtp = new-object Net.Mail.SmtpClient($smtpServer) 
$smtp.EnableSsl = $true 
$msg.From = "$email"  
$msg.To.Add("$email") 
$msg.BodyEncoding = [system.Text.Encoding]::Unicode 
$msg.SubjectEncoding = [system.Text.Encoding]::Unicode 
$msg.IsBodyHTML = $true  
$msg.Subject = "Test mail from PS" 
$msg.Body = "<h2> Test mail from PS </h2> 
</br> 
Hi there 
"  
$SMTP.Credentials = New-Object System.Net.NetworkCredential("$email", "$pass"); 
$smtp.Send($msg)