# currency list controller
define ["apps/other/show/views", "msgbus"], (Views, msgBus) ->

    otherApp: ->
        view = new Views.Other
        msgBus.events.trigger "app:show", view