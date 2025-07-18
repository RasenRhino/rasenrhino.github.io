---
title: Secure messaging – Me being nitpicky
date: 2024-08-01
tags: []
---

Signal is a well-known secure messaging protocol, celebrated for its robust end-to-end encryption and straightforward trust model, usually relying on "Trust on First Use" (TOFU) for verifying the authenticity of user identity keys.

Now... I have personally never seen anyone verify their identity keys using the QR codes feature. (If you do, congrats.)

That implies the burden of detecting a MITM lies entirely on the client (the QR code you see in Signal).

The question I try to explore here is: **Are there any other checks for identity keys happening on the server?**

I will try to consolidate my notes on the [Signal Server](https://github.com/signalapp/Signal-Server) source code as I attempt to answer these questions and see if this is a problem I want to spend time solving.

---

### Findings from Signal’s Test Suite

Going through the test suite in the Signal repo, particularly [MessagingTest.java](https://github.com/signalapp/Signal-Server/blob/6a1f01f876c44ac78132f558d5e5396154dc6ab0/integration-tests/src/test/java/org/signal/integration/MessagingTest.java#L1-L50), I conclude the following:

- The signature on the signed prekey is verified against the uploaded identity key.
- Bindings happen on the client end. Even if numbers like `+1 555 1234` and `+1 555 5678` publish the same identity key, the user’s app will bind that key to whichever number she picked, and that binding is locked on first use.

I did go through some more bits, and the code did work according to the spec. Nothing out of the ordinary. 

But can't a server pretend to be Alice?

Do we know that the code we are seeing is the one running on the server ?

---

### Can the server be malicious?

In theory, yes—if you've never communicated with that phone number before, the server could hand you a fake identity-key bundle for that number and silently act as a MITM.

---

### Can federated servers for messaging protocols be better?

I did think breifly that federation can be a good idea. But they do have their own challenges. 

Fingers point toward Matrix. But reviewing this [CVE list](https://www.cvedetails.com/vulnerability-list/vendor_id-2044/Matrix.html) doesn’t exactly tip the scales in its favor.

Matrix spreads metadata across all servers participating in a room, potentially thousands in large public rooms. Signal, on the other hand, keeps all routing data on a single backend (still subpoena-able, but not broadly broadcasted).

Federation involves more trust than just putting code on GitHub (like Signal) and hoping the server is running the same code. I know I'm being nitpicky, but technically, the questioning is valid—you cannot fully trust the server without doing out-of-band verification.

However, federation is about speaking the same protocol, not necessarily running the same binary (hence the CVEs and the naive thought process I mentioned).

---

### Possible Solution?

It's my understanding these issues stem from community-based initiatives.

For instance, take the case of Tor. It has its own issues (see [Artifact 1](https://www.atlasobscura.com/articles/found-nodes-in-an-anonymityprotecting-network-that-are-actually-spying-on-users) and [Artifact 2](https://www.youtube.com/watch?v=cJWsJ47joAQ)).

My proposition: incentive-based initiatives. A very successful example is Bitcoin.

Using PoW and incentives, we've developed mechanisms where we can trust servers processing our data.

---

### But isn't it easier to do out-of-band verification?

Yes, it is. However, instead of verifying QR codes, it might be easier to integrate something that looks like a domain name (`rasenrhino.com`). But this approach relies on Certificate Authorities (CAs), and trusting a CA works—until it doesn't. (For more, see [this](https://www.f5.com/labs/articles/threat-intelligence/kazakhstan-attempts-to-mitm-itscitizens).)

My proposition is a DNS-like system for identity keys built upon an on-chain mechanism. One example is ENS.

---

### What is ENS?

Ethereum Name Service (ENS) is a decentralized naming protocol turning blockchain addresses like `0x742d35c...` into human-readable names such as `rasenrhino.eth`. ENS functions similarly to DNS but runs entirely on smart contracts instead of ICANN-controlled servers.

It ideally simplifies user-verification but involves some significant costs.

---

### Steps forward

I have been working on my own project to understand protocol design more intimately. Here's a chat application protocol I've recently worked on: [Messenger Protocol](https://github.com/RasenRhino/messenger_protocol).

My next goal is to develop this into an **on-chain verifiable communication mechanism**.

Some thoughts and reasoning:

- With Signal, we have endpoint privacy concerns. I'll need to investigate further.
- This could be a viable alternative to something like `DocuSign`. The pricing model might be more efficient on Solana, though such products require solid brand recognition.
- It could integrate decentralized arbitration mechanisms (see [Kleros](https://kleros.io/)).

To be continued...
