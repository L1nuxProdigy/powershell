$A = New-ScheduledTaskAction -Execute "<Program, Path, etc>"
$T = New-ScheduledTaskTrigger -AtStartup
$P = New-ScheduledTaskPrincipal "<UserName>"
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Principal $P -Trigger $T -Settings $S
Register-ScheduledTask T1 -InputObject $D

Unregister-ScheduledTask -TaskName "T1" -confirm:$False