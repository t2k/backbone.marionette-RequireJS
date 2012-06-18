// menu.js: Ted Killilea June 2012 : twitter.com/@t2k_nyc
define(['require', 'jquery', 'underscore', 'backbone', 'marionette'], function (require) {
    'use strict';

    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');


    // set up the marionette/app instance
    var MenuView = Backbone.Marionette.View.extend({
        el: "#menu",

        events: {
            'click #menu .js-menu-books': 'showLibraryApp',
            'click #menu .js-menu-close': 'closeApp'
        },

        showLibraryApp: function (e) {
            e.preventDefault();
            //console.log('default search......');
            require('./controllers/libraryapp').defaultSearch();
        },
        closeApp: function (e) {
            e.preventDefault();
            //console.log('close implemented...');
            require('./controllers/closeapp').close();
        }
    });

    require('app').vent.on("layout:rendered", function () {
        //console.log('load menu view');
        var menuView = new MenuView();
        require('app').menu.attachView(menuView);
    });

    return MenuView;
});