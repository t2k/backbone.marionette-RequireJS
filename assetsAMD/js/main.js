// Filename: main.js
// requireJS bootloader file typically included in the index.html
require.config({
    //baseURL: 'assetsAMD/js',

    paths: {
        jquery: '../../components/jquery/jquery',  // amd version
        underscore: '../../components/underscore-amd/underscore', // amd version
        underscoreM: 'libs/underscore/underscore-mustache',  // templating supporting mustache style {{ ... }}
        backbone: '../../components/backbone-amd/backbone', // amd version
        'backbone.wreqr': '../../components/backbone.wreqr/lib/amd/backbone.wreqr', // amd version
        'backbone.eventbinder': '../../components/backbone.eventbinder/lib/amd/backbone.eventbinder', // amd version
        'backbone.babysitter': '../../components/backbone.babysitter/lib/amd/backbone.babysitter', // amd version
        marionette: '../../components/marionette/lib/core/amd/backbone.marionette',  // amd version
        bootstrap: '../../components/bootstrap/docs/assets/js/bootstrap-modal', 
        text: '../../components/requirejs-text/text'
    },

    // load the 'non AMD' versions of backbone, underscore and Marionette
    shim: {
        bootstrap: ['jquery']
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