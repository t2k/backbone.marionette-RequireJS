// Filename: main.js
// This is the requireJS bootloader file typically included in the index.html
requirejs.config({
    baseURL: 'assetsAMD/js',
    paths: {
        jquery: ['http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min', 'libs/jQuery/jquery-1.7.2-min'],
        underscore: 'libs/underscore/underscore',
        backbone: 'libs/backbone/backbone',
        marionette: 'libs/backbone/backbone.marionette',
        bootstrapModal: '../../assets/javascript/vendor/bootstrap-modal',
        text: 'libs/require/text'
    },

    // load the 'non AMD' versions of backbone, underscore and Marionette
    shim: {
        'bootstrapModal': ['jquery'],

        'backbone': {
            deps: ['underscore', 'jquery'],
            exports: 'Backbone'
        },
        'marionette': {
            deps: ['backbone'],
            exports: 'Backbone.Marionette'
        }
    }
});


requirejs(['app', 'controllers/libraryapp', 'views/booklist', 'controllers/libraryrouter', 'controllers/closeapp'],

function (MyApp) {
    'use strict';
    MyApp.start();
});