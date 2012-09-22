## Sample Application featuring Backbone.Marionette and RequireJS(v2.0+) AMD 


### Check out this sample application if you need a little help using RequireJS and Backbone.Marionette.  It takes a more modular approach to the design and layout of the system

I struggled a bit ;-) with Backbone.Marionette and RequireJS, most of my struggles were coming to grips with
configuration, so I created this repo as a means to try out a few new things for my own learning purposes.

I've added the **assetsAMD** folder, the **assets** folder is the original fork of [David Sulc's repo](https://github.com/davidsulc/backbone.marionette-atinux-books)
Backbone.Marionette application which was based on [Atinux](http://www.atinux.fr)'s [Backbone books](http://www.atinux.fr/backbone-books/)
example app and covers important features, such as modal dialogs, loading external templates with RequireJS and configuring Underscore to use Mustache style templates {{ xxx }},
using layouts and regions to load modular sub applications, etc.

Hopefully others can use parts of the js/lib as a shortcut for creating your own Marionette/AMD boilerplate.  There is no right or wrong way to organize
a Marionette app.  I've tried to factor components to a **Model, View, Controller** older structure.  **AppRouters** are a little ambiguous and I've incorporated them into the Controllersfolder.

I have to say, it might be better to place all JS into one folder and prepend the MVC attrib to the file name.  ie **js\Model.book.js, js\View.book.js vs js\Models\book.js, js\Views\book.js**
This way when loading files in your IDE you will have unique file names.  Just a thought to consider as your modular apps grow larger

In this repo I highlighting how to setup Backbone.Marionette using RequireJS / Asyncronous Module Definition (AMD)
and refactored a number of things from the original project to create a more modular MVC with templated views using **underscore**  with **Mustache {{}}** style templating.


See the [indexAMD.html](https://github.com/t2k/backbone.marionette-RequireJS/blob/master/indexAMD.html) for RequireJS startup main.js

NEXT STEPS:  using r.js to optimize build.

Shout out to [Cloud9 IDE](https://c9.io)