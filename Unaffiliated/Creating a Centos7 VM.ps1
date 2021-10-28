$i=read-host "how many machines will we create today?";
if ($i -gt 1) {
$SeriesName=read-host "Type Machines Series Name";
foreach ($num in 1..$i){
$VMname= $SeriesName+$num;
new-vm -name $VMname -Generation 2 -NewVHDPath "C:\Users\$env:UserName\virtual machines\$VMname\VHD\$VMname.vhdx"`
-NewVHDSizeBytes 10GB -path "C:\Users\$env:UserName\Virtual Machines\$VMname";
set-vm $vmname -DynamicMemory -MemoryMaximumBytes 4096MB -MemoryMinimumBytes 2048MB -MemoryStartupBytes 4096MB -ProcessorCount 2 -AutomaticStartAction Nothing -AutomaticStopAction ShutDown -CheckpointType Disabled;
Enable-VMIntegrationService -VMName $VMname -Name "guest service interface";

Add-VMDvdDrive $VMname -path 'D:\Operating Systems Images\CentOS-7-x86_64-Minimal-1804.iso'
Set-VMFirmware $VMname -FirstBootDevice (Get-VMDvdDrive $VMname);}
}
else {
$SeriesName=read-host "Type Machine Name";
$VMname= $SeriesName;
new-vm -name $VMname -Generation 2 -NewVHDPath "C:\Users\$env:UserName\virtual machines\$VMname\VHD\$VMname.vhdx"`
-NewVHDSizeBytes 10GB -path "C:\Users\$env:UserName\Virtual Machines\$VMname";
set-vm $vmname -DynamicMemory -MemoryMaximumBytes 4096MB -MemoryMinimumBytes 2048MB -MemoryStartupBytes 4096MB -ProcessorCount 2 -AutomaticStartAction Nothing -AutomaticStopAction ShutDown -CheckpointType Disabled;
Enable-VMIntegrationService -VMName $VMname -Name "guest service interface";

Add-VMDvdDrive $VMname -path 'D:\Operating Systems Images\CentOS-7-x86_64-Minimal-1804.iso'
Set-VMFirmware $VMname -FirstBootDevice (Get-VMDvdDrive $VMname);}