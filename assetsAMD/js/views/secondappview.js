// secondappview.js: Ted Killilea June 2012  @t2k_nyc

define(['underscoreM', 'marionette', 'templates'], function(_, Marionette, templates) {
    'use strict';

    return Marionette.ItemView.extend({
        template: _.template(templates.secondapp), //"#close-template",
        className: "close"
    });
});