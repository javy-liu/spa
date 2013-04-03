define ['jquery','underscore','backbone','text!templates/nav.html'],
($,_,Backbone,tplNav)->
	NavView = Backbone.View.extend
		tagName:'div',
		className:'sidebar-nav app-nav-sidebar',
		template:_.template(tplNav),
		initialize:->
			
			@render()
		render:->
			@$el.append @template {}
			@
		show:->

	new NavView()