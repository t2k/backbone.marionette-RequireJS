// librarycontroller.js  Ted Killilea 5/31/12  twitter.com/t2k_nyc
define(['underscoreM', 'marionette', 'vent', 'models/books', 'views/booklist', 'templates', 'views/search'], function(_, Marionette, vent, BooksModel, Booklist, templates, SearchView) {
    'use strict';
    
    // public module API
    var Controller = {};

    // private
    var Layout = Marionette.Layout.extend({
        template: _.template(templates.librarylayout),

        regions: {
            search: "#searchBar",
            books: "#bookContainer"
        }
    });

    // books collection model as private
    var _books = new BooksModel();

    // private
    var _initializeLayout = function() {
        console.log('initializeLayout...');
        Controller.layout = new Layout();
            Controller.layout.on("show", function() {
            vent.trigger("layout:rendered");
        });
        vent.trigger('app:show', Controller.layout);
    };

    // controller attach a sub view/ search View
    vent.on("layout:rendered", function() {
        console.log('layout:rendered =>librarycontroller'); 
        // render a view for the existing HTML in the template, and attach it to the layout (i.e. don't double render)
        var searchView = new SearchView();
        Controller.layout.search.attachView(searchView);
    });
    
    // controller show books in the layout / subview
    vent.on('show:books', function(bookListView) {
        // console.log('show books event');
        Controller.layout.books.show(bookListView);
    });


    // public API
    Controller.search = function(term) {
        _initializeLayout();
        Booklist.showBooks(_books);
        vent.trigger("search:term", term);
    };

    // public API
    Controller.defaultSearch = function() {
        console.log('Controller.defaultSearch =>librarycontroller');
        Controller.search(_books.previousSearch || 'West Highland Terrier');  // <3 my doggie!
    };

    return Controller;
});