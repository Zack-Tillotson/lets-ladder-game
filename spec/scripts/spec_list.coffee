requirejs.config

    paths:
        jquery: 'https://code.jquery.com/jquery-2.1.3.min'
        'jasmine': '/lib/jasmine-2.2.0/jasmine'
        'jasmine-html': '/lib/jasmine-2.2.0/jasmine-html'
        'jasmine-boot': '/lib/jasmine-2.2.0/boot'
        spec: 'lib/jasmine/spec/'

    shim:
        'jasmine-html':
            deps: ['jasmine']
        'jasmine-boot':
            deps: ['jasmine-html']


requirejs ['jquery', 'jasmine', 'jasmine-html', 'jasmine-boot'], ($, jasmineLib, jasmineHtml, jasmineBoot) ->

    specs = [
      '/spec/scripts/models/score_state_spec.js'
      '/spec/scripts/models/door_spec.js'
      '/spec/scripts/models/distribution_spec.js'
      '/spec/scripts/models/game_state_spec.js'
    ]

    $ ->
        requirejs specs, (spec) ->
            jasmine.getEnv().execute()
