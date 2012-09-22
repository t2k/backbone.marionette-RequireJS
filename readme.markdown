## Sample Application featuring Backbone.Marionette and RequireJS(v2.0+) AMD 


### Check out this sample application if you need a little help using RequireJS and Backbone.Marionette.  It takes a more modular approach to the design and layout of the system

I struggled a bit ;-) with Backbone.Marionette and RequireJS, most of my struggles were coming to grips with
configuration, so I created this repo as a means to try out a few new things for my own learning purposes.

I've added the **assetsAMD** folder, the **assets** folder is the original fork of [David Sulc's repo](https://github.com/davidsulc/backbone.marionette-atinux-books)
Backbone.Marionette application which was based on [Atinux](http://www.atinux.fr)'s [Backbone books](http://www.atinux.fr/backbone-books/)
example app and covers some slightly advanced subjects, such as modal dialogs, sub applications, etc.

Hopefully others can use parts of the js/lib as a shortcut for creating your own Marionette/AMD boilerplate.

In this repo I highlighting how to setup Backbone.Marionette using RequireJS / Asyncronous Module Definition (AMD)
and refactored a number of things from the original project to create a more modular MVC with templated views using **underscore**  with **Mustache {{}}** style templating.


See the [indexAMD.html](https://github.com/t2k/bb.m-atinux-books-RequireJS/blob/master/indexAMD.html) for RequireJS startup main.js

