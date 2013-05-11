# config underscore templates to use mustache override default global templates to use mustache formated styles {{ xx }}
define ['underscore'], ( _ ) ->
    do->
        #console.log "config: underscore templateSettings {{ mustache }}"
        _.templateSettings =
            evaluate: /\{\[([\s\S]+?)\]\}/g
            interpolate: /\{\{(.+?)\}\}/g
