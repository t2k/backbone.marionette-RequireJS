// App.js: Ted Killilea June 2012  twitter.com/@t2k_nyc
define(['jquery', 'underscoreM', 'backbone', 'marionette', 'vent', 'bootstrap'], function($, _, Backbone, Marionette, vent) {
    'use strict';

    var app = new Marionette.Application();


    //modalregion: shows a book detail view in bootstrap modal
    var ModalRegion = Marionette.Region.extend({
        el: "#modal",
        constructor: function() {
            var self = this;
            //_.bindAll(this);
            // Marionette.Region.prototype.constructor.apply(this, arguments);
            self.on("view:show", this.showModal, this);
        },
        showModal: function(view) {
            view.on("close", this.hideModal, this);
            this.$el.modal('show'); // bootstrap modal
        },
        hideModal: function() {
            this.$el.modal('hide'); // bootstrap modal
        }
    });

    // these regions correspond to #ID's in the index.html 
    app.addRegions({
        content: "#content",
        menu: "#menu",
        modal: ModalRegion
    });

    // marionette app events...
    app.on("initialize:after", function() {
        console.log('initialize:after');
        Backbone.history.start();
    });

    // app modal inter app/module communications
    vent.on('app.show.modal', function(view) {
        console.log('app.show.bookdetail =>app');
        app.modal.show(view);
    });

    // show an app view: both library and 'secondapp' trigger this
    vent.on('app:show', function(appView) {
        app.content.show(appView);
    });
    
    

    app.addInitializer(function(options) {
        // configure for loading templates stored externally...
        Backbone.Marionette.TemplateCache.prototype.loadTemplate = function(templateId) {
            // Marionette expects "templateId" to be the ID of a DOM element.
            // But with RequireJS, templateId is actually the full text of the template.
            var template = templateId;

            // Make sure we have a template before trying to compile it
            if (!template || template.length === 0) {
                var msg = "Could not find template: '" + templateId + "'";
                var err = new Error(msg);
                err.name = "NoTemplateError";
                throw err;
            }

            return template;
        };


        // init library routes and controller methods   
        new options.libraryRouter.Router({
            controller: options.libraryController // controller implements search and defaultsearch
        });
        
        // init secondApp's routes and controller methods
        new options.secondApp.Router({
            controller: options.secondApp // wire-up the start method
        });
    });

    // export the app
    return app;
});