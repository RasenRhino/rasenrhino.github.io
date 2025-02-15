---
title: Mikrotek router 
date: 2023-08-01
tags: [networking,homelab]
---
##### Current IP address assigned to device
```
/ip address print
```
##### Print Interfaces

```
/interface print
```

##### Add and remove address 

```
/ip address add address=172.20.182.1/16 interface=ether5
/ip address remove #num
```

##### Check bridges 

```
/interface bridge port print
```

you can bridge the router lan ports , but traffic between devices on the same bridge does not pass through the router’s IP layer, so normal IP firewall rules won’t apply.
solition , use `/interface bridge filter` 


##### print interface list member 

```
/interface list member print
```

##### print nat
```
/ip firewall nat print
```

### hardening 

#### trusted subnets 

```
/ip service set winbox address=192.168.88.0/24  # Restrict to a trusted subnet
/ip service disable telnet,ftp,api-ssl
```


### do some pings 


```
/tool fetch url="http://your-public-ip" mode=http dst-path=response.txt keep-result=yes
```

##### show  arp table (to see current ips)

```
/ip arp print
```

linux file attributes 
sudo -l only tells your permissions 
check sudoers 
dns server ssh not required, so disable them 