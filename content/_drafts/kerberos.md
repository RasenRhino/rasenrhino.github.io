---
title: KerberWoes 
date: 2024-02-12
tags: [kerberos,ccdc,blue_team,authentication,cryptography]
---

Kerberos is named after your Cerberus (the 3 headed guard dog)
It took me a while to get it. 

[Best Video](https://www.youtube.com/watch?v=5N242XcKAsM)

Now if there is the video, why do I need to write this. 2 reasons 

- My blog
- I might refer it , which is faster than watching video as I have understood it
- I wanted a corresponding explanation with the practical steps to kerberos. Like does it use a key derivation function ? (that was obvious but some nuances of the flow I wanted to be a tad more sure about than what I was. Where does it use it, how does it share the secrets)


// INSERT KERBEROS FLOW WHEN YOU HAVE TIME

####  BEHOLD "REAL WORLD" execution 
###### context :- someone in my binary exploitation class couldn't write assembly so he deemed the class useless and no correspondence to the "real-world" use cases. 
###### interesting fellow I must say

We have essentially 3 keys , 

S1 : Only server
S2 : Client <-> Server
S3 : Service <-> Server

// I will update it after class

The fact that Alice is talking to Bob will be known by the KDC. The KDC
can also remember the key that it created for Alice and Bob to
communicate and so can decrypt all their communication.