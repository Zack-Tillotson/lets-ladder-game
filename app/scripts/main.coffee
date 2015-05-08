requirejs [
  'zt', 'react', 'open_door_the_game', 'open_door_the_game_view', 'high_score_data'
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