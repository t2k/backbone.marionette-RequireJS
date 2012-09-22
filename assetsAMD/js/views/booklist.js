// booklist.js
define(['underscoreM', 'marionette', 'templates', 'views/book',  'vent'], function(_, Marionette, templates, BookView,  vent) {
    'use strict';

    // 
    var BookList = {};

    // private module level var
    var BookListView = Marionette.CompositeView.extend({
     template: _.template(templates.booklist), //"#book-list-template",
        id: 'bookList',  // ! css styled rules get applied
        itemView: BookView,

        initialize: function() {
            var self = this;
            //this.bindTo(this.collection, 'all', this.updateToggleCheckbox, this);
            _.bindAll(this, "showMessage", "loadMoreBooks");

            vent.on("search:error", function() {
                self.showMessage("Error, please retry later :s");
            });
            vent.on("search:noSearchTerm", function() {
                self.showMessage("Hummmm, can do better :)");
            });
            vent.on("search:noResults", function() {
                self.showMessage("No books found");
            });
        },

        // append our itemViews here...
        ui: {
            list: '.books'
        },

        events: {
            'scroll': 'loadMoreBooks'
        },

        appendHtml: function(collectionView, itemView) {
            this.ui.list.append(itemView.el);
        },

        showMessage: function(message) {
            this.ui.list.html('<h1 class="notFound">' + message + '</h1>');
        },

        loadMoreBooks: function() {
            var totalHeight = this.$('> div').height(),
                scrollTop = this.$el.scrollTop() + this.$el.height(),
                margin = 200;
            // if we are closer than 'margin' to the end of the content, load more books
            if (scrollTop + margin >= totalHeight) {
                vent.trigger("search:more");
            }
        }
    });

    BookList.showBooks = function(books) {
        var bookListView = new BookListView({
            collection: books
        });
        
        vent.trigger('show:books', bookListView); // handled in librarycontroller
    };

    return BookList;

});