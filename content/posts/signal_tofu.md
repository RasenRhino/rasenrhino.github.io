---
title: Mirai Machine
date: 2023-08-01
tags: [ctf,htb]
---


Signal is a well-known secure messaging protocol, celebrated for its robust end-to-end encryption and straightforward trust model, usually relying on "Trust on First Use" (TOFU) for verifying the authenticity of user identity keys. 

Now........I have personally never seen anyone verify their identity keys using the QR codes feature. (If you do , congrats)

That implies the burden of detecting a MITM lies entirely on client.  (The QR Code you see in Signal)

Question I try to explore over here is ; are there any other other checks for identity key happening on server?

I will try to coagulate my notes on [Signal Server](https://github.com/signalapp/Signal-Server) source code , as I try to answer these questions and see if there is a problem that I would like to spend my time on Solving

Going through the test suite in the Signal repo, I come across [MessagingTest.java](https://github.com/signalapp/Signal-Server/blob/6a1f01f876c44ac78132f558d5e5396154dc6ab0/integration-tests/src/test/java/org/signal/integration/MessagingTest.java#L1-L50) , I conclude the following :- 

- Verify the signature on the signed prekey against the uploaded identity key.

- Bindings happen on client end. Even if `+1 555 1234` and `+1 555 5678` publish the same identity key, User’s app will bind that key to whichever number she picked, and that binding is locked on first use. 

But can't a server pretend to be Alice ?  

#### Can the server be bad ? 

In theory, yes—if you have never talked to that phone-number before, the server could hand you a fake identity-key bundle for that number and silently sit in the middle. 

#### Federated Servers?  

To trust the server, you may think federation (naively like I did, before consensus ; more on that later)
Fingers point towards matrix. 
But this [CVEs](https://www.cvedetails.com/vulnerability-list/vendor_id-2044/Matrix.html) list does not really tip the scales in its favour. 

Matrix spreads metadata across all servers participating in a room. In large public rooms that can be thousands of servers. Signal keeps all routing data on one backend (still subpoenable, but not broadcast).

Federation does put in more trust than just putting the code on github (like Signal), and hoping that is the same code running on the server. 

I know i am being nitpicky, but I think just technically, the line of quesitioning is valid - You cannot trust the server if you are not doing out-of-band verification. 

But, federation is about speaking the same protocol, not running the same binary. (Hence the CVEs and the naivity of the thought process I talked about)

#### Solution ? 

It is my understanding that these issues occur because of community based initiatives.

For instance , lets take the case of ToR . It has its own issues , see [Artifact 1](https://www.atlasobscura.com/articles/found-nodes-in-an-anonymityprotecting-network-that-are-actually-spying-on-users) and [Artifact 2](https://www.youtube.com/watch?v=cJWsJ47joAQ))

My proposition is incentive based initiatives, a very successful example of that is bitcoin. 

Using PoW and incentives, we have developed mechanisms where can can trust the servers processing our data. 

#### But isin't it easier to do out-of-band verification ?

Yes it is 
But here, you can integrate this into the existing architecture , instead of verifying QR codes, it is easier to work it something that looks on like a domain name, like `rasenrhino.com` . But for that you need a CAs and you need to trust a CA, which you can ; until you cant. For more information , see [this](https://www.f5.com/labs/articles/threat-intelligence/kazakhstan-attempts-to-mitm-itscitizens).

My proposition is to have a DNS for identity keys on some on-chain mechanisms. One such example of this is ENS. 

#### What is ENS ? 

Ethereum Name Service (ENS) is a decentralized naming protocol that turns the long, hex–encoded identifiers used on blockchains like `0x742d35c...` into human readable names such as `rasenrhino.eth`. It works a bit like DNS for websites, but lives entirely on smart-contracts instead of ICANN-run servers. 

It should ideally make the user-verification process easier.

But it does cost some decent money. 


#### Steps forward 

I have been working on my own project to understand the process of protocol design more intimately. Here is a chat application protocol I recently was working on. [Link](https://github.com/RasenRhino/messenger_protocol)

My next goal will be to develop this into a on-chain Verifiable communication mechanisms. 

Some thoughts and reason :- 
- With signal , we do have some concerns with endpoint privacy. I need to read more into it. 
- I think this can be used as a good alternative for something like `DocuSign`. The pricing model can be better if I work it out on solana. But such products do require a brand-image as well. 
- It can be used with decentralised arbitration mechanisms. (See [Kleros](https://kleros.io/))

To be continued .... 

