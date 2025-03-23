/25 means 2 blocks 
32-25=7bits remaining, that means 2^7=128 ip addresses 
lets say we have 10.10.138.x/25 , it is divided into 2 parts 
part 1: 10.10.138.0/25 (0-127)
part 2: 10.10.138.128 (128-255)

what if it is /26 

that means only 6 bits remaining , so we have 2^6=64 bits 
256 / 64 = 4 subnets 

10.10.138.0/26
10.10.138.64/26
10.10.138.128/26
10.10.138.192/26

now about /23 bits 

we have 2^9 = 512 IP addresses per subnet 

since /23 is bigger than a /24, it spans to /24s 

eg : 

10.10.138.0 - 10.10.138.255 (first /24)

10.10.139.0 - 10.10.139.255 (second /24)

So the full range of 10.10.138.0/23 is
Network address: 10.10.138.0
Broadcast address: 10.10.139.255
Usable IPs: 10.10.138.1 – 10.10.139.254

also apprently you can make network interfaces promiscious manually lmao i didnt know that 

