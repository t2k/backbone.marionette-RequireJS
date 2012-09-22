// LibraryRouter.js
// hookup the default "" and search routes for the library
define(['marionette', 'app', 'controllers/librarycontroller'], function(Marionette, App, controller) {
    'use strict';

    var LibraryRouting = {};

    LibraryRouting.Router = Marionette.AppRouter.extend({
        appRoutes: {
            "": "defaultSearch",
            "search/:searchTerm": "search"
        }
    });
    
    // add the routes to our marionette applications start queue...
    App.addInitializer(function() {
        console.log('addInitializer => libraryrouter');
        new LibraryRouting.Router({
            controller: controller // controller must implement search and defaultsearch
        });
    });

    return LibraryRouting;
});