# main.coffee requireJS bootloader file typically included in the index.html
require.config
    #baseURL: 'assetsAMD/js',
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

    # load the 'non AMD' versions of backbone, underscore and Marionette
    shim:
        bsModal: ["jquery"]

    require ["app", "apps/book/app", "config/_base"], (App) ->
        App.start()