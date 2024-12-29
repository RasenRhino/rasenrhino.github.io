#### Evasive testing 
Perhaps we did not thoroughly test a payload, or we got careless and ran a command such as net user or whoami that is often monitored by EDR systems and flagged as anomalous activity.

dont be like, "ooo this got detected" that is a good thing as well. 

In most cases, the system we use will not have the tools to enumerate the internal network efficiently.

so we usually have this notion of something is right or not , its either true or false 
but when we think of ways to write a program, there can be multiple true ways to right a program, 
I feel abstraction leads to reduction of sample space 

if i can think of number of ways i can write a program, can i think of something relevant with it? 
can i use to verify inputs of llms to see if they are contrapositives? like 
user 1 says : 1+2=3 
user 2 says : 1+2 can be 4 
how does llm verify that 

what if we think a program like a 2d system 
the goal is to reach a point 
y is the output space 
x is the input space 
and each input is actually a set of inputs that lead to a final destination 