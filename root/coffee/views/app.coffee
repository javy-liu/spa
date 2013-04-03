#页面的主体
define ['jquery','underscore','backbone','utils/logConfig','text!templates/app.html','css!root/css/bootstrap','bootstrap'],
($,_,Backbone,log,tplApp)->
	AppView = Backbone.View.extend
		el:$('body'),
		#className:'container-fluid',
		statsTemplate:_.template tplApp
		initialize:()->
			log.debug('appView初始化!')
			@hideLoading()
			@
		render:->
			@.$el.append @.statsTemplate {}
			
			@
		show:->

		hideLoading:->

			# fadeOut and remove loading
		     @.$("#loading").fadeOut ()->
		        $(@).remove()
		        $('body').removeAttr 'style'
	        log.debug '移除loading!'

	
	new AppView()
	