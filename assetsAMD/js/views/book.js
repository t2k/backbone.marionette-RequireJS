// book.js: Ted Killilea June 2012  @t2k_nyc
//  the book item view: when clicked display the modal detailview
//  let the app handle this
define(['underscoreM', 'marionette','templates', 'views/bookdetail', 'vent'], function(_, Marionette, templates, BookDetailView, vent) {
    'use strict';

    return Marionette.ItemView.extend({
        template: _.template(templates.book),

        events: {
            'click': 'showBookDetail'
        },

        showBookDetail: function() {
            var detailView = new BookDetailView({
                model: this.model
            });
            vent.trigger('app.show.modal', detailView);
        }
    });
});