module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      build:
        files:
          "progress_reader.js": "progress_reader.js.coffee",
          "progress_reader_spec.js": "progress_reader_spec.js.coffee"

    jasmine:
      test:
        src: 'progress_reader.js',
        options:
          specs: 'progress_reader_spec.js'
          vendor:
            "node_modules/jquery/dist/jquery.js"

    clean: ["progress_reader_spec.js"]

    watch:
      files: ["progress_reader.js.coffee", "progress_reader_spec.js.coffee"],
      tasks: ["coffee:build", "clean"]
      #tasks: ["coffee:build","jasmine", "clean"]

  grunt.loadNpmTasks("grunt-contrib-coffee")
  grunt.loadNpmTasks('grunt-contrib-jasmine')
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-watch');

  grunt.registerTask("default", ["watch"])
