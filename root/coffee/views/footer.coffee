define ['jquery','underscore','backbone','text!templates/footer.html'],
($,_,Backbone,tplFooter)->
	FooterView = Backbone.View.extend
		tagName:'footer',
		template:_.template(tplFooter),
		initialize:->
		
			@render()
		render:->
			@$el.append @template {}
			@
		show:->

	new FooterView()