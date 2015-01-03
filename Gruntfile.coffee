module.exports = (grunt) ->
  require("load-grunt-tasks")(grunt)
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"
    coffeelint:
      options:
        configFile: "coffeelint.json"
      app: ["app/**/*.coffee"],
      server: ["server.coffee"]
    copy:
      index:
        files:
          "build/app/index.html": "app/index.html"
    less:
      app:
        files:
          "build/app/css/app.css": "app/less/app.less"

  grunt.registerTask "default", ["coffeelint", "less", "copy"]
