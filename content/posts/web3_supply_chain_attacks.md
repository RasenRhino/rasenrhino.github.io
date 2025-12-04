---
title: Web3 supply chain attacks 
date: 2024-08-01
tags: []
---

The term “Web3 security” engages the much deserved spotlight on issues like re-entrancy
loops, unchecked external calls, faulty business logic, but that myopic view can lead to
ignorance towards the rest of the attack surface. It is important to understand that Web3
applications (dApps, DeFi platforms, crypto exchanges, etc.) may run on decentralized
protocols, but they still rely heavily on traditional Web2 infrastructure.

There won’t be much content on colloquial phishing here, as there is already enough literature
out there to desensitise you to it. Here I would like to put emphasis on the usual web2 flaws and
how it fits within the web3 ecosystem. It’s worth noting that smart contract exploits accounted for
roughly 53% of crypto losses in 2022 with the rest coming from the Web2/infrastructure issues.

## Routing Woes

Case in point: Curve Finance (2022 & 2025).

A major DeFi protocol, which suffered DNS hijacking attacks multiple times , in 2022 and 2025 .
The underlying smart contract logic was correct but users were directed to a fraudulent website
hackers hijacked the “.fi” domain name system (DNS) of Curve Finance after managing to
access the registrar. [Link]

Didn’t they use DNSSEC ?

Now Curve did use DNSSEC , the lack of registrar lock left them vulnerable . DNSSEC without
registry lock won’t work if the registrar account is compromised. A registry lock is a manual,
out-of-band unlock at the .fi registry . The point to be noted is that .fi offers it, but Curve hadn't
enabled it.

## Key Terms in beginner language

| Term                                                | Why it matters                                                                                         |
|-----------------------------------------------------|--------------------------------------------------------------------------------------------------------|
| Registry (The main authority for your entire TLD like .fi) | It has the final say over which name servers and DNSSEC keys a domain should use.                      |
| Registrar ( eg: GoDaddy , Namecheap)                | If attackers get into your registrar login, they can tell the registry to change critical settings.    |
| Registry Lock                                       | It prevents silent changes to name-server (NS) or DNSSEC (DS) records                                  |

There was no Registry lock in the case of Curve finance.

Now , it is not like the nameserver itself was compromised, that requires a deeper breach. It was
the Registrar Login that was compromised. From there you can point to your own NS and
that’s what happened in the case of Curve FInance.

Fix : Enable Registry Lock.

A registry-level lock (manual, out-of-band) stops NS/DS edits cold. .fi offers it; Curve never
toggled it on. Hardware-token MFA at the registrar and real-time DS monitoring wouldn’t hurt
either.

### What is a Registry Lock

With the lock ON, any registrar request that touches the NS or DS field is automatically rejected.
An out of band verification is required.

Beyond DNS, there are lores of BGP (Border Gateway Protocol) being exploited to achieve
similar results. [Link]

This can be further extrapolated to highly likely and unwanted scenario. For instance ; supply
chain attacks on validators or oracles (compromising the servers that feed data into
blockchains) essentially merging network intrusion with on-chain attack.

(should i add squarespace stuff  
https://www.blockaid.io/blog/squarespace-defi-domain-hijack-incident  
They had 2fa , but password was bad, so during migration from google domains to squarespace
, 2fa was disabled , even on accounts that had 2fa enabled. Password spraying gave access to
change the A records)

## Subdomain Takeover

A subdomain takeover occurs when an attacker gains control over a subdomain of a target
domain. [Link]

Think this way, blog.example.com has a CNAME DNS record pointing to myblog.github.io.
You deleted myblog.github.io. The DNS record still points there, but no GitHub Page exists at
that name. An attacker can now claim myblog.github.io on their own GitHub account.

One major example was the SSV Network Subdomain Takeover in 2023. [Link]

The subdomain events.ssv.network was vulnerable due to an inactive Vercel instance. Attackers
could:

- Register the orphaned subdomain on Vercel.
- Host fake dApps to trigger malicious wallet transactions.
- Distribute malware (e.g., Ssv-wallet.exe) or steal cookies for broader domain
  compromise.
- This demonstrated how Web3 projects relying on Web2 services (e.g., Vercel, DNS) risk
  asset theft and reputation damage from subdomain misconfigurations.

Another example to make a case in point would be NFT cybersquatting. Just going through the
abstract of this paper makes a strong argument for considering subdomain takeovers into
account while mapping out the web3 attack surface..

## DNS Zone Takeovers

These can be more dangerous than subdomain takeovers.

The usual process for buying and utilising a domain is as follows:-

- You buy a domain from GoDaddy
- You create a zone file on Cloudflare
- But….

