# bookdetail.js: Ted Killilea June 2012  @t2k_nyc
# templates/bookdetail.htm
define ["underscore", "marionette", "templates"], (_, Marionette, templates) ->
    "use strict"
    class view extends Marionette.ItemView
        template: _.template(templates.bookdetail)
        className: "modal bookDetail"