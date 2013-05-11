# secondapp.js
# note for brevity this controller also contains the definition of the router for this sub-app/module
define ["backbone", "views/secondappview", "msgbus"], (Backbone, AppView, msgBus) ->
    # private module/app router  capture the #seconapp route and call start method of our controller   
    Router: class Router extends Backbone.Marionette.AppRouter
        appRoutes:
            "secondapp": "start"
                
    # Start the app by showing the appropriate views    
    start: ->
        view = new AppView()
        msgBus.events.trigger "app:show", view
        Backbone.history.navigate('secondapp');