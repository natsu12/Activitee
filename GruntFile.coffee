module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)
  path = require('path')
  pkg = grunt.file.readJSON("package.json")

  DEBUG = false # 添加测试所需代码，发布时应该为false

  grunt.initConfig 
    pkg: pkg
    meta:
      banner: "/**\n" + " * <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today(\"yyyy-mm-dd\") %>\n" + " * <%= pkg.homepage %>\n" + " *\n" + " * Copyright (c) <%= grunt.template.today(\"yyyy\") %> <%= pkg.author %>\n" + " * Licensed <%= pkg.licenses.type %> <<%= pkg.licenses.url %>>\n" + " */\n"

    changelog:
      options:
        dest: "CHANGELOG.md"
        template: "changelog.tpl"

    bump:
      options:
        files: ["package.json", "bower.json"]
        commit: true
        commitMessage: "chore(release): v%VERSION%"
        commitFiles: ["-a"]
        createTag: true
        tagName: "v%VERSION%"
        tagMessage: "Version %VERSION%"
        push: true
        pushTo: "origin"

    clean: 
      bin:
        dot: true
        files:
          src: [
            "bin/*"
            ".temp"
          ]

    copy:
      appCode:
        files: [
          src: ["**/*.*", "!**/**.{ls,less}"]
          dest: "bin/"
          cwd: "src/"
          expand: true
        ]

    livescript:
      options:
        bare: false
      all:
        expand: true
        # flatten: true
        cwd: "src/"
        src: ['**/**.ls']
        dest: "bin/"
        ext: ".js"

    less:
      development:
        files: [
          src: ["**/*.less"]
          dest: "bin/"
          cwd: "src/"
          expand: true
          ext: ".css"
        ]

    nodemon:
      dev:
        script: 'bin/server.js'
        options:
          args: []
          ignore: ['README.md', 'node_modules/**', '.DS_Store']
          ext: ['js']
          watch: ['./']
          delay: 500
          env:
            PORT: 5000
          cwd: __dirname

    delta:
      options:
        livereload: true

      livescript:
        files: ["src/**/*.ls"]
        tasks: ["newer:livescript"]

      less:
        files: ["src/**/*.less"]
        tasks: ["newer:less"]

      appCode:
        files: ["src/**/*.*", "!src/**/**.{ls,less}"]
        tasks: ["newer:copy:appCode"]

      grunt:
        files: ['Gruntfile.coffee']
    
    concurrent:
      tasks: ['nodemon', 'delta']
      options:
        logConcurrentOutput: true

 
  grunt.renameTask "watch", "delta"

  grunt.registerTask "watch", [
    "clean"
    "build"
    "concurrent"
  ]

  grunt.registerTask "default", [
    "build"
  ]

  grunt.registerTask "build", [
    "livescript"
    "less"
    "copy"
  ]

