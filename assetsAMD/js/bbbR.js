// backBone Boilerplase Require stuff
define(function (require) {
    'use strict';

    // require stuff
    var $ = require('jquery'),
        _ = require('underscore'),
        Backbone = require('backbone'),
        Marionette = require('marionette');

    var _privateData = 'hello world';


    var publicModule = {
        msg: _privateData
    };

    return publicModule;
});

// usage var x = require('bbbR');
// assert(x.msg === 'hello world');