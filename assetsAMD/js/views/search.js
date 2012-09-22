// search.js: Ted Killilea June 2012  @t2k_nyc
// view depends upon app and backbone
// search view
define(['backbone', 'marionette', 'vent'], function(Backbone, Marionette, vent) {
    'use strict';

    var SearchView = Marionette.ItemView.extend({
        el: "#searchBar",

        initialize: function() {
            var self = this;
            var $spinner = self.$('#spinner');
            vent.on("search:start", function() {
                $spinner.fadeIn();
            });
            vent.on("search:stop", function() {
                $spinner.fadeOut();
            });
            vent.on("search:term", function(term) {
                self.$('#searchTerm').val(term);
            });
        },

        events: {
            'change #searchTerm': 'search'
        },

        search: function() {
            var searchTerm = this.$('#searchTerm').val().trim();
            if (searchTerm.length > 0) {
                vent.trigger("search:term", searchTerm);
            }
            else {
                vent.trigger("search:noSearchTerm");
            }
        }
    });

    vent.on("search:term", function(searchTerm) {
        Backbone.history.navigate("search/" + searchTerm);
    });

    return SearchView;
});
