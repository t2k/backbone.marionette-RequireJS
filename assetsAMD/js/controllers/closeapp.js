// closeapp.js
define(['require', 'app', 'jquery', 'underscore', 'backbone', 'marionette'], function (require, App) {
    'use strict';
    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');


    var thisModule = {};

    thisModule.DefaultView = Backbone.Marionette.ItemView.extend({
        template: "#close-template",
        className: "close"
    });

    thisModule.Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            "close": "close"
        }
    });

    thisModule.close = function () {
        var closeView = new thisModule.DefaultView();
        App.content.show(closeView);
        Backbone.history.navigate("close");
    };

    App.addInitializer(function () {
        new thisModule.Router({
            controller: thisModule // just needs to implement 'close'
        });
        App.vent.trigger("routing:started");
    });

    return thisModule;

});