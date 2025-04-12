---
title: Mikrotek router 
date: 2023-08-01
tags: [networking,homelab]
---

`/ping`



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

##### User list 

```
/user print
```

##### user disable 

```
/user disable [find where name="USERNAME"]
change it to enable to reenable
```

##### create new user 

```
/user add name=netadmin group=full password=StrongPass123
```

##### Change user password - where command 

```
/user set [find where name="USERNAME"] password=NEWPASSWORD
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

## hardening 


#### list services 

```
/ip service print
```

#### trusted subnets 

```
/ip service set winbox address=192.168.209.0/24  # Restrict to a trusted subnet
/ip service disable telnet,ftp,api-ssl
```

/ip service set winbox address=192.168.209.0/24
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