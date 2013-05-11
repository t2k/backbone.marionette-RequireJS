# app/module
define ["marionette", "apps/book/list/controller", "msgbus", "entities/book"], (Marionette, Controller, msgBus ) ->

    msgBus.events.on "search:term", (searchTerm) ->
        Backbone.history.navigate "search/" + searchTerm

    defaultTerm = "West Highland Terrier"

    #the book list application uses this PRIVATE books custom collection class as defined in the entities/book module (required above)
    books = msgBus.reqres.request "book:entities"

    class Router extends Marionette.AppRouter
        appRoutes:
            "": "defaultSearch"
            "search/:searchTerm": "search"

    msgBus.events.on "list:book:clicked", (book) ->
        API.showBookDetail book

    msgBus.commands.setHandler "books:route", ->
        #console.log "starting books:route"
        new Router
            controller: API

    API =
        search: (searchTerm) ->
            #console.log "APP:BOOKlist>> API.search #{searchTerm}"
            Controller.listBooks books
            msgBus.events.trigger "search:term", searchTerm

        defaultSearch: ->
            #console.log "APP:Booklist>> API.defaultsearch"
            API.search books.previousSearch or defaultTerm

        showBookDetail: (book)->
            Controller.showBookDetail(book)



