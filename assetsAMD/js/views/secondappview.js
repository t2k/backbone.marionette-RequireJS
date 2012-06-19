// close.js: Ted Killilea June 2012  @t2k_nyc
define(function(require){
    'use strict';
    //var Marionette = ;

    return require('marionette').ItemView.extend({
        template: "#close-template",
        className: "close"
    });
});