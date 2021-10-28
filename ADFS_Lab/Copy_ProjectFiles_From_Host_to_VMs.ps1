# creates a zip archive out of the project's directory files
Compress-Archive -Path "C:\Users\$env:UserName\PowerShell\ADFS_Lab\*" -CompressionLevel Fastest -DestinationPath "C:\Users\$env:UserName\PowerShell\ADFS_Lab\zip"

$VM_Names_Array = "ADFS (ADFS Lab)", "CA (ADFS Lab)", "DC (ADFS Lab)", "IIS (ADFS Lab)", "Remote Client (ADFS Lab)"

ForEach ($VMname In $VM_Names_Array)
{
	Copy-VMFile $VMname -SourcePath "C:\Users\$env:UserName\PowerShell\ADFS_Lab\zip.zip" -DestinationPath "C:\Project\zip.zip" -CreateFullPath -FileSource Host;
}

Remove-Item -Path "C:\Users\$env:UserName\PowerShell\ADFS_Lab\zip.zip"