requirejs.config

    paths:
      libs: '../../libs/'
      jquery: 'https://code.jquery.com/jquery-2.1.4.min'
      eventemitter2: 'libs/eventemitter2'
      underscore: 'https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min'
      react: 'https://cdnjs.cloudflare.com/ajax/libs/react/0.13.2/react.min'
      firebase: 'https://cdn.firebase.com/js/client/2.2.4/firebase'
      moment: 'https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.2/moment.min'

requirejs [
  'namespace', 'react', 'models/open_door_the_game', 'views/open_door_the_game', 'models/high_score_data'
], (zt, React, OpenDoorTheGame, OpenDoorTheGameView, HighScoreData) ->

  model = new zt.OpenDoorTheGame()
  high_score_data = new zt.HighScoreData()
  state =
    help_is_open: false
    high_scores_is_open: false

  event_handler = (action, value) =>
    switch action
      when 'open_door' then model.actionOpenDoor(value)
      when 'reset_doors' then model.actionResetDoors()
      when 'toggle'
        state[value] = !state[value]
        update_model_state()

  update_model_state = ->
    React.render(React.createElement(OpenDoorTheGameView, {
      model_state: model.getState() 
      event_handler: event_handler      
      help_is_open: state.help_is_open
      high_scores: high_score_data.getState()
      high_scores_is_open: state.high_scores_is_open
    }), document.getElementById('game-container'))

  model.emitter.on 'state_change', =>
    update_model_state()

  model.emitter.on 'game_over', (game_data) ->
    state['high_scores_is_open'] = true
    high_score_data.saveGameInformation game_data

  high_score_data.emitter.on 'state_change', =>
    update_model_state()

  update_model_state()