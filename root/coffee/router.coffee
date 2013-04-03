define ['jquery','underscore','backbone','utils/logConfig'],
($,_,Backbone,log)->
	AppRouter = Backbone.Router.extend
		initialize:->
			log.debug 'initialize router!'
		routes:
			'':'show'
			'aa':'aa'

		show:()->
			log.debug '初始化appView!'
			require ['views/app'],(appView)->
				appView.render()
		aa:()->
			log.debug '初始化aa!'
		
	new AppRouter()
