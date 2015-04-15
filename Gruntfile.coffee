# Grunt Configuration
# http://gruntjs.com/getting-started#an-example-gruntfile

module.exports = (grunt) ->

	# Initiate the Grunt configuration.
	grunt.initConfig

		# Allow use of the package.json data.
		pkg: grunt.file.readJSON('package.json')

		# docpad variables
		docpad:
			files: [ './src/**/*.*' ]
			out: ['out']

		# copy vendor files [destination:source]
		copy:
			main:
				files: [
					'out/vendor/normalize.css':'bower_components/normalize.css/normalize.css'
					'out/vendor/modernizr.js':'bower_components/modernizr/modernizr.js'
					#'out/vendor/jquery.scrollTo/jquery.scrollTo.min.js':'bower_components/jquery.scrollTo/jquery.scrollTo.min.js'
					#'out/vendor/jquery.localScroll/jquery.localScroll.min.js':'bower_components/jquery.localScroll/jquery.localScroll.min.js'
				]

		# add vendor prefixes
		autoprefixer:
			options:
				browsers: [
					'last 4 versions'
				]
			default:
				options:
					map: false
				src: 'out/css/template.css'

		#minify css
		cssmin:
			combine:
				files:
					'out/css/output.min.css':[
						'out/vendor/normalize.css'
						'out/css/template.css'
					]

		#minify js
		uglify:
			out:
				files:
					'out/js/output.min.js':[
						'out/vendor/modernizr-custom.js'
						'out/js/init.js'
					]

		#minify html
		htmlmin:
			out:
				options:
					removeComments: true
					collapseWhitespace: true
					minifyJS: true
					minifyCSS: true
				files: [
					expand: true
					cwd: 'out/'
					src: [
						'*.html'
						'!google*.html'
						'!yandex*.html'
					]
					dest: 'out/'
				]

		# optimize images if possible
		imagemin:
			out:
				options:
					optimizationLevel: 2,
				files: [
					expand: true,
					cwd: 'out/img/',
					src: ['**/*.{png,jpg,gif,svg}'],
					dest: 'out/img/'
				]
			src:
				options:
					optimizationLevel: 2,
				files: [
					expand: true,
					cwd: 'src/files/img/',
					src: ['**/*.{png,jpg,jpeg,gif,svg}'],
					dest: 'src/files/img/'
				]

		#clean files
		clean:
			less:
				'out/css/*.less'

		#generates custom modernizr build from site css
		modernizr:
			dist:
				# [REQUIRED] Path to the build you're using for development.
				devFile: "bower_components/modernizr/modernizr.js"

				# Path to save out the built file.
				outputFile: "out/vendor/modernizr-custom.js"

				# Based on default settings on http://modernizr.com/download/
				extra:
					shiv: true
					printshiv: false
					load: true
					mq: true
					cssclasses: true

				# Based on default settings on http://modernizr.com/download/
				extensibility:
					addtest: false
					prefixed: false
					teststyles: false
					testprops: false
					testallprops: false
					hasevents: false
					prefixes: false
					domprefixes: false
					cssclassprefix: ""

				# By default, source is uglified before saving
				uglify: true

				# Define any tests you want to implicitly include.
				tests: []

				# By default, this task will crawl your project for references to Modernizr tests.
				# Set to false to disable.
				parseFiles: true

				# When parseFiles = true, this task will crawl all *.js, *.css, *.scss and *.sass files,
				# except files that are in node_modules/.
				# You can override this by defining a "files" array below.
				files:
					src: [
						'src/documents/**/*.less'
						'src/documents/**/*.css'
						'src/documents/**/*.js'
					]

				# This handler will be passed an array of all the test names passed to the Modernizr API, and will run after the API call has returned
				# handler: function (tests) {},

				# When parseFiles = true, matchCommunityTests = true will attempt to
				# match user-contributed tests.
				matchCommunityTests: true

				# Have custom Modernizr tests? Add paths to their location here.
				customTests: []

		'ftp-deploy':
			build:
				auth:
					host: ''
					port: 21
					authPath: '.ftppass'
					authKey: 'primary'
				src: 'out/'
				dest: '/www/'
				exclusions: [
					'out/**/.DS_Store'
					'out/**/Thumbs.db'
				]

	# Build the available Grunt tasks.
	grunt.loadNpmTasks 'grunt-autoprefixer'
	grunt.loadNpmTasks 'grunt-contrib-cssmin'
	grunt.loadNpmTasks 'grunt-contrib-jshint'
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-htmlmin'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-modernizr'
	grunt.loadNpmTasks 'grunt-ftp-deploy'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-newer'
	grunt.loadNpmTasks 'grunt-contrib-imagemin'

	# Register our Grunt tasks.
	# grunt.registerTask 'deploy',        ['ftp-deploy']
	grunt.registerTask 'imageoptim',    ['newer:imagemin:src']
	grunt.registerTask 'production',    ['default', 'cssmin', 'htmlmin', 'modernizr', 'uglify', 'imagemin:out', 'clean']
	grunt.registerTask 'default',       ['copy', 'autoprefixer']
