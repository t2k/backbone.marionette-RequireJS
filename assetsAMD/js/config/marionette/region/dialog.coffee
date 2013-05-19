#  ideas from Brian Mann's screencast: extend a custom region type to show and closeout twitter/bootstrap modals
define ["backbone","marionette"], (Backbone, Marionette) ->
    class Marionette.Region.Dialog extends Marionette.Region

        constructor: ->
            _.extend @, Backbone.Events

        onShow: (view) ->
            @setupBindings view
            options = @getDefaultOptions _.result(view, "dialog")
            #console.log options
            @$el.modal options,
                close: (e, ui) =>
                    @closeDialog()

        getDefaultOptions: (options = {}) ->
            _.defaults options,
                show: true
                keyboard: true

        setupBindings: (view) ->
            @listenTo view, "dialog:close", @closeDialog

        closeDialog: ->
            console.log "Marionette.Region.Dialog>> calling in the cleaner!"
            @$el.modal "hide"
            @stopListening()
            @close()