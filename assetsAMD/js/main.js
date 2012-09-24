// Filename: main.js
// requireJS bootloader file typically included in the index.html
require.config({
    baseURL: 'assetsAMD/js',

    paths: {
        // use google CDN or fallback to local copy of jquery
        jquery: ['https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min', 'libs/jQuery/jquery-1.8.2'],
        underscore: 'libs/underscore/underscore-1.3.3',
        underscoreM: 'libs/underscore/underscore-mustache',  // underscore templating supporting mustache style {{ ... }}
        backbone: 'libs/backbone/backbone-0.9.2',
        marionette: 'libs/backbone/backbone.marionette-0.10.2',
        bootstrap: 'libs/bootstrap/bootstrap-modal', //-2.1.1',  // just using .modal for now but loading entire js bootstrap
        text: 'libs/require/text-2.0.3'
    },

    // load the 'non AMD' versions of backbone, underscore and Marionette
    shim: {
        underscore: {
            exports: '_'
        },

        bootstrap: ['jquery'],

        // note: these are all NON-AMD versions of backbone/marionette, load with dependencies
        backbone: {
            deps: ['jquery', 'underscore'],
            exports: 'Backbone'
        },

        marionette: {
            deps: ['backbone'],
            exports: 'Backbone.Marionette'
        }

    }
});

require(['app', 'controllers/librarycontroller', 'controllers/libraryrouter', 'controllers/secondapp'], function(App, libraryController, libraryRouter, secondApp) {
    'use strict';

    var options = {
            libraryController: libraryController,
            libraryRouter: libraryRouter,
            secondApp: secondApp
    };
    
    App.start(options);
});