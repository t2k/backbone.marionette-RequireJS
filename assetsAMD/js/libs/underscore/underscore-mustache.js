define(['underscore'],
	function ( _ ) {
        // override default global templates to use MUSTACHE!
	    _.templateSettings = {
	        evaluate: /\{\[([\s\S]+?)\]\}/g,
	        interpolate: /\{\{(.+?)\}\}/g
	    };
	    return _;
	}
);