// bookdetail.js: Ted Killilea June 2012  @t2k_nyc
// templates/bookdetail.htm
define(['underscoreM', 'marionette', 'templates' ], function(_, Marionette, templates) {
    'use strict';

    return Marionette.ItemView.extend({
        template: _.template(templates.bookdetail),
        className: "modal bookDetail"
    });
});