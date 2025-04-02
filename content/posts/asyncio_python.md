---
title: Asyncio Python - an explorers account
date: 2024-04-02
tags: [os,python,asyncio]
---
Asyncio is CONCURRENT execution 

Python supports concurrency through threading and asyncio, but due to the GIL, threads can't run Python bytecode in parallel. That's why asyncio is preferred for I/O-bound concurrency.

NOTE that is is different from python processes, in that you have a new interpreter for each process , and avoiding the GIL entirely allowing true parallel execution. 

Asyncio is less resource intensive ? (perhaps do your own research about this, I will use this argument as this corroborates my percieved consensus)

Example code I will use throughout this post :-  

```
import asyncio

async def task1():
    print("Task 1 started")
    await asyncio.sleep(2)
    print("Task 1 done")

async def task2():
    print("Task 2 started")
    await asyncio.sleep(2)
    print("Task 2 done")

async def main():
    await task1()
    await task2()

asyncio.run(main())

```

output :-


```
Task 1 started
(wait 2s)
Task 1 done
Task 2 started
(wait 2s)
Task 2 done
```

Since 

but if i do this :-
Parallel tasks with asyncio.create_task

```
async def main():
    t1 = asyncio.create_task(task1())
    t2 = asyncio.create_task(task2())
    await t1
    await t2

```

output :-

```
Task 1 started
Task 2 started
(wait 2s)
Task 1 done
Task 2 done
```

but this is because asyncio.sleep yeilds to the event loop , if you used `time.sleep` instead, it will be blocking, so only after task1 is finished, task2 will be done. 

##### TLDR : you change `asyncio.sleep` to `time.sleep` , you will have an output like this :-

```
Task 1 started
(wait 2s)
Task 1 done
Task 2 started 
(wait 2s)
Task 2 done
```

Moving on...


lets say you do something like 

```
async def main():
    asyncio.create_task(task1())  # NOT awaited
    await task2()                 # Only await t2
```
It will cause you some problems. 

Because the main coroutine (main()) finishes once task2 is done, the event loop shuts down, and any background tasks that haven’t completed are cancelled unless explicitly awaited or held open.

Your output will look something like :-

```
Task 1 started
Task 2 started
Task 2 done
```


Summary of pointers and some more things you might want to take care of :-

### Try to avoid blocking 

use something like `await loop.run_in_executor(None, blocking_func)`. Or use asyncio primitives (eg: `asyncio.sleep()`)


### Don't forget to `await` your `create_task()`

Creating a task doesn’t mean it’ll finish.


### Use `asyncio.gather()` vs `asyncio.wait()` properly

`asyncio.gather()` : waits for all tasks and **fails fast** on first exception
`asyncio.wait()` : gives more fine-grained control (FIRST_COMPLETED, ALL_COMPLETED, etc.)

Use `return_exceptions=True` with `gather()` if you want to collect all exceptions instead of crashing.


### Unhandled Exceptions in Tasks are Silent by Default

Debug that. Or you can use exception handling. Your choice. 
you can also do something like 

```
t = asyncio.create_task(my_task())
t.add_done_callback(lambda t: print(t.exception()))  # surfaces uncaught exception
```


### Coroutines aren't tasks until you schedule them

```
coro = my_async_func()        # ← Just a coroutine object
task = asyncio.create_task(coro)  # ← Now it's scheduled to run
```


### You can use `asyncio.Semaphore()` or `asyncio.BoundedSemaphore()` to limit concurrency


### Timeouts with `asyncio.wait_for()`

```
try:
    await asyncio.wait_for(my_func(), timeout=5)
except asyncio.TimeoutError:
    print("Timed out!")
```

