module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    coffeelint:
      options:
        configFile: 'coffeelint.json'
      app: ['app/**/*.coffee'],
      server: ['lib/**/*.coffee']
    coffee:
      app:
        options:
          compress: true
          join: true
          sourceMap: true
        files:
          'build/app/js/app.js': ['app/**/*.coffee']
    concat:
      dev:
        src: [
          'bower_components/angular/angular.js'
          'bower_components/angular-route/angular-route.js'
          'bower_components/angular-socket-io/socket.js'
        ],
        dest: 'build/app/js/lib.js'
      prod:
        src: [
          'bower_components/angular/angular.min.js'
          'bower_components/angular-route/angular-route.min.js'
          'bower_components/angular-socket-io/socket.min.js'
        ],
        dest: 'build/app/js/lib.min.js'
    copy:
      index:
        files:
          'build/app/index.html': 'app/index.html'
    html2js:
      options:
        base: 'app/'
        module: 'chat.tpl'
        useStrict: true
      app:
        src: ['app/**/*.tpl.html']
        dest: 'build/app/js/tpl.js'
    less:
      app:
        files:
          'build/app/css/app.css': 'app/less/app.less'
    uglify:
      app:
        files:
          'build/app/js/app.min.js': ['build/app/js/app.js', 'build/app/js/tpl.js']
    watch:
      assets:
        files: ['app/less/app.less', 'app/**/*.tpl.html', 'app/index.html']
        tasks: ['assets']
      coffee:
        files: ['app/**/*.coffee']
        tasks: ['coffeescript']

  grunt.registerTask 'coffeescript', ['coffeelint', 'coffee']
  grunt.registerTask 'assets', ['less', 'html2js', 'concat:prod', 'copy']
  grunt.registerTask 'default', ['coffeescript', 'assets', 'uglify']
