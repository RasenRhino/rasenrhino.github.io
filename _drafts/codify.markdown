so we gonna try to TwoMillion machine today , it is a retired machine
link can be found [here](https://app.hackthebox.com/machines/TwoMillion) 

I use the inbuilt instance in htb. 

I edit the /etc/hosts file 

and i run the following command 

``` nmap -sV -sC -v 2million.htb ```

this is my output 

```
Starting Nmap 7.93 ( https://nmap.org ) at 2024-05-13 08:37 BST
NSE: Loaded 155 scripts for scanning.
NSE: Script Pre-scanning.
Initiating NSE at 08:37
Completed NSE at 08:37, 0.00s elapsed
Initiating NSE at 08:37
Completed NSE at 08:37, 0.00s elapsed
Initiating NSE at 08:37
Completed NSE at 08:37, 0.00s elapsed
Initiating Ping Scan at 08:37
Scanning 2million.htb (10.129.166.71) [2 ports]
Completed Ping Scan at 08:37, 0.29s elapsed (1 total hosts)
Initiating Connect Scan at 08:37
Scanning 2million.htb (10.129.166.71) [1000 ports]
Discovered open port 22/tcp on 10.129.166.71
Discovered open port 80/tcp on 10.129.166.71
Completed Connect Scan at 08:37, 8.31s elapsed (1000 total ports)
Initiating Service scan at 08:37
Scanning 2 services on 2million.htb (10.129.166.71)
Completed Service scan at 08:37, 6.58s elapsed (2 services on 1 host)
NSE: Script scanning 10.129.166.71.
Initiating NSE at 08:37
Completed NSE at 08:38, 7.64s elapsed
Initiating NSE at 08:38
Completed NSE at 08:38, 1.15s elapsed
Initiating NSE at 08:38
Completed NSE at 08:38, 0.00s elapsed
Nmap scan report for 2million.htb (10.129.166.71)
Host is up (0.29s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT   STATE SERVICE VERSION
22/tcp open  ssh     OpenSSH 8.9p1 Ubuntu 3ubuntu0.1 (Ubuntu Linux; protocol 2.0)
| ssh-hostkey:
|   256 3eea454bc5d16d6fe2d4d13b0a3da94f (ECDSA)
|_  256 64cc75de4ae6a5b473eb3f1bcfb4e394 (ED25519)
80/tcp open  http    nginx
|_http-title: Hack The Box :: Penetration Testing Labs
|_http-trane-info: Problem with XML parsing of /evox/about
| http-cookie-flags:
|   /:
|     PHPSESSID:
|_      httponly flag not set
|_http-favicon: Unknown favicon MD5: 20E95ACF205EBFDCB6D634B7440B0CEE
| http-methods:
|_  Supported Methods: GET
Service Info: OS: Linux; CPE: cpe:/o:linux:linux_kernel

NSE: Script Post-scanning.
Initiating NSE at 08:38
Completed NSE at 08:38, 0.00s elapsed
Initiating NSE at 08:38
Completed NSE at 08:38, 0.00s elapsed
Initiating NSE at 08:38
Completed NSE at 08:38, 0.00s elapsed
```
i check searchspoilt for the openssh vulnerabilities 

none for the version 

we navigate to the main

