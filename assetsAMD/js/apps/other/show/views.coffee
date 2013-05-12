# views supporint the book list application:  FWIW all views inherit from views/_base
define ['apps/other/show/templates', 'views/_base', 'msgbus' ], (Templates, AppViews, msgBus) ->
    # other stuff goes here
    Other: class View extends AppViews.ItemView
        template: _.template(Templates.otherView)
        className: "close"