You did not update the name server on GoDaddy to point to Cloudflare. Say, the domain
example.com still points to ns.godaddy.com, not the Cloudflare nameserver, which looks
something like ns1.cloudflare.com.

Now, example.com expired, but your zone file exists, when an attacker buys example.com ,
and tries to create a zone file on Cloudflare, it throws an error that there is a zone file that
already exists, which is free for attacker to take over, and now he has all the configuration
information of your domain.

Effects of the attack?

The effect is that knowledge of the subdomains is leaked, say, you used

- auth.example.com for OAuth callbacks
- api.example.com for your mobile app

You forgot to delete the zone from Cloudflare.

An attacker buys example.com and reattaches to your old Cloudflare zone.

Now you can get all this data by digging hard enough ( look up crt.sh) , but what you cannot get
is things like internal zone delegations, DNSSEC signatures. Going into the details of certificate
pinning would be an overload of information at this point, but if you are interested, it is a prompt
away

“DNS Zone Takeover and Certificate Pinning”

Note: HKPS is deprecated, and rarely do apps pin an entire certificate. They just pin public
keys. After this , you are on your own on this topic of certificate pinning.

It is not much different from the Curve Finance case we first discussed.

One prominent example of this can be when researchers demonstrated how EtherMail's
reliance on MX records for ENS identity verification could be spoofed. [Link] .

All of this comes down to phishing attacks that are quite interesting to study.

(Personal NOTES : add even tho they can copy everything from crt.sh and get subdomains,
they cannot get Internal Zone Delegation , dnssec signatures, that they can only get from zone
files)

TLS pinning can help , but it is not widely used now , deprecated

Certificate pinning might catch it , if entire certificate is not pinned, only public key is pinned
which is what one would expect )

## IMPORTANT NOTE :

People use DNS Host and Registrar interchangeably. Sometimes they can be the same, but
essentially they are different things.

| Component | Role                                                                                             |
|----------|--------------------------------------------------------------------------------------------------|
| Registrar | Place where you buy your domain from ( eg: GoDaddy )                                            |
| DNS Host  | The service that manages your DNS records (e.g., Cloudflare, Route53). DNS Host is the one that creates your Zone File, which gets put on the Nameserver |

## Packages

Package repository accounts (NPM, etc.) are compromised, and attackers could slip malicious
code that executes during dApp startup or wallet installation. For instance, in 2023, researchers
uncovered dozens of malicious NPM and PyPI packages that specifically targeted crypto
developers or users , some aimed to steal wallet seeds or inject trojans if included in crypto
apps. A few examples would be web3-utils-new, eth-tx-decoder2 etc.

Has no one ever been guilty of blindly following an article, blog , comments on reddit and
rawdog a “npm i “ command?

[Link] [Link]

## Solutions ?

The majority of strategies are community led, as they should be because they can yield
maximum impact in the context of these problems.

One such strategy is to mandate hardware-backed 2FA for all maintainer logins. Nearly every
npm/PyPI takeover begins with an account phish or credential-stuffing hit; hardware keys break
that chain. npm already forces 2FA for the top-impact packages and is phasing it in for everyone
else

Then comes your code-signing , integrity checks, yada yada. You know the drill.

## Developer guidelines

Managing CI tokens with appropriate lifecycles and using a dedicated secrets manager like the
one Github Action uses , blocking rogue curls are a few of the well documented practices
developers can and should follow.

## Bringing it together

None of this requires zero-knowledge proofs, AI auditors, or nine-figure budgets. Just basic
hygiene that we should use in our standard SDLCs.

Also,

Web2 security can get a bit too opaque at times , and practice in web3 security does come with
its own COMPARATIVE ease of execution in a few of contexts , like removing the “never halting”
programs to some part in some places , better exhaustive formal verification methodologies
which are relatively easily accessible, making the process relatively more deterministic. But it
has its own pain points , things where you will have to make significant efforts.

Point being, the domain is not a recluse for someone who is looking to make easy money, or
quick convergence at results for that matter. Instant gratification of knowledge is never helpful ;
a lesson that applies just as much to security as much to life in general.

The understanding from all this is that each layer, from the blockchain protocol to the web UI,
must be considered in threat modeling. Most of the attacks highlighted (from the Curve DNS
hijack to any other phishing attack that are spammed on your twitter feed ) could have been
prevented by applying well-known best practices: e.g. enabling registrar locks and DNSSEC,
using 2FA and unique passwords, code-signing and integrity checks for front-end resources,
network monitoring for BGP anomalies, and user education.

Holistic approach to security cannot be ignored is the point of convergence of this article.

:contentReference[oaicite:0]{index=0}
