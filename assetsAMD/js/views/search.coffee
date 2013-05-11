# search.js: Ted Killilea June 2012  @t2k_nyc
# view depends upon app and backbone
# search view
define ["backbone", "marionette", "msgbus"], (Backbone, Marionette, msgbus) ->
    class SearchView extends Marionette.ItemView
        el: "#searchBar"
        initialize: ->
            $spinner = @.$("#spinner")
            msgbus.events.on "search:start", ->
                $spinner.fadeIn()
        
            msgbus.events.on "search:stop", ->
                $spinner.fadeOut()
        
            msgbus.events.on "search:term", (term) =>
                @.$("#searchTerm").val term
        
        events:
            "change #searchTerm": "search"
        
        search: ->
            searchTerm = @.$("#searchTerm").val().trim()
            if searchTerm.length > 0
                msgbus.events.trigger "search:term", searchTerm
            else
                msgbus.events.trigger "search:noSearchTerm"

    msgbus.events.on "search:term", (searchTerm) ->
        Backbone.history.navigate "search/" + searchTerm