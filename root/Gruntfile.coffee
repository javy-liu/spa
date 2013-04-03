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
			"build/css/bootstrap.css" : "#{LIBS_PATH}/bootstrap/default/less/bootstrap.less"
			"build/css/font-awesome.css":"#{LIBS_PATH}/font-awesome/default/less/font-awesome.less"
			"build/css/font-awesome-ie7.min.css":"#{LIBS_PATH}/font-awesome/default/less/font-awesome-ie7.less"				

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
			jquery:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/jquery"
					src: "jquery.js"
					dest: "#{LIBS_PATH}/jquery/default"
				]
			underscore:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/underscore"
					src: "underscore.js"
					dest: "#{LIBS_PATH}/underscore/default"
				]
			backbone:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/backbone"
					src: "backbone.js"
					dest: "#{LIBS_PATH}/backbone/default"
				]

			font_awesome:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/font-awesome"
					src: [
						"font/**"
						"less/**"
					]
					dest: "#{LIBS_PATH}/font-awesome/default"
				]
			font:
				files:[
					expand: true
					cwd: "#{LIBS_PATH}/font-awesome/default"
					src: "font/**"
					dest: "#{BUILD_PATH}"
				]
			bootstrap_js:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/bootstrap/docs/assets"
					src: [
						"js/**"
					]
					dest: "#{LIBS_PATH}/bootstrap/default"
				]
		
			bootstrap_less:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/bootstrap"
					src: [
						"less/**"
						"img/**"
					]
					dest: "#{LIBS_PATH}/bootstrap/default"
				]
			img:
				files:[
					expand: true
					cwd: "#{LIBS_PATH}/bootstrap/default"
					src: [
						"img/**"
					]
					dest: "#{BUILD_PATH}"
				]
			animate:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/animate"
					src: "**/*.css"
					dest: "#{LIBS_PATH}/animate/default"
				]
			modernizr:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/modernizr/dist"
					src: "modernizr-build.js"
					dest: "#{LIBS_PATH}/modernizr/default"
				]
			normalize:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/normalize"
					src: "normalize.css"
					dest: "#{LIBS_PATH}/normalize/default"
				]
			requirejs:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/requirejs"
					src: "require.js"
					dest: "#{LIBS_PATH}/requirejs/default"
				]
			requirejs_plugins:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/requirejs-plugins"
					src: [
						"**/cs.js"
						"**/css.js"
						"**/domReady.js"
						"**/i18n.js"
						"**/text.js"
					]
					dest: "#{LIBS_PATH}/requirejs/plugins"
				]
			social:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/social"
					src: "assets/**"
					dest: "#{LIBS_PATH}/social/default"
				]
			sidr:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/sidr/dist"
					src: "**"
					dest: "#{LIBS_PATH}/sidr/default"
				]
			fractionslider:
				files:[
					expand: true
					cwd: "#{ASSETS_LIBS}/fractionslider"
					src: [
						"jquery.fractionslider.js"
						"css/**"
					]
					dest: "#{LIBS_PATH}/fractionslider/default"
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
				src: [
					app_paths.coffee_src
				]
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

		concat: 
			options:
			    stripBanners: true
			    banner: '<%= grunt.banner %>'

			dist:
				src: [ "#{LIBS_PATH}/modernizr/default/modernizr-build.js"]
				dest: "#{LIBS_PATH}/modernizr/default/modernizr.js"	
			bootstrap:
				src: [ "#{LIBS_PATH}/bootstrap/default/js/bootstrap.js"]
				dest: "#{LIBS_PATH}/bootstrap/default/bootstrap.js"
				
		      			


				
		      
		  

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
		'copy:*'
		'concat'
		'coffee'
		'less'
	]
