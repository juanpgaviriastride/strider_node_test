module.exports = (grunt) ->
  SRC_COMPILED = 'modules/webserver/frontend/compiled/'
  SRC_COFFEE = 'modules/webserver/frontend/coffee/'
  SRC_LESS = 'modules/webserver/frontend/less/'
  SRC_VENDOR = 'modules/webserver/frontend/vendor/'
  SRC_TEMPLATE = 'modules/webserver/frontend/templates/'
  SRC_PUBLIC = 'modules/webserver/public/'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    bump:
      options:
        files: ['package.json']
        updateConfigs: []
        commit: true
        commitMessage: 'Release v%VERSION%',
        commitFiles: ['package.json'] # '-a' for all files
        createTag: true
        tagName: 'v%VERSION%'
        tagMessage: 'Version %VERSION%'
        push: true
        pushTo: 'origin'
        gitDescribeOptions: '--tags --always --abbrev=1 --dirty=-d' # options to use with '$ git describe'


    exec:
      test:
        command: 'grunt mocha-test',
        stderr: true

      test_cov_json:
        # command: 'grunt mocha-test-cov-json > test/coverage/coverage.json',
        command: 'mkdir -p test/coverage;grunt mocha-test-cov-json',

      test_parse_cov_json:
        command: 'coffee test/utils/parse_coverage_json.coffee'

      test_cov_html:
        command: 'mkdir -p test/coverage;grunt mocha-test-cov-html',

      test_parse_cov_html:
        command: 'coffee test/utils/parse_coverage_html.coffee; open test/coverage/coverage.html'

    mochacli:
      test:
        spec:
          options:
            reporter: 'spec'

        options:
          files: ['test/index.coffee']
          "inline-diffs": true
          compilers: ['coffee:coffee-script/register']
          env:
            COVERAGE: 'false'
            NODE_PATH: 'modules'
            NODE_ENV: (if process.env.NODE_ENV?.match("integration") then 'integration' else 'test')


      test_cov_json:
        options:
          "inline-diffs": true
          files: ['test/index.coffee']
          save: 'test/coverage/coverage.json'
          compilers: ['coffee:coffee-script/register']
          require: ['test/utils/cov_init.coffee']
          reporter: 'json-cov'
          env:
            COVERAGE: 'true'
            NODE_PATH: 'modules'
            NODE_ENV: (if process.env.NODE_ENV?.match("integration") then 'integration' else 'test')

      test_cov_html:
        options:
          files: ['test/index.coffee']
          save: 'test/coverage/coverage.html'
          compilers: ['coffee:coffee-script/register']
          require: ['test/utils/cov_init.coffee']
          reporter: 'html-cov'
          env:
            COVERAGE: 'true'
            NODE_PATH: 'modules'
            NODE_ENV: (if process.env.NODE_ENV?.match("integration") then 'integration' else 'test')

    # CoffeeScript
    coffee:
      app:
        src:  [
          SRC_COFFEE + 'system/namespace.coffee'
          SRC_COFFEE + 'system/config.coffee'
          SRC_COFFEE + 'system/log.coffee'
          SRC_COFFEE + 'system/helper.coffee'
          SRC_COFFEE + 'system/image.coffee'
          SRC_COFFEE + 'system/routers/**/*.coffee'
          SRC_COFFEE + 'system/models/**/*.coffee'
          SRC_COFFEE + 'system/collections/**/*.coffee'
          SRC_COFFEE + 'system/views/**/*.coffee'
          SRC_COFFEE + 'app/namespace.coffee'
          SRC_COFFEE + 'app/config.coffee'
          SRC_COFFEE + 'app/routers/**/*.coffee'
          SRC_COFFEE + 'app/models/**/*.coffee'
          SRC_COFFEE + 'app/collections/**/*.coffee'
          SRC_COFFEE + 'app/views/**/*.coffee'
          SRC_COFFEE + 'app/app.coffee'
        ]
        dest: SRC_COMPILED + 'js/app.js'

      login:
        src:  [
          SRC_COFFEE + 'app/namespace.coffee'
          SRC_COFFEE + 'app/config.coffee'
          SRC_COFFEE + 'app/layout.coffee'
          SRC_COFFEE + 'app/login.coffee'
        ]
        dest: SRC_COMPILED + 'js/login.js'

    # Lodash templates
    jst:
      app:
        options:
          processName:  (filename) ->
              filename = filename.replace /frontend\/templates\//gi, ''
              filename.replace /modules\/webserver\//gi, ''
              #filename.replace(/frontend\/templates\//gi, '').replace /\.html/, ''

        src: SRC_TEMPLATE + '**/*.html'
        dest: SRC_COMPILED + 'js/jst.js'

    # LESS preprocessor for CSS
    less:
      options:
        paths: [
          SRC_VENDOR + 'less'
          SRC_LESS
        ]

      app:
        src: [
          SRC_LESS + 'base.less'
          SRC_LESS + 'app.less'
        ]
        dest: SRC_COMPILED + 'css/app.css'

      login:
        src: [
          SRC_LESS + 'base.less'
          SRC_LESS + 'login.less'
        ]
        dest: SRC_COMPILED + 'css/login.css'

      test_api:
        src: [
          SRC_LESS + 'base.less'
          SRC_LESS + 'test_api.less'
        ]
        dest: SRC_COMPILED + 'css/test_api.css'

    # Concatenated JS and CSS files
    concat:
      app_js:
        src: [
          SRC_VENDOR + 'js/modernizr.custom.js'
          SRC_VENDOR + 'js/jquery-1.11.1.min.js'
          SRC_VENDOR + 'js/jquery-ui-1.10.4.min.js'
          SRC_VENDOR + 'js/jquery.mmenu.min.js'
          SRC_VENDOR + 'js/jquery.cookies.2.2.0.min.js'
          SRC_VENDOR + 'js/jquery.qrcode-0.10.1.min.js'
          SRC_VENDOR + 'js/underscore-min.js'
          SRC_VENDOR + 'js/moment-with-locales.js'
          SRC_VENDOR + 'js/bootstrap.min.js'
          SRC_VENDOR + 'js/pnotify.custom.min.js'
          SRC_VENDOR + 'js/backbone-min.js'
          SRC_VENDOR + 'js/backbone.iobind.js'
          SRC_VENDOR + 'js/backbone_babysitter.js'
          SRC_VENDOR + 'js/backbone.wreqr.min.js'
          SRC_COMPILED + 'js/jst.js'
          SRC_VENDOR + "js/plugins/bootstrap-editable.min.js"
          SRC_VENDOR + "js/plugins/jquery.dataTables.min.js"
          SRC_VENDOR + "js/plugins/!(core|core.min|bootstrap-editable.min|css-filters-polyfill|jquery.dataTables.min).js"
          SRC_VENDOR + "js/plugins/core.js"
          '<%= coffee.app.dest %>'
        ]
        dest: SRC_PUBLIC + 'js/app.js'
      login_js:
        src:[
          SRC_VENDOR + 'js/modernizr.custom.js'
          SRC_VENDOR + 'js/jquery-1.11.1.min.js'
          SRC_VENDOR + 'js/jquery-ui-1.10.4.min.js'
          SRC_VENDOR + 'js/jquery.cookies.2.2.0.min.js'
          SRC_VENDOR + 'js/underscore-min.js'
          SRC_VENDOR + 'js/backbone-min.js'
          SRC_VENDOR + 'js/backbone.iobind.js'
          SRC_VENDOR + 'js/backbone_babysitter.js'
          SRC_VENDOR + 'js/backbone.wreqr.min.js'
          '<%= coffee.login.dest %>'
        ]
        dest: SRC_PUBLIC + 'js/login.js'

      app_css:
        src: [
          SRC_VENDOR + 'css/jquery-ui-1.10.4.min.css'
          SRC_VENDOR + 'css/pnotify.custom.min.css'
          SRC_VENDOR + 'css/bootstrap.min.css'
          SRC_VENDOR + 'css/bootstrap-responsive.css'
          SRC_VENDOR + 'css/plugins/**/*.css'
          '<%= less.app.dest %>'
        ]
        dest: SRC_PUBLIC + 'css/app.css'


      login_css:
        src: [
          SRC_VENDOR + 'css/bootstrap.min.css',
          SRC_VENDOR + 'css/plugins/font-awesome.css'
          SRC_VENDOR + 'css/plugins/style.css'
          '<%= less.login.dest %>'
        ]
        dest: SRC_PUBLIC + 'css/login.css'

      test_api_css:
        src: [
          SRC_VENDOR + 'css/bootstrap.min.css',
          '<%= less.test_api.dest %>'
        ]
        dest: SRC_PUBLIC + 'css/test_api.css'


    copy:
      main:
        files: [
          {
            expand: true
            cwd: SRC_VENDOR + 'images/'
            src: ['**']
            dest: SRC_PUBLIC + "images/"
          }
          {
            expand: true
            cwd: SRC_VENDOR + 'img/'
            src: ['**']
            dest: SRC_PUBLIC + "img/"
          }
          {
            expand: true
            cwd: SRC_VENDOR + 'fonts/'
            src: ['**']
            dest: SRC_PUBLIC + "fonts/"
          }
          {
            expand: true
            cwd: SRC_VENDOR + 'ico/'
            src: ['**']
            dest: SRC_PUBLIC + "ico/"
          }
          {
            expand: true
            cwd: SRC_VENDOR + 'js/plugins/flot/'
            src: ['**']
            dest: SRC_PUBLIC + "js/css-filters-polyfill/"
          }
          {
            expand: true
            cwd: SRC_VENDOR + "../"
            src: ['favicon.ico']
            dest: SRC_PUBLIC
          }
        ]


    # Watch for changes of files
    watch:
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['default']
        options:
          nocase: true

      app_js:
        files: [
          '<%= coffee.app.src %>'
          '<%= jst.app.src %>'
          SRC_VENDOR + 'js/**/*.js'
        ]
        tasks: [
          'coffee:app'
          'jst:app'
          'concat:app_js'
        ]

      app_css:
        files: [
          '<%= less.app.src %>'
          SRC_VENDOR + 'css/**/*.css'
          SRC_VENDOR + 'less/**/*.less'
        ]
        tasks: [
          'less:app'
          'concat:app_css'
        ]

      images:
        files: [
          SRC_VENDOR + 'img/**'
          SRC_VENDOR + 'images/**'
          SRC_VENDOR + 'ico/**'
          SRC_VENDOR + 'fonts/**'
        ]
        tasks: [
          'copy:main'
        ]

      login_js:
        files: [
          '<%= coffee.login.src %>'
        ]
        tasks: [
          'coffee:login'
          'concat:login_js'
        ]

      login_css:
        files: [
          '<%= less.login.src %>'
          SRC_VENDOR + 'css/**/*.css'
          SRC_VENDOR + 'less/**/*.less'
        ]
        tasks: [
          'less:login'
          'concat:login_css'
        ]

      test_api_css:
        files: [
          '<%= less.test_api.src %>'
          SRC_VENDOR + 'css/**/*.css'
          SRC_VENDOR + 'less/**/*.less'
        ]
        tasks: [
          'less:test_api'
          'concat:test_api_css'
        ]

      scripts:
        files: [
          SRC_COFFEE + 'system/**/*.coffee'
          SRC_VENDOR + 'js/**/*.js'
        ]
        tasks: [
          'coffee'
          'jst:app'
          'concat:app_js'
          'concat:login_js'
        ]

      styles:
        files: [
          SRC_LESS + 'base.less'
          SRC_VENDOR + 'css/**/*.css'
          SRC_VENDOR + 'less/**/*.less'
        ]
        tasks: [
          'less'
          'concat:app_css'
          'concat:login_css'
          'concat:test_api_css'
        ]

    # Uglify, compress js files
    uglify:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */'
      app:
        src: '<%= concat.app_js.dest %>'
        dest: SRC_PUBLIC + 'js/app.min.js'
      login:
        src: '<%= concat.login_js.dest %>'
        dest: SRC_PUBLIC + 'js/login.min.js'

    # CSSMIN, compress css files
    cssmin:
      options:
        banner: '/*! <%= pkg.name %> - v<%= pkg.version %> - <%= grunt.template.today("yyyy-mm-dd") %> */'
      app:
        src: '<%= concat.app_css.dest %>'
        dest: SRC_PUBLIC + 'css/app.min.css'
      login:
        src: '<%= concat.login_css.dest %>'
        dest: SRC_PUBLIC + 'css/login.min.css'



  # Listen for events when files are modified
  grunt.event.on 'watch', (action, filepath) ->
    grunt.log.writeln filepath + ' has ' + action

  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jst'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-less'

  grunt.loadNpmTasks 'grunt-mocha-cli'
  grunt.loadNpmTasks 'grunt-exec'

  grunt.loadNpmTasks 'grunt-bump'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'default', ['coffee', 'jst', 'less', 'concat', 'copy']
  grunt.registerTask 'production', ['coffee', 'jst', 'less', 'concat', "cssmin", 'uglify']

  grunt.registerTask 'test', ['exec:test']
  grunt.registerTask 'test-cov-json', ['exec:test_cov_json', 'exec:test_parse_cov_json']
  grunt.registerTask 'test-cov-html', ['exec:test_cov_html', 'exec:test_parse_cov_html']

  grunt.registerTask 'mocha-test', ['mochacli:test']
  grunt.registerTask 'mocha-test-cov-json', ['mochacli:test_cov_json']
  grunt.registerTask 'mocha-test-cov-html', ['mochacli:test_cov_html']
