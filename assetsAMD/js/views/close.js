// close.js: Ted Killilea June 2012  @t2k_nyc
define(function(require){
    'use strict';
    var Marionette = require('marionette');

    return Marionette.ItemView.extend({
        template: "#close-template",
        className: "close"
    });
});