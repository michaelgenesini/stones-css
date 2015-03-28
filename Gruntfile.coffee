module.exports = (grunt) ->
	grunt.initConfig

		jade:
			options:
				pretty: true
			compile:
				files: [
					cwd: "src/views",
					src: "*.jade",
					dest: "docs",
					expand: true,
					ext: ".html" ]

		sass:
			options:
				sourcemap: "none"
			app:
				files:
					['docs/assets/css/stones.css': 'src/sass/stones.sass','build/stones.css': 'src/sass/stones.sass']
				require: ['sass-json-vars']
				noCache: true
				debugInfo: true

		coffeelint:
			app:
				files:
					src: ['src/js/**/*.coffee']

		coffee:
			options:
				sourceMap: false
			app:
				files:
					'docs/assets/js/main.js': ['src/js/**/*.coffee']

		copy:
			main:
				files: [
					{
						expand: true
						cwd: 'src/imgs'
						src: '**/*'
						dest: 'docs/assets/imgs'
					},
					{
						expand: true
						cwd: 'src/fonts'
						src: '**/*'
						dest: 'docs/assets/fonts'
					}
				]

		watch:
			jade:
				files: ['src/views/**/*.jade']
				tasks: ['jade', 'notify:watch']

			coffee:
				files: ['src/js/**/*.coffee']
				tasks: ['coffeelint', 'coffee', 'notify:watch']

			sass:
				files: ['src/sass/**/*.sass']
				tasks: ['sass', 'notify:watch']

			imgs:
				files: ['src/imgs/*']
				tasks: ['copy', 'notify:watch']

			fonts:
				files: ['src/fonts/*']
				tasks: ['copy', 'notify:watch']

			build:
				files: ['docs/assets/stylesheets/stone.css', 'docs/*.html', 'docs/assets/javascript/**/*.js']
				options:
					livereload: true

		connect:
			server:
				options:
					port: 3333
					base: 'docs'

		open:
			dev:
				path: 'http://localhost:3333/'
				app: 'Google Chrome'

		notify_hooks:
			enabled: true

		notify:
			watch:
				options:
					title: 'Task complete'
					message: 'Build files successfully updated'

			server:
				options:
					title: 'Server started'
					message: 'Server started at http://localhost:3333'

	grunt.loadNpmTasks 'grunt-notify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-open'
	grunt.loadNpmTasks 'grunt-coffeelint'

	grunt.registerTask 'default', ['jade', 'sass', 'coffeelint', 'coffee', 'copy']
	grunt.registerTask 'server', ['default', 'connect', 'notify:server', 'open:dev', 'watch']