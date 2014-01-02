module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    less:
      all:
        options:
          yuicompress: true
          compress: true
          cleancss: true
        files:
          'dist/style.css': 'less/style.less'

    uglify:
      all:
        files:
          "dist/all.min.js": "js/index.js"

    htmlmin:
      all:
        options:
          removeComments: true,
          collapseWhitespace: true
        files:
          "dist/index.html": "index.html"

    copy:
      all:
        files: [{expand: true, src: ['img/*'], dest: 'dist/', filter: 'isFile'},
                {expand: true, src: ['font/*'], dest: 'dist/', filter: 'isFile'}]

    clean:
      res: ["dist/font", "dist/img"]

    connect:
      all:
        options:
          port: 8000,
          base: 'dist/'

    watch:
      less:
        files: ['less/*.less']
        tasks: ['less:all']
      concat:
        files: ['js/index.js']
        tasks: ['uglify:all']
      htmlmin:
        files: ['index.html']
        tasks: ['htmlmin:all']
      copy:
        files: ['font/*', 'img/*']
        tasks: ['clean:res', 'copy:all']

  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-htmlmin'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  grunt.registerTask 'default', ['less', 'uglify', 'htmlmin', 'copy', 'connect', 'watch']
