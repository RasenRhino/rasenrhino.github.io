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

