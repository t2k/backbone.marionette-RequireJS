// LibraryRouter.js
define(['require', 'app', 'controllers/libraryapp', 'jquery', 'underscore', 'backbone', 'marionette'], function (require, App, Controller) {
    'use strict';

    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');


    var LibraryRouting = {};

    LibraryRouting.Router = Backbone.Marionette.AppRouter.extend({
        appRoutes: {
            "": "defaultSearch",
            "search/:searchTerm": "search"
        }
    });


    App.addInitializer(function () {
        new LibraryRouting.Router({
            controller: Controller
        });
        App.vent.trigger("routing:started");
    });

    App.vent.on("search:term", function (searchTerm) {
        Backbone.history.navigate("search/" + searchTerm);
    });

    return LibraryRouting;
});