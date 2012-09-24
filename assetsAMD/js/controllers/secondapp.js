// secondapp.js
// note for brevity this controller also contains the definition of the router for this sub-app/module
define(['marionette', 'views/secondappview', 'vent'], function(Marionette, AppView, vent) {
    'use strict';

    var Controller = {};

    // private module/app router  capture the #seconapp route and call start method of our controller
    Controller.Router = Marionette.AppRouter.extend({
        appRoutes: {
            "secondapp": "start"
        }
    });

    // Start the app by showing the appropriate views    
    Controller.start = function() {
        var view = new AppView();
        vent.trigger('app:show', view);
        //Backbone.history.navigate('secondapp');
    };

    return Controller;
});