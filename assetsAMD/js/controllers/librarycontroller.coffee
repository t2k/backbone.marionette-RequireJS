# librarycontroller.js  Ted Killilea 5/31/12  twitter.com/t2k_nyc
define ["underscore", "marionette", "msgbus", "models/books", "views/booklist", "templates", "views/search"], (_, Marionette, msgbus, BooksCollection, Booklist, templates, SearchView) ->
  # public module API
    Controller = {}
  
    # private
    class Layout extends Marionette.Layout
        template: _.template(templates.librarylayout)
        regions:
            search: "#searchBar"
            books: "#bookContainer"
    
    # books collection model as private
    console.log "_books created"
    _books = new BooksCollection()
    
    # private
    _initializeLayout = ->
        console.log "initializeLayout..."
        Controller.layout = new Layout()
        
        Controller.layout.on "show", =>
            console log "layout library shown"
            #msgbus.events.trigger "layout:rendered"
            searchView = new SearchView()
            Controller.layout.search.attachView searchView


        msgbus.events.trigger "app:show", Controller.layout
    
    
    # controller attach a sub view/ search View
    msgbus.events.on "layout:rendered", ->
        console.log "layout:rendered =>librarycontroller"
        # render a view for the existing HTML in the template, and attach it to the layout (i.e. don't double render)
    
    
    # controller show books in the layout / subview
    msgbus.events.on "show:books", (bookListView) ->
        # console.log('show books event');
        Controller.layout.books.show bookListView
    
    # public API
    Controller.search = (term) ->
        _initializeLayout()
        Booklist.showBooks _books
        msgbus.events.trigger "search:term", term
    
    
    # public API
    Controller.defaultSearch = ->
        console.log "Controller.defaultSearch =>librarycontroller"
        Controller.search _books.previousSearch or "West Highland Terrier" # <3 my doggie!
    
    Controller
