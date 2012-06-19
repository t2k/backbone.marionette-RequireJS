// LibraryRouter.js
define(['require', 'app', 'jquery', 'underscore', 'backbone', 'marionette'], function (require, App) {
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
            controller: require('controllers/libraryapp')
        });
        App.vent.trigger("routing:started");
    });


    return LibraryRouting;
});