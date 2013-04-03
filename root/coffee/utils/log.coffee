define [],()->
	Logger=(loggerName)-> 
		if not loggerName
			Logger.get "Log4Js"
		else Logger.get loggerName
	Logger.get=(loggerName)->
		if Logger.define[loggerName] 
		 	Logger.define[loggerName].name = loggerName 
				new Logger.main Logger.define[loggerName]
		else if loggerName is "Log4Js"
		    new Logger.main()
		else throw "Log4Js: No such logger with name " + loggerName
	Logger.main=(config)->
		_this = @
		tplArgs = 
			timestamp: "{TIMESTAMP}",
			loggername: "{LOGGERNAME}",
			loggerlevel: "{LOGGERLEVEL}",
			logtext:	"{TEXT}"
		defaultOutway=(prefix,msg,obj)->
			switch obj.level
				when "ERROR" then console.error prefix,msg
				when "WARNNING" then console.warn prefix,msg
				else console.log prefix,msg
			null
		config = config or {}
		_this.name = config.name or "Log4Js"
		_this.outputLevel = if config.level then config.level.toUpperCase() else "ALL"
		_this.outway = config.outway or defaultOutway
		_this.tpl = config.tpl or "{TIMESTAMP},{LOGGERLEVEL}[{LOGGERNAME}]:"
		_this.dateFormat = config.dateFormat or "yyyy-MM-dd hh:mm:ss"
		applyData=(data)->
			t = _this.tpl
			t = t.replace tplArgs.timestamp,data.timestamp
			t = t.replace tplArgs.loggername,data.name
			t = t.replace tplArgs.loggerlevel,data.level
			t = t.replace tplArgs.logtext,data.text
			t
		output=(logObj,msg)->
			out = _this.outway
			prefix = applyData logObj
			if logObj.level is "LOG" 
				out("",msg,logObj)
				return 
			switch _this.outputLevel
				when "ALL","DEBUG"
					out prefix,msg,logObj if logObj.level in ["DEBUG","INFO","WARNNING","ERROR","FATAL"]
				when "INFO"
					out prefix,msg,logObj if logObj.level in ["INFO","WARNNING","ERROR","FATAL"]
				when "WARNNING"
					out prefix,msg,logObj if logObj.level in ["WARNNING","ERROR","FATAL"]
				when "ERROR"
					out prefix,msg,logObj if logObj.level in ["ERROR","FATAL"]
				when "FATAL"
					out prefix,msg,logObj if logObj.level in ["FATAL"]
				else
			null
		getTimestamp=()->
			Logger.util.DateFormat new Date(),_this.dateFormat
		Logger.publicMethods=
			log:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "LOG"
				output logs,txt
			debug:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "DEBUG"
				output logs,txt
			info:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "INFO"
				output logs,txt
			error:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "ERROR"
				output logs,txt
			warn:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "WARNNING"
				output logs,txt
			fatal:(txt)->
				logs=
					timestamp: getTimestamp()
					name: _this.name
					level: "FATAL"
				output logs,txt
		Logger.publicMethods
	Logger.util={}
	Logger.util.getType=(t)->
		o=t
		(if (_t = typeof(o)) is "object" then o is null and "null" or Object::toString.call(o).slice(8,-1) else _t).toLowerCase()
	Logger.util.DateFormat=(date,format)->
		o = 
			"M+": date.getMonth() + 1
			"d+": date.getDate()
			"h+": date.getHours()
			"m+": date.getMinutes()
			"s+": date.getSeconds()
			"q+": Math.floor((date.getMonth() + 3) / 3)
			"S": date.getMilliseconds()
		if /(y+)/.test(format)
			format = format.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length))
		for k of o
			if new RegExp("(" + k + ")").test(format)
				format = format.replace(RegExp.$1, if RegExp.$1.length is 1 then o[k] else ("00" + o[k]).substr(("" + o[k]).length))
		format
	Logger

