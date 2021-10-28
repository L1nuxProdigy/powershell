$VM_Names_Array = "ADFS (ADFS Lab)", "CA (ADFS Lab)", "DC (ADFS Lab)", "IIS (ADFS Lab)", "Remote Client (ADFS Lab)"

ForEach ($VMname In $VM_Names_Array)
{
	Stop-VM $VMname -TurnOff
}

ForEach ($VMname In $VM_Names_Array)
{
	Remove-VM -Name $VMname -Force
	
	Remove-Item -Path "C:\Users\$env:UserName\Hyper-V\$VMname" -Recurse
}