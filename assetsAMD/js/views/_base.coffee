# override marionette views for any of our application specific needs
define ["marionette"], (Marionette) ->
    ItemView: class AppItemView extends Marionette.ItemView
    CollectionView: class AppCollectionView extends Marionette.CollectionView
    CompositeView: class AppCompositeView extends Marionette.CompositeView
    Layout: class AppLayout extends Marionette.Layout