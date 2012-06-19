// Filename: main.js
// This is the requireJS bootloader file typically included in the index.html
requirejs.config({
    baseURL: 'assetsAMD/js',
    paths: {
        // use google CDN or fallback to local copy of jquery
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
        // note: these are all NON-AMD versions of backbone/marionette, load with dependencies
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


requirejs(['require','app', 'controllers/libraryapp', 'views/booklist', ,'controllers/libraryrouter', 'controllers/secondapp'],

function (require, MyApp) {
    'use strict';

        MyApp.start();


});