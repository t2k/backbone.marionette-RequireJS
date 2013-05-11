# booklist.js
define ["underscore", "marionette", "templates", "views/book", "msgbus"], (_, Marionette, templates, BookView, msgbus) ->
    
    # private module level var
    class BookListView extends Marionette.CompositeView
        template: _.template(templates.booklist) #"#book-list-template",
        id: "bookList" # ! css styled rules get applied
        itemViewContainer: "div.books"
        itemView: BookView
        initialize: ->
            self = this
      
            #this.bindTo(this.collection, 'all', this.updateToggleCheckbox, this);
            _.bindAll this, "showMessage", "loadMoreBooks"
            msgbus.events.on "search:error", ->
                self.showMessage "Error, please retry later :s"
    
            msgbus.events.on "search:noSearchTerm", ->
                self.showMessage "Hummmm, can do better :)"
    
            msgbus.events.on "search:noResults", ->
                self.showMessage "No books found"

        # append our itemViews here...
        ui:
          list: ".books"
        
        events:
          scroll: "loadMoreBooks"
        
        appendHtml: (collectionView, itemView) ->
          @ui.list.append itemView.el
        
        showMessage: (message) ->
          @ui.list.html "<h1 class=\"notFound\">" + message + "</h1>"
        
        loadMoreBooks: ->
          totalHeight = @$("> div").height()
          scrollTop = @$el.scrollTop() + @$el.height()
          margin = 200
          
          # if we are closer than 'margin' to the end of the content, load more books
          msgbus.events.trigger "search:more"  if scrollTop + margin >= totalHeight
    
    showBooks: showBooks = (books) ->
        bookListView = new BookListView
            collection: books
        msgbus.events.trigger "show:books", bookListView # handled in librarycontroller
