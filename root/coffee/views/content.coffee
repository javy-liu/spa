define ['jquery','underscore','backbone','text!templates/content.html'],
($,_,Backbone,tplContent)->
	ContentView = Backbone.View.extend
		tagName:'div',
		className:'row-fluid',
		template:_.template(tplContent),
		initialize:->
			
			@render()
		render:->
			@$el.append @template {}
			@
		show:->

	new ContentView()