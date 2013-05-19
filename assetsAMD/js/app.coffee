# APP: Ted Killilea May/13  twitter.com/@t2k_nyc
define ["backbone", "marionette", "msgbus", "underscore", "bsModal"], (Backbone,  Marionette, msgBus, _) ->
    app = new Marionette.Application()

    app.addRegions
        content: "#content"
        menu: "#menu"
        modal: Marionette.Region.Dialog.extend el: "#modal"

    # marionette app events...
    app.on "initialize:after", ->
        Backbone.history.start() unless Backbone.history.started

    app.addInitializer ->
        msgBus.commands.execute "books:route"
        msgBus.commands.execute "other:route"

    # message bus
    msgBus.events.on "app:show:modal", (view) =>
        app.modal.show view

    msgBus.events.on "app:show", (view) =>
        app.content.show view
        # export the app

    app