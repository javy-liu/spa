#全局定义
define ['jquery','underscore','backbone','router','modernizr','namespace'],
($,_,Backbone,appRouter,Modernizr,global)->
		initialize=->
			global.app=
				router:appRouter
			Backbone.history.start()
		initialize:initialize
