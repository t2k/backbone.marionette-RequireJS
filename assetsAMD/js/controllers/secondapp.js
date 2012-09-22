// secondapp.js
define(['backbone', 'marionette', 'views/secondappview', 'app', 'vent'], function(Backbone, Marionette, AppView, App, vent)  {
    'use strict';

    // private module/app router  capture the #seconapp route and call start method of our controller
    var Router = Marionette.AppRouter.extend({
        appRoutes: {
            "secondapp": "start"
        }
    });

    var Controller = {};


    // Start the app by showing the appropriate views    
    Controller.start = function() {
        var view = new AppView();
        vent.trigger('app:show', view);
        Backbone.history.navigate('secondapp');
    };


    App.addInitializer(function() {
        console.log('addInitializer from secondapp.js');
        new Router({
            controller: Controller
        });
    });

    return Controller;
});