# show the other app
define ["backbone", "apps/other/show/controller", "msgbus"], (Backbone, Controller, msgBus) ->
    # private module/app router  capture the #seconapp route and call start method of our controller
    class Router extends Backbone.Marionette.AppRouter
        appRoutes:
            "otherapp": "start"

    # handle the other:route command during main application start/init process
    msgBus.commands.setHandler "other:route", ->
        new Router
            controller: API

    # controller API
    API =
        start: ->
            Controller.otherApp()