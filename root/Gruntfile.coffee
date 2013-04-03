###
 * grunt-init-spa
 * https://gruntjs.com/
 *
 * Copyright (c) 2013 excalibur "刘真源", contributors
 * Licensed under the MIT license.
###
'use strict'
module.exports = (grunt)->

	# Constants
	BUILD_PATH = "build"
	APP_PATH = "app"
	DIST_PATH = "dist"
	DEV_PATH = "#{ DIST_PATH }/development"
	REL_PATH = "#{ DIST_PATH }/release"
	JS_DEV_PATH = "#{ BUILD_PATH }/js"
	CSS_DEV_PATH = "#{ BUILD_PATH }/css"
	TEST_PATH = "test"
	LIBS_PATH = "#{BUILD_PATH}/libs"
	ASSETS_PATH = "assets"
	ASSETS_LIBS = "#{ASSETS_PATH}/libs"

	# paths setup - separate as some modules dont process templates correctly
	app_paths = 

		# coffeescript sources
		coffee_dir: 'coffee'
		coffee_src: '**/*.coffee'
		coffee_dest: "#{ JS_DEV_PATH }"

		# less sources
		less_dir: 'less'
		less_src: 'css/**/*.less'
		less_file: 
			"build/css/bootstrap.css" : "#{LIBS_PATH}/bootstrap/2.3.1/less/bootstrap.less"
			"build/css/font-awesome.css":"#{LIBS_PATH}/font-awesome/3.0.2/less/font-awesome.less"
			"build/css/font-awesome-ie7.min.css":"#{LIBS_PATH}/font-awesome/3.0.2/less/font-awesome-ie7.less"				

		# -- compiled output --

		# javascript sources
		js_dir: "#{BUILD_PATH}/js"
		js_src: "#{BUILD_PATH}/js/**/*.js"
		js_specs: "#{TEST_PATH}/js/**/*.js"

		# css sources
		css_dir: 'build/css'
		css_src: 'build/css/**/*.css'

		# minified target name
		minified: 'build/acorn.player.min.js'

		# qunit test page to render
		test_page: "#{TEST_PATH}/name.html"

		# libraries
		lib:['']

	# init project configuration
	grunt.initConfig
		# Metadata
		pkg:grunt.file.readJSON '{%= jqueryjson %}'
		banner:"/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - 
      			<%= grunt.template.today('yyyy-mm-dd') %>\n
      			<%= pkg.homepage ? '* ' + pkg.homepage + '\\n' : '' %>
      			* Copyright (c) <%= grunt.template.today('yyyy') %> <%= pkg.author.name %>;
      			Licensed <%= _.pluck(pkg.licenses, 'type').join(', ') %> */\n"

		# clean Task
		clean:
			files:[DIST_PATH]

		# copy Task
		copy:
			awesome:
				files:[
					expand: true
					cwd: 'build/libs/font-awesome/3.0.2/'
					src: "font/**"
					dest: 'build/'
				]
			bootstrap:
				files:[
					expand: true
					cwd: 'build/libs/bootstrap/2.3.1/'
					src: "img/**"
					dest: 'build/'
				]
					
					

		# uglify Task
		uglify:
			options:
				banner: '<%= banner %>'
			dist:
		        src: '<%= concat.dist.dest %>'
		        dest: 'dist/<%= pkg.name %>.min.js'

		# coffeescript Task
		coffee:
			development: 
				options:
					bare: true
				expand: true		       
				cwd: app_paths.coffee_dir
				src: [app_paths.coffee_src]
				dest: app_paths.coffee_dest
				ext: '.js'

		# less Task
		less:
			base:				
				files: app_paths.less_file
			development:
				expand: true
				cwd: app_paths.less_dir
				src: [app_paths.less_src]
				dest: BUILD_PATH
				ext: '.css'

		# watch Task
		watch:
			default:
				files: [
					app_paths.coffee_src
					"less/**/*"
				]
				tasks: [
					"coffee"
					"less"
					]
			coffee: 
				files: [
					app_paths.coffee_src
				]
				tasks: [
					"coffee"
				]
				
			less: 
				files: [
					"less/**/*"
				]
				tasks: [
					"less"
				]
			dev:''
			dist:''
		# connect Task
		connect:
			base:
				options:
					port:9000
					base:'./build'
					keepalive:true
			test:
				options:
					port:9001
					base:'./test'


				
		      
		  

	# These plugins provide necessary tasks
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-qunit'
	grunt.loadNpmTasks 'grunt-contrib-jshint'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-less'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-htmlmin'
	grunt.loadNpmTasks 'grunt-contrib-handlebars'

	# register default Task
	grunt.registerTask 'default', [
		'clean'
		'copy'
		'coffee'
		'less'
	]
