# LS currency app/module
define ["msgbus", "marionette", "apps/book/list/controller"], (msgBus, Marionette, Controller) ->

    class Router extends Marionette.AppRouter
		appRoutes:
            "": "defaultSearch"
            "search/:searchTerm": "search"
	API =
		listCurrencies: ->
			Controller.listCurrencies() #console.log "listCurrencies route has triggered"

	msgBus.commands.setHandler "ccys:route", ->
		new Router
			controller: API