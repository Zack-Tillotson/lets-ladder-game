requirejs.config

    paths:
      libs: '../../libs/'
      jquery: 'https://code.jquery.com/jquery-2.1.4.min'
      eventemitter2: 'libs/eventemitter2'
      underscore: 'https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min'
      react: 'https://cdnjs.cloudflare.com/ajax/libs/react/0.13.2/react.min'
      firebase: 'https://cdn.firebase.com/js/client/2.2.4/firebase'
      moment: 'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min'

requirejs ['open_game'], (OpenGame) ->
  new zt.OpenGame container: document.getElementById('game-container')