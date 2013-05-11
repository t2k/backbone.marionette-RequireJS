# LibraryRouter.js  hookup the default "" and search routes for the library
define ["marionette"], (Marionette) ->
    class router extends Marionette.AppRouter
        appRoutes:
            "": "defaultSearch"
            "search/:searchTerm": "search"