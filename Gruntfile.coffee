# Generated on 2014-07-24 using generator-reveal 0.3.4
module.exports = (grunt) ->

    grunt.initConfig

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/*.md'
                    'slides/*.html'
                    'js/*.js'
                ]

            index:
                files: [
                    'templates/_index.html'
                    'templates/_section.html'
                    'slides/list.json'
                ]
                tasks: ['buildIndex']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']

        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

        coffeelint:

            options:
                indentation:
                    value: 4

            # all: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:

            dist:
                files: [{
                    expand: true
                    src: [
                        'bower_components/reveal.js/lib/css/zenburn.css',
                        'bower_components/reveal.js/css/theme/default.css',
                        'bower_components/reveal.js/css/reveal.min.css',
                        'bower_components/reveal.js/css/print/pdf.css',

                        'bower_components/jquery/jquery.js',
                        'bower_components/handlebars/handlebars.js',
                        'bower_components/reveal.js/lib/js/head.min.js',
                        'bower_components/reveal.js/js/reveal.min.js',

                        'bower_components/reveal.js/lib/js/classList.js',
                        'bower_components/reveal.js/plugin/markdown/marked.js',
                        'bower_components/reveal.js/plugin/markdown/markdown.js',
                        'bower_components/reveal.js/plugin/highlight/highlight.js',
                        'bower_components/reveal.js/plugin/zoom-js/zoom.js',
                        'bower_components/reveal.js/plugin/notes/notes.js',

                        'bower_components/reveal.js/lib/font/*',
                        'slides/**'
                        'js/**'
                        'css/**'
                        'images/**'
                    ]
                    dest: 'dist/'
                },{
                    expand: true
                    src: ['index.html']
                    dest: 'dist/'
                    filter: 'isFile'
                }]


    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'buildIndex',
        'Build index.html from templates/_index.html and slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            sectionTemplate = grunt.file.read 'templates/_section.html'
            slides = grunt.file.readJSON 'slides/list.json'

            html = grunt.template.process indexTemplate, data:
                slides:
                    slides
                section: (slide) ->
                    grunt.template.process sectionTemplate, data:
                        slide:
                            slide
            grunt.file.write 'index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
            'jshint'
        ]

    grunt.registerTask 'server',
        'Run presentation locally and start watch process (living document).', [
            'buildIndex'
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'test'
            'buildIndex'
            'copy'
        ]

    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'server'
    ]
