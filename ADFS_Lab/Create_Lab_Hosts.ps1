$VM_Names_Array = "ADFS (ADFS Lab)", "CA (ADFS Lab)", "DC (ADFS Lab)", "IIS (ADFS Lab)"

ForEach ($VMname In $VM_Names_Array)
{
	New-VM -name $VMname -Generation 2 -NewVHDPath "C:\Users\$env:UserName\Hyper-V\$VMname\Disks\$VMname.vhdx"`
	-NewVHDSizeBytes 15GB -path "C:\Users\$env:UserName\Hyper-V\$VMname\Files" -SwitchName "Internal";
	
	Add-VMDvdDrive -VMName $VMname -Path "D:\Operating Systems Images\Microsoft\Server 2012 R2 Evaluation.ISO";
	
	Set-VMMemory $VMname -MinimumBytes 512MB -StartupBytes 2GB -MaximumBytes 4GB;
	
	Set-VM -Name $VMname -AutomaticStartAction Nothing -AutomaticStopAction ShutDown;
	
	Enable-VMIntegrationService -VMName $VMname -Name "guest service interface";
	
	Set-VMFirmware $VMname -FirstBootDevice (Get-VMDvdDrive $VMname);
}

$VMname = "Remote Client (ADFS Lab)"

New-VM -name $VMname -Generation 2 -NewVHDPath "C:\Users\$env:UserName\Hyper-V\$VMname\Disks\$VMname.vhdx"`
-NewVHDSizeBytes 15GB -path "C:\Users\$env:UserName\Hyper-V\$VMname\Files" -SwitchName "Internal";

Add-VMDvdDrive -VMName $VMname -Path "D:\Operating Systems Images\Microsoft\Win10 1903 Eng x64.ISO";

Set-VMMemory $VMname -MinimumBytes 512MB -StartupBytes 2GB -MaximumBytes 4GB;

Set-VM -Name $VMname -AutomaticStartAction Nothing -AutomaticStopAction ShutDown;

Enable-VMIntegrationService -VMName $VMname -Name "guest service interface";

Set-VMFirmware $VMname -FirstBootDevice (Get-VMDvdDrive $VMname);