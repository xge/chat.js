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
      dev:
        src: [
          'bower_components/angular/angular.js'
          'bower_components/angular-route/angular-route.js'
          'bower_components/angular-sanitize/angular-sanitize.js'
          'bower_components/ng-emoticons/ng-emoticons.js'
          'bower_components/angular-socket-io/socket.js'
        ],
        dest: 'build/app/js/lib.js'
      prod:
        src: [
          'bower_components/angular/angular.min.js'
          'bower_components/angular-route/angular-route.min.js'
          'bower_components/angular-sanitize/angular-sanitize.min.js'
          'bower_components/ng-emoticons/dist/ng-emoticons.min.js'
          'bower_components/angular-socket-io/socket.min.js'
        ],
        dest: 'build/app/js/lib.min.js'
    copy:
      fonts:
        files: [{
            expand: true
            flatten: true
            src: ['bower_components/ng-emoticons/fonts/*']
            dest: 'build/app/fonts/'
            filter: 'isFile'
        }]
      index:
        files:
          'build/app/index.html': 'app/index.html'
      jquery:
        files: [{
            expand: true
            flatten: true
            src: ['bower_components/jquery/dist/*']
            dest: 'build/app/js/'
            filter: 'isFile'
        }]
    html2js:
      options:
        base: 'app/'
        module: 'chat.tpl'
        useStrict: true
      app:
        src: ['app/**/*.tpl.html']
        dest: 'build/app/js/tpl.js'
    karma:
      unit:
        configFile: 'karma.conf.js'
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

  grunt.registerTask 'assets', ['less', 'html2js', 'concat', 'copy']
  grunt.registerTask 'coffeescript', ['coffeelint', 'coffee']
  grunt.registerTask 'default', ['coffeescript', 'assets']
  grunt.registerTask 'test', ['default', 'karma']
