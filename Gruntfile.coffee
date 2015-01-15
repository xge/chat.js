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
          join: true
        files:
          'build/app/js/app.js': ['app/**/*.coffee']
    concat:
      lib:
        src: [
          'bower_components/angular/angular.js',
          'bower_components/angular-route/angular-route.js',
          'bower_components/angular-socket-io/socket.js'
          'bower_components/moment/moment.js'
        ],
        dest: 'build/app/js/lib.js'
    copy:
      index:
        files:
          'build/app/index.html': 'app/index.html'
    html2js:
      options:
        base: 'app/'
        module: 'chat.tpl'
      app:
        src: ['app/**/*.tpl.html']
        dest: 'build/app/js/tpl.js'
    less:
      app:
        files:
          'build/app/css/app.css': 'app/less/app.less'
    watch:
      assets:
        files: ['app/less/app.less', 'app/**/*.tpl.html', 'app/index.html']
        tasks: ['assets']
      coffee:
        files: ['app/**/*.coffee']
        tasks: ['coffeescript']

  grunt.registerTask 'coffeescript', ['coffeelint', 'coffee']
  grunt.registerTask 'assets', ['less', 'html2js', 'concat', 'copy']
  grunt.registerTask 'default', ['coffeescript', 'assets']
