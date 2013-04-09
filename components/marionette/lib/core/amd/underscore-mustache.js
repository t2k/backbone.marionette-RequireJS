define(['underscore'],
function(_) {
    // override default global templates to use MUSTACHE style {{ name }} instead of ERB
    _.templateSettings = {
        evaluate: /\{\[([\s\S]+?)\]\}/g,
        interpolate: /\{\{(.+?)\}\}/g
    };
    return _;
});