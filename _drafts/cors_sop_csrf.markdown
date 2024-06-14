i am confused about this line in portswigger, "cors does not prevent csrf". need to dig a bit deeper. 
so lets talk about cors 
https://maddevs.io/blog/web-security-an-overview-of-sop-cors-and-csrf/
cors request can be divided into 2 types 
* safe request 
* preflighted

#### Safe request 
A safe request is idempotent. (you can do it 100 times , it does not matter, like GET,HEAD)
why dont we put HEAD on a request to know more baout a endpoint lol 
 in cors , the policy of the website does not block simple request the request is successful but the response is blocked and broswer does not show the response(you get the content length and everything and a 200 response, but broswer is like naaa)
 
 
#### Preflight request 
we get the same cors error as the normal request, but in preflight request , we see 2 requests.  
![alt text](image-2.png)
we first send the preflight request and it looks something like this 
```
OPTIONS /resource HTTP/1.1
Host: domain-b.com
Origin: http://domain-a.com
Access-Control-Request-Method: DELETE
Access-Control-Request-Headers: Content-Type
```
