# Sample Backbone.Marionette modular application using RequireJS/AMD 

I struggled a bit ;-) with Backbone.Marionette and RequireJS, most of my struggles were coming to grips with configuration, so I created this repo as a means to try out a few new things for my own learning purposes.

The **assets** folder is the original fork of [David Sulc's repo](https://github.com/davidsulc/backbone.marionette-atinux-books)  I learned alot from David's Marionette app in terms of using most of marionettes features and it dealt with a more interesting real world back end.  
I learned alot from the namespacing and modular layout but converting the app over to AMD required a different approach in organizing the application.  Modular AMD applications can be a blessing and a curse... at the end of the day AMD forces the developer to pursue a higly decoupled modular architecture.

I've added my stuff to the **assetsAMD**, **components** and **node_module** folders, reworking the Backbone.Marionette application which was based on [Atinux](http://www.atinux.fr)'s [Backbone books](http://www.atinux.fr/backbone-books/)
example app and covers important features, such as modal dialogs, loading external templates with RequireJS and configuring Underscore to use **Mustache style templates {{ xxx }}**,
using layouts and regions to load modular sub applications, etc.  I added [BOWER](http://twitter.github.com/bower/) to the project to manage Open Source Software dependencies.

Check out [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for the RequireJS startup using [assetsAMD/main.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/main.js)

Take a look at the **assetsAMD/js/libs** folder and **assetsAMD/main.js** to see how to setup this  Marionette/AMD application.  There is no right or wrong way to organize
a Marionette app.  I've tried to factor components to a **Model, View, Controller** folder structure.  **AppRouters** are a little ambiguous and I've incorporated them into the Controllersfolder.

I have to say, it might be better to place all JS into one folder and prepend the MVC attrib to the file name.  ie **js\Model.book.js, js\View.book.js vs js\Models\book.js, js\Views\book.js**
This way when loading files in your IDE you will have unique file names in your editor's buffer.  Just a thought to consider as your modular apps grow large.  It's a matter of preference and alot depends upon the indivual developers and the 

### Using [BOWER](http://twitter.github.com/bower/) to maintain project dependencies.
My biggest challenge with open source software is maintaining the ever increasing dependencies as your project grows in scope.  If you've never used [BOWER](http://twitter.github.com/bower/) I highly recommend taking a the time to detour over there and grok it out.
Grok [NODEJS](http://nodejs.org) also.  Lucky for me I'm using [Cloud9 IDE](https://c9.io) a web based IDE with a built in unix terminal and SHell with Node pre-installed.

#### Bower Installation
From the terminal/BASH $ prompt:

First off, NODE v0.8+ is required for __BOWER__ installation, as I'm writing this, NODE v 6.2.1 is pre istalled in the ***Cloud9 IDE*** but they also pre-install [NVM Node Version Manager](https://github.com/creationix/nvm) so you can update the Cloud9 workspace to NODE v0.8+ as required for __BOWER__

Press [alt-t] to open a terminal with [bash shell](http://linuxcommand.org/learning_the_shell.php) commands.  Pretty amazing, the project has full featured unix environment available in a browser based [Cloud9 IDE](https://c9.io)!

To switch to node version 0.8+
~~~    
$ nvm use 0.8
~~~
***Install BOWER***
~~~
$ npm install bower
~~~

Bower will be installed locally at your project root

#### Use Bower To Install Project Dependencies
This simple project has quite a list of dependencies, but don't go away angry, it's very easy using __BOWER__ to install these open source libraries into this project.

__PROJECT DEPENDENCIES__  
1. jquery  
2. bootstrap  
3. requirejs  
4. requirejs-text  
5. r.js  
2. underscore-amd  
3. backbone-amd#0.9.2  
4. backbone.wreqr  
5. backbone.eventbinder  
6. backbone.babysitter  
6. marionette  

~~~    
$ bower install --save jquery bootstrap requirejs requirejs-text underscore-amd backbone-amd#0.9.2 backbone.wreqr backbone.eventbinder marionette
~~~

__backbone.babysitter and r.js are not registered in bower so, just bower manually install the git version (see bower info)__  

~~~
$ bower install --save git://github.com/marionettejs/backbone.babysitter.git
$ bower install --save git://github.com/jrburke/r.js.git
~~~
    
The __bower install --save__ option creates [component.json](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/component.json) in the project directory.

At a later date the project dependencies can be updated with ***one*** command:
   
~~~   
$ bower update
~~~

You can handle that!

## The M in AMD-- Benefit and a Curse
Modular design in javascript is the key to building scaleable and maintainable web applications.  However, each module can create multiple http get requests when our page loads.  Remove the __curse__ with [R.js](git://github.com/jrburke/r.js.git) optimizer. 

### [R.js](https://github.com/jrburke/r.js.git) build Optimizer
Using [R.js](https://github.com/jrburke/r.js.git) optimizer to compress/minimize/uglify your main.js file.  Eliminate or dramatically reduce server requests upon you first page load.

#### optimize javascript loading with R.js 
Here's how I did it for this project in __Cloud9IDE__ 

__Build the optimized verions of main.js__

Pass the [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) file as a command line argument to [R.js](https://github.com/jrburke/r.js.git) 
~~~
$ cd assetsAMD/build
$ node ../../components/r.js/dist/r.js -o app.build.js
~~~

***This previous step can/should be scrpted into a build process***

SEE [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) for details.
    
The optimizer 'output' builds the assetsAMD/js/main.optimized.js that gets linked to [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html).

SEE [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for details.

***Good luck on your open source journey!***
        

Big shout-out to [Cloud9 IDE](https://c9.io) and Google Chrome Extension [Cloud 9 Button for Github](https://chrome.google.com/webstore/detail/gkddhhofgajgmgfebhaiihlahjmjkmph) one click to clone/edit any github repo.  Fantastic!
