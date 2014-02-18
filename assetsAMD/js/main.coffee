# main.coffee requireJS bootloader file typically included in the index.html
require.config
    baseURL: 'assetsAMD/js',

    paths:
        jquery: "../../bower_components/jquery/jquery" # amd version
        underscore: "../../bower_components/underscore/underscore" # amd version
        backbone: "../../bower_components/backbone/backbone" # amd version
        "backbone.wreqr": "../../bower_components/backbone.wreqr/lib/amd/backbone.wreqr" # amd version
        "backbone.babysitter": "../../bower_components/backbone.babysitter/lib/amd/backbone.babysitter" # amd version
        marionette: "../../bower_components/marionette/lib/core/amd/backbone.marionette" # amd version
        bsModal: "../../bower_components/bootstrap/js/modal"
        text: "../../bower_components/requirejs-text/text"

    shim:
        bsModal: ["jquery"]

    # start the main APP but let require also load any pre-app config and teh book and other apps
    require ["config/_base", "app",  "apps/book/app", "apps/other/app" ], (_config, App) ->
        App.start()