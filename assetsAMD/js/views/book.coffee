# book.js: Ted Killilea June 2012  @t2k_nyc
#  the book item view: when clicked display the modal detailview
#  let the app handle this
define ["underscore", "marionette", "templates", "views/bookdetail", "msgbus"], (_, Marionette, templates, BookDetailView, msgbus) ->

    class View extends Marionette.ItemView
        template: _.template(templates.book)
        events:
            click: "showBookDetail"

        showBookDetail: ->
            detailView = @getDetailView
            msgbus.events.trigger "app.show.modal", detailView
        getDetailView: ->
            new BookDetailView
                model: @model
