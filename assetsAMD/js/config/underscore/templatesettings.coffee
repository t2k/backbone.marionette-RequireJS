# config underscore templateSettings to expect mustache style {{ myVar }}
define ['underscore'], ( _ ) ->
    _.templateSettings =
        evaluate: /\{\[([\s\S]+?)\]\}/g
        interpolate: /\{\{(.+?)\}\}/g
