// books.js
define(['jquery', 'underscoreM', 'backbone', 'vent'], function( $, _, Backbone, vent) {
    'use strict';

    // private
    var Book = Backbone.Model.extend();

    // public API for this module return a collection
    return Backbone.Collection.extend({
        model: Book,

        initialize: function() {
            var self = this;
            _.bindAll(this, "search", "moreBooks");

            vent.on("search:term", function(term) {
                self.search(term);
            });

            vent.on("search:more", function() {
                self.moreBooks();
            });

            // the number of books we fetch each time
            this.maxResults = 40;
            // the results "page" we last fetched
            this.page = 0;

            // flags whether the collection is currently in the process of fetching
            // more results from the API (to avoid multiple simultaneous calls
            this.loading = false;

            // remember the previous search
            this.previousSearch = null;
            // the maximum number of results for the previous search
            this.totalItems = null;
        },

        search: function(searchTerm) {
            this.page = 0;

            var self = this;
            this.fetchBooks(searchTerm, function(books) {
                if (books.length < 1) {
                    vent.trigger("search:noResults");
                }
                else {
                    self.reset(books);
                }
            });

            this.previousSearch = searchTerm;
        },

        moreBooks: function() {
            // if we've loaded all the books for this search, there are no more to load !
            if (this.length >= this.totalItems) {
                return true;
            }

            var self = this;
            this.fetchBooks(this.previousSearch, function(books) {
                self.add(books);
            });
        },

        fetchBooks: function(searchTerm, callback) {
            if (this.loading) return true;

            this.loading = true;

            var self = this;
            vent.trigger("search:start");

            var query = encodeURIComponent(searchTerm) + '&maxResults=' + this.maxResults + '&startIndex=' + (this.page * this.maxResults) + '&fields=totalItems,items(id,volumeInfo/title,volumeInfo/subtitle,volumeInfo/authors,volumeInfo/publishedDate,volumeInfo/description,volumeInfo/imageLinks)';

            $.ajax({
                url: 'https://www.googleapis.com/books/v1/volumes',
                dataType: 'jsonp',
                data: 'q=' + query,
                success: function(res) {
                    vent.trigger("search:stop");
                    if (res.totalItems === 0) {
                        callback([]);
                        return [];
                    }
                    if (res.items) {
                        self.page++;
                        self.totalItems = res.totalItems;
                        var searchResults = [];
                        _.each(res.items, function(item) {
                            var thumbnail = null;
                            if (item.volumeInfo && item.volumeInfo.imageLinks && item.volumeInfo.imageLinks.thumbnail) {
                                thumbnail = item.volumeInfo.imageLinks.thumbnail;
                            }
                            searchResults[searchResults.length] = new Book({
                                thumbnail: thumbnail,
                                title: item.volumeInfo.title,
                                subtitle: item.volumeInfo.subtitle,
                                description: item.volumeInfo.description,
                                googleId: item.id
                            });
                        });
                        callback(searchResults);
                        self.loading = false;
                        return searchResults;
                    }
                    else if (res.error) {
                        vent.trigger("search:error");
                        self.loading = false;
                    }
                }
            });
        }
    });

});