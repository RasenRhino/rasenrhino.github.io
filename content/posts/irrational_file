---
title: Files and irrational numbers 
date: 2024-08-01
tags: []
---

## Question : If I can represent a file as the decimal expansion of an irrational number, can I now "reverse compress" the file by describing that irrational number in a simple way (e.g. as the result of a division, a formula, or a function)?

# Can We Hide Any File Inside a Single Irrational Number?  
### …and where do **Kolmogorov Complexity** and those “Prime‑Concat” numbers show up?


## 1. Quick Refresher

The party trick 

1. Take any file ➜ turn its bytes into one long binary string.  
2. Slap a `0.` in front ➜ you get a binary fraction.  
3. Convert to decimal if you want ➜ it’s (almost always) an **irrational**.

Great for a pub anecdote, but it *doesn’t* magically compress anything.

---

## 2. Kolmogorov Complexity (KC) – The Tiny‑Program Test

> KC of a string = **length of the shortest program** that prints that exact string.  
> ([Wikipedia](https://en.wikipedia.org/wiki/Kolmogorov_complexity))

- `0000 …` has KC ≈ log₂(n) – super cheap.  
- A truly random 1 GB video has KC ≈ 1 GB – no shortcuts.

**Why it matters:**  
Your “special irrational” is only helpful if you can describe **all its digits** with a program *much shorter* than the digits themselves. That’s rare unless your data is highly structured.

---

## 3. Enter the Prime‑Concat Family

Famous example: the **Copeland–Erdős constant** (I made sure to use the ő) 
`0.2357111317 …`  
(Just glue the primes together: 2, 3, 5, 7, 11, 13, 17…)  
[Link](https://en.wikipedia.org/wiki/Copeland%E2%80%93Erd%C5%91s_constant)

- It’s irrational.  
- Its digits *look* random, but the description “concatenate primes” is a **one‑liner**.  
- Therefore it has *tiny* Kolmogorov complexity.

> **Key insight:** Low‑KC numbers give you endless digits “for free,” but only if your target data *is those digits*.

---

## 4. Random Files vs. Structured Files

| Data type | Kolmogorov complexity | Can an irrational help? |
|-----------|-----------------------|-------------------------|
| Long run of zeros | Tiny | Yes – a few words recreate it. |
| Encrypted backup.zip | ≈ full size | No – any pointer to its digits must include all the bits anyway. |

In other words, the **library of irrationals** is gigantic, but unless your file secretly *is* a famous constant, you still must ship the whole book.

---

---

## 5. Some notes  

- **Steganography bonus:** hide short secrets by tweaking coefficients in a polynomial or digits in a constant.  
- **Math playground:** explore other low‑KC beasts like the [Champernowne constant](https://en.wikipedia.org/wiki/Champernowne_constant) (`0.1234567891011 …`).

Unfortunately for daily backups, stick with tools that don’t make your brain hurt. 

---

### Takeaway

Decision in this case comes from KC

If your file’s KC is high, no amount of “infinite irrationals” will fix your problem.  
If KC is low, you have your solution.

I plan to have more deterministic examples here , where I take proper examples and show the outcome of a low/high KC in our context


To be continued....