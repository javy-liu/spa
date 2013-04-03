#页面header部分
define ['jquery','underscore','backbone','text!templates/header.html'],
($,_,Backbone,tplHeader)->
	HeaderView = Backbone.View.extend
		className:'navbar-inner',
		template:_.template(tplHeader),
		initialize:->
			
			@render()
		render:->
			@$el.append @template {}
			@
		show:->

	new HeaderView()