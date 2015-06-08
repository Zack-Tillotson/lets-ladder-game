requirejs.config

    paths:
        jquery: 'https://code.jquery.com/jquery-2.1.3.min'
        'jasmine': '/libs/jasmine-2.2.0/jasmine'
        'jasmine-html': '/libs/jasmine-2.2.0/jasmine-html'
        'jasmine-boot': '/libs/jasmine-2.2.0/boot'
        libs: '../../libs/'
        jquery: 'https://code.jquery.com/jquery-2.1.4.min'
        eventemitter2: 'libs/eventemitter2'
        underscore: 'https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min'
        react: 'https://cdnjs.cloudflare.com/ajax/libs/react/0.13.2/react.min'
        firebase: 'https://cdn.firebase.com/js/client/2.2.4/firebase'
        moment: 'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min'
        jquerycookie: 'https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min'
    shim:
        'jasmine-html':
            deps: ['jasmine']
        'jasmine-boot':
            deps: ['jasmine-html']
    baseUrl: './assets/scripts'

requirejs ['jquery', 'jasmine', 'jasmine-html', 'jasmine-boot'], ($, jasmineLib, jasmineHtml, jasmineBoot) ->

    specs = [
      '/spec/scripts/models/score_state_spec.js'
      '/spec/scripts/models/distribution_spec.js'
      '/spec/scripts/models/door_spec.js'
      '/spec/scripts/models/door_list_spec.js'
    ]

    $ ->
        requirejs specs, (spec) ->
            jasmine.getEnv().execute()
