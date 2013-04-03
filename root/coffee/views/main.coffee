define ['jquery','underscore','backbone','text!templates/main.html','views/nav','views/content'],
($,_,Backbone,tplMain,navView,contentView)->
	MainView = Backbone.View.extend
		className:'row-fluid main',
		template:_.template(tplMain),
		initialize:->
			@nav = navView
			@content = contentView
			@render()
		render:->
			@$el.append @template {}
			$(@el).children(":eq(0)").append @nav.el
			$(@el).children(":eq(1)").append @content.el
			@
		show:->

	new MainView()