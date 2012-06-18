// search.js: Ted Killilea June 2012  @t2k_nyc

define(['jquery','underscore','backbone','marionette','app', 'controllers/libraryapp'],

function ($, _, Backbone, Marionette, MyApp, LibraryApp) {
    'use strict';


    var SearchView =  Backbone.View.extend({
        el: "#searchBar",

        initialize: function () {
            var self = this;
            var $spinner = self.$('#spinner');
            MyApp.vent.on("search:start", function () {
                $spinner.fadeIn();
            });
            MyApp.vent.on("search:stop", function () {
                $spinner.fadeOut();
            });
            MyApp.vent.on("search:term", function (term) {
                self.$('#searchTerm').val(term);
            });
        },

        events: {
            'change #searchTerm': 'search'
        },

        search: function () {
            var searchTerm = this.$('#searchTerm').val().trim();
            if (searchTerm.length > 0) {
                MyApp.vent.trigger("search:term", searchTerm);
            }
            else {
                MyApp.vent.trigger("search:noSearchTerm");
            }
        }
    });

        // one time init for our applicaiton
    MyApp.vent.on("layout:rendered", function () {
        console.log('vent.on  setup searchview...');
        // render a view for the existing HTML in the template, and attach it to the layout (i.e. don't double render)
        var searchView = new SearchView();
        LibraryApp.layout.search.attachView(searchView);
    });


    return SearchView;
});
