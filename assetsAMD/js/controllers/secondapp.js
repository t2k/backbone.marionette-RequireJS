// closeapp.js
define(['require', 'app' , /* 'jquery', 'underscore', 'backbone', 'marionette',*/ 'views/secondappview'], function (require, App) {
    'use strict';

    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');


    var thisModule = {};


    thisModule.Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            "secondapp": "secondapp"
        }
    });


    thisModule.secondapp = function () {
        var CloseView = require('views/secondappview'); // modular view;
        App.content.show(new CloseView());
        Backbone.history.navigate("secondapp");
    };

    App.addInitializer(function () {
        new thisModule.Router({
            controller: thisModule // just needs to implement 'secondapp'
        });
        App.vent.trigger("routing:started");
    });

    return thisModule;

});