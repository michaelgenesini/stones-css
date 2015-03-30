module.exports = (grunt) ->

	appConfig =
		src:	'src',
		dist:	'dist',
		docs:	'docs'

	grunt.initConfig

		config : appConfig

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
					['<%= config.docs %>/assets/css/stones.css': '<%= config.src %>/sass/stones.sass','<%= config.dist %>/css/stones.css': '<%= config.src %>/sass/stones.sass']
				# Maybe unnecessary
				require: ['sass-json-vars']
				noCache: true
				debugInfo: true

		coffeelint:
			app:
				files:
					src: ['<%= config.src %>/coffee/**/*.coffee']

		coffee:
			options:
				sourceMap: false
			app:
				files:
					['<%= config.docs %>/assets/js/stones.js': '<%= config.src %>/coffee/**/*.coffee','<%= config.dist %>/js/stones.js': '<%= config.src %>/coffee/**/*.coffee']

		copy:
			main:
				files: [
					{
						expand: true
						cwd: '<%= config.src %>/imgs'
						src: '**/*'
						dest: '<%= config.dist %>/imgs'
					},
					{
						expand: true
						cwd: '<%= config.src %>/imgs'
						src: '**/*'
						dest: '<%= config.docs %>/assets/imgs'
					},
					{
						expand: true
						cwd: '<%= config.src %>/fonts'
						src: '**/*'
						dest: '<%= config.dist %>/fonts'
					},
					{
						expand: true
						cwd: '<%= config.src %>/fonts'
						src: '**/*'
						dest: '<%= config.docs %>/assets/fonts'
					}
				]

		watch:
			jade:
				files: ['<%= config.src %>/views/**/*.jade']
				tasks: ['jade', 'notify:watch']

			coffee:
				files: ['<%= config.src %>/coffee/**/*.coffee']
				tasks: ['coffeelint', 'coffee', 'notify:watch']

			sass:
				files: ['<%= config.src %>/sass/**/*.sass']
				tasks: ['sass', 'notify:watch']

			imgs:
				files: ['<%= config.src %>/imgs/*']
				tasks: ['copy', 'notify:watch']

			fonts:
				files: ['<%= config.src %>/fonts/*']
				tasks: ['copy', 'notify:watch']

			build:
				files: ['<%= config.docs %>/assets/css/stone.css', '<%= config.docs %>/*.html', '<%= config.docs %>/assets/js/stones.js']
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