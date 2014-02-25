"use strict"

module.exports = (grunt) ->

  # load all grunt tasks
  require('load-grunt-tasks')(grunt)

  require('time-grunt')(grunt)


  grunt.initConfig(

    browserify:
      dist:
        files:
          '.tmp/scripts/app.js': 'app/scripts/app.coffee'
        options:
          transform: ['coffeeify']

    watch:
      scripts:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          "app/scripts/**/*"
        ]
        tasks: ["browserify"]
      compass:
        files: ['app/styles/*.{scss,sass}'],
        tasks: ['compass:server']
      livereload:
        options:
          livereload: '<%= connect.options.livereload %>'
        files: [
          "build/styles/{,*/}*.css",
        ]

    clean:
      dist:
        files: [
          dot: true
          src: [".tmp", "dist/*"]
        ]

      server: ".tmp"

    compass:
      options:
        sassDir: 'app/styles',
        cssDir: '.tmp/styles',
        importPath: 'bower_components',
        relativeAssets: false,
        assetCacheBuster: false
      server:
        options:
          debugInfo: true

    cssmin:
      dist:
        files:
          'dist/styles/app.css': ['.tmp/styles/app.css']

    uglify:
      dist:
        files:
          'dist/scripts/app.js': ['.tmp/scripts/app.js']

    connect:
      options:
        port: 9000
        hostname: "localhost"
        livereload: 35729

      livereload:
        options:
          open: true
          base: ['.tmp', 'app', 'bower_components']

      dist:
        options:
          base: ['dist']

    copy:
      fonts:
        expand: true
        cwd: 'bower_components/font-awesome/fonts/'
        src: '**'
        dest: '.tmp/fonts'
      dist:
        files: [
            src: 'app/index.html'
            dest: 'dist/index.html'
          ,
            expand: true
            cwd: '.tmp/fonts'
            src: '**'
            dest: 'dist/fonts/'
        ]

    buildcontrol:
      options:
        dir: 'dist',
        commit: true,
        push: true,
        message: 'Built %sourceName% from commit %sourceCommit% on branch %sourceBranch%'
      pages:
        options:
          remote: 'git@github.com:keboola/travis-wallboard.git'
          branch: 'gh-pages'

  )

  grunt.registerTask "serve", (target) ->

    if target == 'dist'
      return grunt.task.run ['build', 'connect:dist:keepalive']

    grunt.task.run([
      "clean"
      "copy:fonts"
      "browserify"
      "compass:server"
      "connect:livereload"
      "watch"
    ])

  grunt.registerTask "build", [
    "clean"
    "browserify"
    "compass:server"
    "cssmin"
    "uglify"
    "copy"
  ]

  grunt.registerTask "publish", [
    "buildcontrol:pages"
  ]

  grunt.registerTask "default", "build"
