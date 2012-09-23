## Sample Backbone.Marionette modular application using RequireJS/AMD 

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

NEXT STEPS:  using r.js to optimize build and unit testing.  Both new to me...

Big shout-out to [Cloud9 IDE](https://c9.io) and Google Chrome Extension [Cloud 9 Button for Github](https://chrome.google.com/webstore/detail/gkddhhofgajgmgfebhaiihlahjmjkmph) one click to clone/edit any github repo.  Fantastic!