# views supporing the book list application:  FWIW all views inherit from views/_base
define ['backbone', 'apps/book/list/templates', 'views/_base', 'msgbus' ], (Backbone, Templates, AppView, msgBus) ->
    # bookview
    BookView: class BookView extends AppView.ItemView
        template: _.template(Templates.book)
        events:
            "click" : -> msgBus.events.trigger "list:book:clicked", @model

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
                msgBus.events.trigger "search:more"


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
            msgBus.events.on "search:start", =>
                $spinner.fadeIn()
            msgBus.events.on "search:stop", =>
                $spinner.fadeOut()
            msgBus.events.on "search:term", (term) =>
                @.$("#searchTerm").val(term)

        search: ->
            searchTerm = @.$("#searchTerm").val().trim()
            console.log "searchTerm change vent handled from SearchView: #{searchTerm}"
            if searchTerm.length > 0
                msgBus.events.trigger "search:term", searchTerm
            else
                msgBus.events.trigger "search:noSearchTerm"

    # the modal view
    BookDetailView: class BookDetailView extends AppView.ItemView
        template: _.template(Templates.bookdetail)
        className: "modal bookDetail"

        # not used in this app
        modelEvents:
            "change:name" : -> console.log "name changed"

        events:
            "click #close-dialog" : ->
                console.log "book/list/BookDetailView >> close click"
                @trigger "dialog:close"  #this event is handled by the Mariionette.Region.Dialog extension class >> see config

        # not really used here, ideas from Brian Mann's screencast, passed into the Region.Dialog
		dialog:
			title: "Edit Event"
			className: "dialogClass"
			buttons: false

		onClose: ->
			console.log "book/list/BookDetailView >> onClose"

		onDialogButtonClicked: ->
			console.log "dialog method onDialogButtonClicked"