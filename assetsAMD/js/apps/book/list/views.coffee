# views supporint the book list application:  FWIW all views inherit from views/_base
define ['underscore', 'backbone', 'apps/book/list/templates', 'views/_base', 'msgbus' ], (_, Backbone, Templates, AppView, msgbus) ->
    # bookview
    BookView: class BookView extends AppView.ItemView
        template: _.template(Templates.book)
        events:
            "click" : -> msgbus.events.trigger "list:book:clicked", @model

    BookList: class BookList extends AppView.CompositeView
        template: _.template(Templates.books)
        id: "bookList"
        itemView: BookView

        itemViewContainer: "div.books"

        events:
            scroll: "loadmorebooks"

        loadmorebooks:->
            totalHeight = @.$("> div").height()
            scrollTop = @.$el.scrollTop() + @.$el.height()
            margin = 200
            if ((scrollTop + margin) >= totalHeight)
                #console.log "BOOKLIST: >>search"
                msgbus.events.trigger "search:more"


    Layout: class Layout extends AppView.Layout
        template: _.template(Templates.layout)
        regions:
            search: "#searchBar"
            books: "#bookContainer"


    Search: class SearchView extends AppView.ItemView
        el: "#searchBar"

        events:
            "change #searchTerm": "search"

        initialize: ->
            $spinner = @.$("#spinner")
            msgbus.events.on "search:start", =>
                $spinner.fadeIn()
            msgbus.events.on "search:stop", =>
                $spinner.fadeOut()
            msgbus.events.on "search:term", (term) =>
                @.$("#searchTerm").val(term)

        search: ->
            searchTerm = @.$("#searchTerm").val().trim()
            console.log "searchTerm change vent handled from SearchView: #{searchTerm}"
            if searchTerm.length > 0
                msgbus.events.trigger "search:term", searchTerm
            else
                msgbus.events.trigger "search:noSearchTerm"

    BookDetailView: class BookDetailView extends AppView.ItemView
        template: _.template(Templates.bookdetail)
        className: "modal bookDetail"
        modelEvents:
            "change:name" : -> console.log "name changed"

		events:
			"click #close-dialog" : -> @trigger "dialog:close"

		dialog:
			title: "Edit Event"
			className: "dialogClass"
			buttons: false

		onClose: ->
			console.log "view closing"

		onDialogButtonClicked: ->
			console.log "dialog method onDialogButtonClicked"