## What is a service 
A service is any long running background process , typically run at boot. 

## What is systemd 
It is init system and service manager , starts userspace process after kernel boots. Replaces older init systems. 
logs via journald 
starts as PID 1 

unit file defines what to do with a target service 

example : /etc/systemd/system/ssh.service 

can be controlled from systemctl