$VM_Names_Array = "ADFS (ADFS Lab)", "CA (ADFS Lab)", "DC (ADFS Lab)", "IIS (ADFS Lab)", "Remote Client (ADFS Lab)"

ForEach ($VMname In $VM_Names_Array)
{
	Start-VM $VMname
}