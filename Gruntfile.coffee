module.exports = (grunt) ->
	grunt.initConfig
		coffee:
			compile: 
				files: {'public/javascripts/app.js': ['angular/coffee/app.coffee', 'angular/coffee/shared/*.coffee', 'angular/coffee/controllers/*.coffee', 'angular/coffee/directives/*.coffee']}

		nodemon:
			dev:
				script: 'app.coffee'
				options:
					ignore: ['node_modules/**', 'public/**'],

		concurrent:
			target:
				tasks: [
					'nodemon'
					'watch'
				]
				options:
					logConcurrentOutput: true

		watch:
			coffeescript:
				files: ['angular/coffee/**/*.coffee']
				tasks: ['coffee']

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-concurrent'
	grunt.loadNpmTasks 'grunt-nodemon'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', 'Runs the nodemon and watch of the coffee files', ['concurrent']

