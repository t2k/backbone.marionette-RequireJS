# APP: Ted Killilea May/13  twitter.com/@t2k_nyc
define ["backbone", "marionette", "msgbus", "bsModal"], (Backbone,  Marionette, msgBus) ->
    app = new Marionette.Application()
    #app.defaultSearchTerm = "West Highland Terrier"

    # these regions correspond to #ID in the index.html
    app.addRegions
        content: "#content"
        menu: "#menu"
        modal: Marionette.Region.Dialog.extend el: "#modal"

    # marionette app events...
    app.on "initialize:after", ->
        Backbone.history.start() unless Backbone.history.started

    # pass in router/controller via options
    app.addInitializer ->
        msgBus.commands.execute "books:route"
        msgBus.commands.execute "other:route"

    # app modal inter app/module communications
    msgBus.events.on "app:show:modal", (view) =>
        app.modal.show view

    # show an app view: both library and 'secondapp' trigger this
    msgBus.events.on "app:show", (view) =>
        app.content.show view
        # export the app

    app