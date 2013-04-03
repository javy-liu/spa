define ['utils/log'],(Logger)->
	Logger.define =
		'faith-log':
			level: "all"
			dateFormat: "yyyy-MM-dd hh:mm:ss"
			tpl: "{TIMESTAMP},{LOGGERLEVEL}[{LOGGERNAME}]:"			
	Logger.get "faith-log"	