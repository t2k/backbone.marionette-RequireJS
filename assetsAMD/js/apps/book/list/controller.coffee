# currency list controller
define ["msgbus","apps/book/list/views"], (msgBus, Views) ->

    listBooks: (books) ->
        @layout = @getLayout()
        @layout.on "show", =>
            @showSearchBar()
            @showBookList books
        msgBus.events.trigger "app:show", @layout

    showBookDetail: (book) ->
        console.log "controller>> showBookDetail"
        view = @getDetailView book
        view.on "dialog:button:clicked", ->
            console.log "editView instance dialog:button:clicked"
        msgBus.events.trigger "app:show:modal", view

    getDetailView: (book) ->
        new Views.BookDetailView
            model: book

    showBookList: (items) ->
        bookListView = @getBookListView items
        @layout.books.show bookListView

    getBookListView: (items) ->
        new Views.BookList
            collection: items

    showSearchBar: ->
        searchView = @getSearchView()
        @layout.search.attachView searchView

    getSearchView: ->
        new Views.Search

    getLayout: ->
        new Views.Layout