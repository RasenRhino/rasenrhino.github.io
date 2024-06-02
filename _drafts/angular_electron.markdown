Now dotoday I have to make a desktop appliction. the problem is I have to do it in 3-4 hours and I only can make it in angular as of now. (it took me 3 days to complete it , and later I had to find ways to convert it into a android application because a future requirement might occur, or host it with authetication and everything)
(I don't want to do this again, so I might as well do it right at once and run away)
now can we make angular into desktop application , if not i am screwed 
So , I got it working yayy 
Used this [link](https://fireship.io/lessons/desktop-apps-with-electron-and-angular/)

you need to take care of three things 
* make sure you make your angular app with ```--no--standalone``` tag. 
* make sure you have main.js added to package.json , something like 
```
  "name": "timerapp",
  "version": "0.0.0",
  "main": "main.js",
```
* The path might be different in the dist folder of new Angular. So make sure the  ```  win.loadURL(`file://${__dirname}/dist/timerapp/browser/index.html`)``` is updated according to your dist folder. 

And you should have an angular app running.
 

Also, I had to shift to a webapp at then end of the day lol