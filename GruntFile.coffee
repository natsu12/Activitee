module.exports = (grunt) ->
  grunt.initConfig
    clean:
      bin:
        dot: true
        files:
          src: ["bin/*"]

    copy:
      appCode:
        files: [
          src: ["**/*","!**/**.{ls,sass}"]
          dest: "bin/"
          cwd: "src/"
          expand: true
        ]

    livescript:
      options:
        bare: false
      all:
        expand: true
        cwd: "src/"
        src: ["**/**.ls"]
        dest: "bin/"
        ext: ".js"

    watch:
      options:
        livereload: false
      jade:
        files: ["src/views/**"]
        options:
          livereload: true
      livescript:
        files: ['src/**/*.ls']
        tasks: ["newer:livescript"]
        options:
          livereload: true
      appCode:
        files: ['src/**/*', "!src/**/**.{ls,sass}"]
        tasks: ["newer:copy:appCode"]

    nodemon:
      dev:
        script: 'bin/app.js'
        options:
          args: []
          nodeArgs: ['--debug']
          ignore: ['README.md', 'node_modules/**', '.DS_Store'],
          ext: 'js'
          watch: ['./']
          delay: 1000
          env:
            PORT: '3000'
          cwd: __dirname

    concurrent:
      tasks: ['clean','livescript','copy','nodemon', 'watch']
      options:
        logConcurrentOutput: true

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-nodemon'
  grunt.loadNpmTasks 'grunt-concurrent'

  grunt.option 'force', true
  grunt.registerTask 'default', ['concurrent']