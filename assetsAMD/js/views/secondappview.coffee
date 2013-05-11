# secondappview.js: Ted Killilea June 2012  twitter.com/t2k_nyc
define ["underscore", "marionette", "templates"], (_, Marionette, templates) ->
    class AppView extends Marionette.ItemView
        template: _.template(templates.secondapp) #"#close-template",
        className: "close"