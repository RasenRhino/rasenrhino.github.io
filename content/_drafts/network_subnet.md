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

snort rules types 
- alert 
- block 
- drop 
- logging 
- pass


rule-type traffic-type source-ip port -> (direction) $HOME_NEY any (any ip in the home net network variable) (msg:"some message";sid:1234;rev:1)


```
pass tcp $EXTERNAL_NET any -> $HOME_NET $HTTP_PORTS (
    flow:to_server;
    metadata:service http;
    flowbits:isnotset,cgi-tag;
    uricontent:"cgi-bin/";
    nocase;
    flowbits:set,cgi-tag;
    sid:1000002;
    rev:1;
)
```

Snort can be run in 2 modes 
- Sniffer mode  (-v)
- Packet Logger mode  
- NIDS mode (network intrusion detection system)



```
pass tcp $EXTERNAL_NET any -> $HOME_NET $HTTP_PORTS (
    flow:to_server;
    metadata:service http;
    flowbits:isnotset,cgi-tag;
    uricontent:"cgi-bin/";
    nocase;
    flowbits:set,cgi-tag;
    sid:1000002;
    rev:1;
)
```


```
alert tcp $HOME_NET $HTTP_PORTS -> $EXTERNAL_NET any (
    flow:from_server,established;
    file_data;
    content:"load";
    flowbits:isset,cgi-tag;
    flowbits:unset,cgi-tag;
    sid:1000003;
    rev:1;
)
```


### File Download check 

```
pass tcp any any -> $HOME_NET 80 (flow:to_server; metadata:service http secret-file; flowbits:isnotset,secret-file; uricontent:"secret/"; nocase; flowbits:set,secret-file; sid:1000002; rev:1;)
```


```
alert tcp $HOME_NET 80 -> any any (flow:from_server, established; uricontent:"corp-sec-salary.xlsx" ; flowbits:isset,secret-file; metadata:service http; flowbits:unset,secret-file; sid:1000003; rev:1;)
```
flowbits:isset,secret-file; flowbits:unset,secret-file;
find a rule using : grep -r "sid:384" /etc/snort/rules/

```
sudo snort -i eth1 -v -d -e -c /etc/snort/snort.conf -f "host 10.10.138.150 and port 80"
```

```
tcpdump -n -i eth1 2>&1 | cat
```

why do i need any , any , why does it not work with homenet 80 

```
#alert tcp any any -> any 80 (flow:to_server; metadata:service http secret-file; flowbits:isnotset,secret-file; uricontent:"secret/"; nocase; flowbits:set,secret-file; sid:1000002; rev:1;)
#alert tcp any any -> any any (msg:"Excel file download request detected";  content:"sheet"; http_header; nocase; sid:1000006; rev:1;)
alert tcp any any -> $HOME_NET 80 (flow:to_server; metadata:service http secret-file; flowbits:isnotset,secret-file; uricontent:"secret/"; nocase; flowbits:set,secret-file; sid:1000002; rev:1;)

alert tcp any any -> $HOME_NET any (msg:"Excel file download request detected"; flow:to_server ;uricontent:"corp-sec-salary.xlsx" ;metadata:service http;sid:1000003; rev:1;)

#alert tcp any any -> any any ( msg:"XLSX file response detected"; flow:from_server ;   flowbits:isset,secret-file; flowbits:unset,secret-file; content:"spreadsheetml"; http_raw_header ; metadata:service http;  sid:1000004; rev:1; )
alert tcp any any -> $HOME_NET 2222 (msg:"SSH Access Attempt on Port 2222"; flow:to_server,established; sid:1000005; rev:1;)


```

### SSH check

```
alert tcp any any -> $HOME_NET 2222 (msg:"SSH Access Attempt on Port 2222"; flow:to_server,established; flags:S ;sid:1000005; rev:1;)
```

### Suspicious ICMP scan 

```
alert icmp $EXTERNAL_NET any -> $HOME_NET any (msg:"Suspicious ICMP Scan Detected"; detection_filter: track by_src, count 5, seconds 10; sid:100001; rev:1;)
```

alert tcp $HOME_NET [21,25,443,465,636,992,993,995,2484] -> $EXTERNAL_NET any (msg:"SERVER-OTHER OpenSSL SSLv3 large heartbeat response - possible ssl heartbleed attempt"; flow:to_client,established,only_stream; content:"|18 03 00|"; depth:3; byte_test:2,>,128,0,relative; content:"|02|"; within:1; distance:2; metadata:policy balanced-ips drop, policy max-detect-ips drop, policy security-ips drop, ruleset community, service ssl; reference:cve,2014-0160; classtype:attempted-recon; sid:1000012; rev:11;)
alert tcp $HOME_NET [21,25,443,465,636,992,993,995,2484] -> $EXTERNAL_NET any (msg:"SERVER-OTHER OpenSSL TLSv1 large heartbeat response - possible ssl heartbleed attempt"; flow:to_client,established,only_stream; content:"|18 03 01|"; depth:3; byte_test:2,>,128,0,relative; content:"|02|"; within:1; distance:2; metadata:policy balanced-ips drop, policy max-detect-ips drop, policy security-ips drop, ruleset community, service ssl; reference:cve,2014-0160; classtype:attempted-recon; sid:1000013; rev:11;)
alert tcp $HOME_NET [21,25,443,465,636,992,993,995,2484] -> $EXTERNAL_NET any (msg:"SERVER-OTHER OpenSSL TLSv1.1 large heartbeat response - possible ssl heartbleed attempt"; flow:to_client,established,only_stream; content:"|18 03 02|"; depth:3; byte_test:2,>,128,0,relative; content:"|02|"; within:1; distance:2; metadata:policy balanced-ips drop, policy max-detect-ips drop, policy security-ips drop, ruleset community, service ssl; reference:cve,2014-0160; classtype:attempted-recon; sid:1000014; rev:11;)
alert tcp $HOME_NET [21,25,443,465,636,992,993,995,2484] -> $EXTERNAL_NET any (msg:"SERVER-OTHER OpenSSL TLSv1.2 large heartbeat response - possible ssl heartbleed attempt"; flow:to_client,established,only_stream; content:"|18 03 03|"; depth:3; byte_test:2,>,128,0,relative; content:"|02|"; within:1; distance:2; metadata:policy balanced-ips drop, policy max-detect-ips drop, policy security-ips drop, ruleset community, service ssl; reference:cve,2014-0160; classtype:attempted-recon; sid:1000015; rev:11;)


