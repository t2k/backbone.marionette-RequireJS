## Marionette Bookstore ##
### Backbone.Marionette application using RequireJS/AMD and Coffescript ###

**See this LIVE [Marionette Bookstore](https://c9.io/t2k/backbone_marionette-requirejs/workspace/indexAMD.Devel.html) application before digging in...**

This is a simple 100% client-side application utilizing the [Google Books API](https://developers.google.com/books/docs/v1/using#WorkingVolumes).  It is _NOT a true WEBAPP__
because we aren't responsible for dealing with server-side activities like (__NodeJS: connect/express, MongoDB,  Ruby: active-record__ etc. )
The focus remains centered on _Marionette AMD_ and hopefully borrowing application architecture ideas from the **Rails Asset Pipeline**

I struggled a bit ;-) with Backbone.Marionette and RequireJS, most of my struggles are the consequence of my enterprise C#/VB.NET server side background
experience... so coming to grips with modular javascript client application architecture was a challenge.  I've updated a few things recently with lessons learned.

###assets###
The **assets** folder is the original fork of [David Sulc's repo](https://github.com/davidsulc/backbone.marionette-atinux-books)
I learned alot from David's Marionette app in terms of using most of marionettes features and it dealt with a more interesting real world back end.
I learned alot from the namespacing and modular layout but converting the app over to AMD required a different approach in organizing the application.
Modular AMD applications can be a blessing and a curse... at the end of the day AMD forces the developer to pursue a higly decoupled modular architecture.

###assetsAMD###
My source is located under the **assetsAMD** folder.  The **components** and **node_module** folder hold **BOWER** and **NPM** dependencies. Refer to the
**assets** folder to see the orig. repo of Backbone.Marionette application using javascript namespacing, which was based on [Atinux](http://www.atinux.fr)'s
[Backbone books](http://www.atinux.fr/backbone-books/) example app and covers important features, such as modal dialogs.

Check out [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for the RequireJS startup using
[assetsAMD/main.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/main.js)

### Updates May 2013 ###
After watching the excellent [BackboneRails](http://backbonerails.com) screencasts I have __Mann__'d up by re-structuring this application's architecture.
Brian's excellent tutorials use ruby rails and __Marionette.module__ patter with javascript namespacing.  My focus here was to use an RequireJS/AMD based
application architecture.  I've tried to follow the Rails Asset Pipeline approach from Brian's screencast which entails more or less following a consistant
folder structure when building out your application/module architecture.  The AMD approach does not follow the same javascript namespaing pattern made so
easy by the **Marionette.module** but the AMD approach does offer what I feel is a more modular building block approach with true modules that are not
necessarily coupled to the application specific namespaceing patterns.  I used a [msgBus](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/msgbus.coffee)
module that leverages **backbone.Wreqr** events, commands and request/response patterns to facilitate inter-application communication.

### CoffeeScript ###
Switching to coffee-script has made me a javascript __BALLER!__ I knew about coffee-script,  read the little book about it, but never changed my ways.
Watching Brian Mann's screencast convinced me of it's ease of use.  Now I can honestly say that I am a __1000%__ better javascript programmer because of it.

So easy to install, it's a shame not to:
~~~
$ npm install -g coffee-script
~~~

To begin using coffee-script in this project:
~~~
$ coffee -o assetAMD/js/ -cw assetAMD/js/
~~~
Now, all changes to any .coffee file is automatically compiled to javascipt. For more coffescript usage info go to the source: [coffeescript.org](http://coffeescript.org)
and to help convert your existing javascripts to CoffeeScript: __go here [js2coffee.org](http://js2coffee.org)__

###Config###
The __config__ folder holds global application level configuration for __underscore templatesettings__, __marionette templatecache__ and a custom __Marionette.Region.Dialog__
class that displays a boostrap modal and also takes care of view/event cleanup.  I picked this up from **Brian Mann**  These techniques are a huge improvement over what I had
been using previously.  Don't think I could have coded this stuff with my own hand crafted javascript.

* [config/_base.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/config/_base.coffee)
* [config/marionette/region/dialog.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/config/marionette/region/dialog.coffee)
* [config/marionette/templatecache.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/config/marionette/templatecache.coffee)
* [config/underscore/templatesettings.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/config/underscore/templatesettings.coffee)

### index.html ###
Take a look at [index.AMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html), the Single Page that gets served for
this single page application.  One of the benefits of RequireJS/AMD is this simplicity.  There is no right or wrong way to organize a Marionette app, but I favor
the AMD approach for it's ease of loading for a single page application.  Notice there is only one javascript loaded **js/main**.

### main.js ###
The [js/main.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/main.coffee) file loaded at the bottom of index.html is the requirejs
bootloader.  See __[requirejs.org](http://requirejs.org)__ for up to date information on RequireJS and the benefits of AMD script loading.

### marionette application start ###
* [the main app.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/app.coffee)

### modular applications

### book entities ###
 A __Backbone.Collection [entities/book](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/entities/book.coffee)__
is used to encapsulate the [Google Books API](https://developers.google.com/books/docs/v1/using#WorkingVolumes).  Checkout the __search__, __fetchBooks__ and
__moreBooks__ methods and the msgBus.events setup in the initialize method.  The msgBus pub/sub pattern is used to help create a decoupled modular architecture.

### book list application
Drill down on the modular source for the apps/book applications, it's listed below.  Notice how the apps/book/app __requires__ the apps/book/list/controller and how
the CONTROLLER __requires__ the VIEWS and how the VIEWS __requires__ TEMPLATES and these templates are ultimately made of __HTML__ snippets in {{MUSTACHE}} format.
* __apps__
    * __book__
        * __list__
            * [controller.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/controller.coffee) - the book list controller
            * [templates.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates.coffee) - the book list templates
            * [views.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/views.coffee) - the book list views
            * __templates__ (template files <3 mustache format)
                *  [layout.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/layout.htm)
                *  [book.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/book.htm)
                *  [booklist.htm](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/list/templates/booklist.htm)
    *  [app.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/apps/book/app.coffee) - apps/book/app  the book application
* [app.coffee](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/js/app.coffee)  - app (the main marionette application)

### Get to know [BOWER](http://twitter.github.com/bower/) and automatically maintain project dependencies. ###
My biggest early challenge with open source software was maintaining the ever increasing dependencies.  If you've never used
BOWER](http://twitter.github.com/bower/) I highly recommend taking a the time to detour over there and grok it out.  Grok [NODEJS](http://nodejs.org).
Lucky for me I'm using [Cloud9 IDE](https://c9.io) a web based IDE with a built in unix terminal and __SH__ell with Node pre-installed.

#### Bower and CoffeScript Installation
From the terminal/BASH $ prompt:
First off, NODE v0.8+ is required for __BOWER__ installation, as I'm writing this, NODE v 6.2.1 is pre istalled in the ***Cloud9 IDE*** but they also pre-install
[NVM Node Version Manager](https://github.com/creationix/nvm) so you can update the Cloud9 workspace to NODE v0.8+ as required for __BOWER__

Press [alt-t] to open a terminal with [bash shell](http://linuxcommand.org/learning_the_shell.php) commands.  Pretty amazing, the project has full
featured unix environment available in a browser based [Cloud9 IDE](https://c9.io)!

***Install BOWER and Coffee-script ***
~~~
$ npm install -g bower
$ npm install -g coffee-script
~~~

Bower will be installed globally

### Project Dependencie ###
* See [component.json](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/component.json) to see this project's dependencies

~~~
$ bower install
~~~

As time passes on, update the project dependencies with **ONE** command:
~~~
$ bower update
~~~
Even __I__ can handle that!

## The M in AMD-- Benefit and a Curse
Modular design in javascript is the key to building scaleable and maintainable web applications.  However, each module can create multiple http get
requests when our page loads.  Remove the __curse__ with [R.js](git://github.com/jrburke/r.js.git) optimizer.

### [R.js](https://github.com/jrburke/r.js.git) build Optimizer
Using [R.js](https://github.com/jrburke/r.js.git) optimizer to compress/minimize/uglify your main.js file.  Eliminate or dramatically reduce
server requests upon you first page load.

#### optimize javascript loading with R.js
Here's how I did it for this project in __Cloud9IDE__

__Build the optimized verions of main.js__

Pass the [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) file as a command line
argument to [R.js](https://github.com/jrburke/r.js.git)
~~~
$ cd assetsAMD/build
$ node ../../components/r.js/dist/r.js -o app.build.js
~~~
***This previous step can/should be scrpted into a build process***

SEE [app.build.js](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/assetsAMD/build/app.build.js) for details.

The optimizer 'output' builds the assetsAMD/js/main.optimized.js that gets linked to [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html).

SEE [indexAMD.Devel.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.Devel.html) for details.

Big shout-out to [Cloud9 IDE](https://c9.io) and Google Chrome Extension [Cloud 9 Button for Github](https://chrome.google.com/webstore/detail/gkddhhofgajgmgfebhaiihlahjmjkmph)
one click to clone/edit any github repo.  Fantastic!

***Good luck on your open source journey!***