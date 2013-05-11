# app/module
define ["msgbus", "backbone", "marionette", "apps/book/list/controller"], (msgBus, Backbone, Marionette, Controller) ->

    msgBus.commands.setHandler "books:route", ->
        console.log "starting books:route"
        new Router
            controller: API

    @defaultTerm = "West Highland Terrier"

    class Router extends Marionette.AppRouter
        appRoutes:
            "": "defaultSearch"
            "search/:searchTerm": "search"

    API =
        search: (searchTerm) ->
            console.log "route: API.search #{searchTerm}"
            Controller.listBooks searchTerm

        defaultSearch: ->
            console.log "route: API.defaultsearch"
            Controller.listBooks @defaultTerm