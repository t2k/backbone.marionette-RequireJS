#  good stuff: custom Dialog Region
define ["underscore", "backbone","marionette"], (_, Backbone, Marionette) ->

	class Marionette.Region.Dialog extends Marionette.Region

		constructor: ->
			_.extend @, Backbone.Events

		onShow: (view) ->
			@setupBindings view

			options = @getDefaultOptions _.result(view, "dialog")
			@$el.modal options,
				close: (e, ui) =>
					@closeDialog()

		getDefaultOptions: (options = {}) ->
			_.defaults options,
				show: true
				keyboard: true

		setupBindings: (view) ->
			@listenTo view, "dialog:close", @closeDialog
			@listenTo view, "dialog:resize", @resizeDialog
			@listenTo view, "dialog:title", @titleizeDialog

		closeDialog: ->
			@stopListening()
			@close()
			@$el.modal "hide"

		resizeDialog: ->
			@$el.modal "option",
				position: "center"

		titleizeDialog: (title) ->
			@$el.modal "option",
				title: title