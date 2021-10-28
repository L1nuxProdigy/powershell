## allows the evaluation image to run without shutting each hour
slmgr.vbs -rearm;

## configures machine IP
New-NetIpAddress -InterfaceAlias 'Ethernet' -IpAddress 172.16.0.2 -PrefixLength 24;

## Rename The Computer
Rename-Computer DC;

## Restart The Computer
Restart-Computer