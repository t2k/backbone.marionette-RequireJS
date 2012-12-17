# Sample Backbone.Marionette modular application using RequireJS/AMD 

I struggled a bit ;-) with Backbone.Marionette and RequireJS, most of my struggles were coming to grips with configuration, so I created this repo as a means to try out a few new things for my own learning purposes.

The **assets** folder is the original fork of [David Sulc's repo](https://github.com/davidsulc/backbone.marionette-atinux-books)  I learned alot from David's Marionette app in terms of using most of marionettes features and it dealt with a more interesting real world back end.  
I learned alot from the namespacing and modular layout but converting the app over to AMD required a different approach in organizing the application.  Modular AMD applications can be a blessing and a curse... at the end of the day AMD forces the developer to pursue a higly decoupled modular architecture.

I've added my stuff to the **assetsAMD** folder, reworking the Backbone.Marionette application which was based on [Atinux](http://www.atinux.fr)'s [Backbone books](http://www.atinux.fr/backbone-books/)
example app and covers important features, such as modal dialogs, loading external templates with RequireJS and configuring Underscore to use Mustache style templates {{ xxx }},
using layouts and regions to load modular sub applications, etc.

Check out [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html) for the RequireJS startup using [assetsAMD/main.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/main.js)

Take a look at the **assetsAMD/js/libs** folder and **assetsAMD/main.js** to see how to setup this  Marionette/AMD application.  There is no right or wrong way to organize
a Marionette app.  I've tried to factor components to a **Model, View, Controller** folder structure.  **AppRouters** are a little ambiguous and I've incorporated them into the Controllersfolder.

I have to say, it might be better to place all JS into one folder and prepend the MVC attrib to the file name.  ie **js\Model.book.js, js\View.book.js vs js\Models\book.js, js\Views\book.js**
This way when loading files in your IDE you will have unique file names in your editor's buffer.  Just a thought to consider as your modular apps grow large.  It's a matter of preference and alot depends upon the indivual developers and the 

## Using RequireJS build Optimizer r.js

Using r.js optimizer to compress/minimize/uglify your main.js file.  Eliminate or dramatically reduce server requests upon you first page load.

### Using [BOWER](http://twitter.github.com/bower/) to maintain project dependencies

#### Bower Installation

NODE v0.8+ is required for __BOWER__ installation

Your Cloud9 IDE workspace has a built in Linux terminal with [bash shell](http://linuxcommand.org/learning_the_shell.php) commands available.  Press [alt-t] to create a new terminal window. You have a full unix environment available to use at your project workspace.

#### Bower Inatallation
    From the terminal/bash shell at your project root  [alt-t]
    To ensure you are using node version 0.8
    
    //$ nvm use 0.8
        
    //$ npm install bower
        Bower will be installed locally at your project root

#### Use Bower To Install Components
    From the bash prompt $
    
    //$ bower install --save  marionette underscore-amd backbone-amd marionette jquery bootstrap backbone.eventbinder backbone.wreqr
    
    __backbone.babysitter was not registered in bower yet__
    
    //$bower install --save git://github.com/marionettejs/backbone.babysitter.git
    
    __r.js was not registered in bower__
    
    //$ bower install --save git://github.com/jrburke/r.js.git
    
    The bower install --save option creates:
    
[component.json](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/component.json) 

    At a later date the project dependencies can be updated with one command
    
//$ bower update
    
#### optimize javascript loading with r.js 
    [alt-t] from the bash prompt $
    cd assetsAMD/build
    //$ node ../../components/r.js/dist/r.js -o app.build.js
    
SEE [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) for details.
    
    The optimizer builds assetsAMD/js/main.optimized.js

SEE [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html) for details.
SEE [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for details.
    
    Good luck on your open source journey!
        

Big shout-out to [Cloud9 IDE](https://c9.io) and Google Chrome Extension [Cloud 9 Button for Github](https://chrome.google.com/webstore/detail/gkddhhofgajgmgfebhaiihlahjmjkmph) one click to clone/edit any github repo.  Fantastic!