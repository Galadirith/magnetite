module.exports = (grunt) ->
  grunt.initConfig

    # compile coffeescripts
    coffee:
      compile:
        expand:   true,
        cwd:      'src',
        flatten:  false,
        src:      '*.coffee',
        dest:     'lib',
        ext:      '.js',

    # watch for file changes
    watch:
      # recompile coffeescripts
      coffee:
        files:  '<%= coffee.compile.src %>',
        tasks:  ['coffee'],
        options:
          cwd:  '<%= coffee.compile.cwd %>'

  # load plugins
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # register tasks
  grunt.registerTask 'default', ['coffee']
