## Bypassing 2 factor authentication 
if the user is first prompted to enter a password and then prompted to enter a verification code on a seprate page, the user is effectively logged in state before they have entered the verification code. 
you can see if you can get to "logged in only" pages 

Flawed 2 factor authentication logic :- 

you login -> cookie is set -> you give the verification code along with the cookie to let server  determine which account the user is trying to access

In this case, an attacker could log in using their own credentials but then change the value of the account cookie to any arbitrary username when submitting the verification code.

this is dangerous as they will be able to brute force any arbtrirary user 

#### Brute forcing 

you can try to brute force simple ones, 
but there can be times when they log you out
so for that , you got the macros , you just keep relogging and retrying 

#### Why no basic auth 

some browsers usually attempt https first 

firefox does not, if a http link is present, it will straight go to port 80 

Why the fallback still lets a Basic-Auth leak happen
User types example.com (or clicks a plain-HTTP link).

Browser first attempts https://example.com/.

Attacker interferes — blocks packets or serves an invalid cert.

Browser’s auto-upgrade logic gives up and retries http://example.com/.

Attacker replies with 401 Unauthorized WWW-Authenticate: Basic, harvests the credentials the moment the user (or the browser) resends the request with Authorization: Basic ….


### READ SOME STUFF ON FORGET PASSWORD FLOWS , how do people forget to validate the token ? dafuq is that 

| Control | Why it matters |
|---------|----------------|
| **Store the token server-side** (or sign it with an HMAC and verify). | Prevents tampering or omission. |
| **Bind token → user → request-IP/User-Agent** and mark *single-use*. | Stops replay or swapping usernames. |
| **Short TTL** (e.g., 10–15 min). | Shrinks the brute-force window. |
| **Enforce rate limits / lock-outs** **and** alert unusual volumes. | Makes enumeration impractical. |
| **Send reset links only over HTTPS; set `SameSite=Lax` cookies.** | Thwarts host-header poisoning and CSRF tricks. |
| **Security review of every “make state-changing POST” endpoint.** | Catches the “token-not-checked” bug before prod. |
