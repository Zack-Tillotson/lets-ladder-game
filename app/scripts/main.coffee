requirejs [
  'assets/scripts/namespace.js'
  'react.js'  
  'assets/scripts/models/open_door_the_game.js'
  'assets/scripts/views/open_door_the_game.js'
  'assets/scripts/models/high_score_data.js'
], (zt, React, OpenDoorTheGame, OpenDoorTheGameView, HighScoreData) ->

  model = new zt.OpenDoorTheGame()
  high_score_data = new zt.HighScoreData()

  event_handler = (action, value) =>
    switch action
      when 'open_door' then model.actionOpenDoor(value)
      when 'reset_doors' then model.actionResetDoors()

  update_model_state = ->
    React.render(React.createElement(OpenDoorTheGameView, {
      model_state: model.getState(), 
      event_handler: event_handler,
      high_scores: high_score_data.getState()
    }), document.getElementById('game-container'))

  model.emitter.on 'state_change', =>
    update_model_state()

  high_score_data.emitter.on 'state_change', =>
    update_model_state()

  window.x = high_score_data

  update_model_state()