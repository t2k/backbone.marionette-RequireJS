# main.coffee requireJS bootloader file typically included in the index.html
require.config
    baseURL: 'assetsAMD/js',

    paths:
        jquery: "../../components/jquery/jquery" # amd version
        underscore: "../../components/underscore-amd/underscore" # amd version
        backbone: "../../components/backbone-amd/backbone" # amd version
        "backbone.wreqr": "../../components/backbone.wreqr/lib/amd/backbone.wreqr" # amd version
        "backbone.eventbinder": "../../components/backbone.eventbinder/lib/amd/backbone.eventbinder" # amd version
        "backbone.babysitter": "../../components/backbone.babysitter/lib/amd/backbone.babysitter" # amd version
        marionette: "../../components/marionette/lib/core/amd/backbone.marionette" # amd version
        bsModal: "../../components/bootstrap/docs/assets/js/bootstrap-modal"
        text: "../../components/requirejs-text/text"

    shim:
        bsModal: ["jquery"]

    # start the main APP but let require also load any pre-app config and teh book and other apps
    require ["config/_base", "app",  "apps/book/app", "apps/other/app" ], (_config, App) ->
        App.start()