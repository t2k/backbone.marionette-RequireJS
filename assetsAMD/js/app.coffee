# App.js: Ted Killilea June 2012  twitter.com/@t2k_nyc
define ["underscore", "backbone", "marionette", "msgbus", "bsModal"], (_, Backbone,  Marionette, msgBus) ->
    app = new Marionette.Application()
    app.defaultSearchTerm = "West Highland Terrier"

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
        #console.log "initialize: book:route"
        msgBus.commands.execute "books:route"

    # app modal inter app/module communications
    msgBus.events.on "app:show:modal", (view) =>
        app.modal.show view

    # show an app view: both library and 'secondapp' trigger this
    msgBus.events.on "app:show", (view) =>
        app.content.show view
        # export the app

    app