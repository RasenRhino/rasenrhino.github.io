## reflected xss 
- you send GET pwn 
- Server returns `<some-tag> pwn </some-tag>`

So what you can do is 

- you send GET `<script> alert(1) </script>`
- server returns `<some-tag> <script> alert(1) </script> </some=tag>`

and you get a alert on the screen 

that is reflected XSS 

## stored XSS

it gets stores in a database and is shown to the user 

eg. chat window 

## DOM based XSS (happens entirely on the client side )

user gives some input -> goes to innerhtml 

## Mutation XSS 

READ MORE 

Say you put stuff, broswer doees something to it and it passes on as an input somewhere where it can be executed as a javascript 
idk about this 

### Look into solving XSS and why it is not that simple
