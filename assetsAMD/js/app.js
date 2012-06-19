// App.js: Ted Killilea June 2012  twitter.com/@t2k_nyc
define(['require', 'bootstrapModal', 'underscore', 'backbone', 'marionette'], function (require) {
    'use strict';
    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');


    var app = new Backbone.Marionette.Application();

    var ModalRegion = Backbone.Marionette.Region.extend({
        el: "#modal",
        constructor: function () {
            _.bindAll(this);
            Backbone.Marionette.Region.prototype.constructor.apply(this, arguments);
            this.on("view:show", this.showModal, this);
        },
        getEl: function (selector) {
            var $el = $(selector);
            $el.on("hidden", this.close);
            return $el;
        },
        showModal: function (view) {
            view.on("close", this.hideModal, this);
            this.$el.modal('show');
        },
        hideModal: function () {
            this.$el.modal('hide');
        }
    });

    app.addRegions({
        content: "#content",
        menu: "#menu",
        modal: ModalRegion
    });

    app.vent.on("layout:rendered", function () {
        console.log('layout was rendered');
        //var menu = new MyApp.MenuView();
        //app.menu.attachView(menu);
    });

    app.vent.on("routing:started", function () {
        console.log('routing has been started!');
        if (!Backbone.History.started) {
            console.log('Yes indeed, routing has been started!');
            Backbone.history.start();
        }
    });

    app.vent.on("search:term", function (searchTerm) {
        Backbone.history.navigate("search/" + searchTerm);
    });

    app.on('start', function () {
        console.log('start!');
    });

    app.on('initialize:before', function () {
        console.log('init:before');
    });

    app.on('initialize:after', function () {
        console.log('init:after');
    });

/*
    app.addInitializer(function () {
        Backbone.Marionette.TemplateCache.loadTemplate = function (templateId, callback) {
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
            template = this.compileTemplate(template);
            callback.call(this, template);
        };
    });

*/

    // export the app from this module
    return app;


});