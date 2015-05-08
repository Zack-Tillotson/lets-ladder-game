define [
  'namespace', 'react', 'models/game_state', 'views/game_state', 'models/high_score_data'
], (zt, React, GameState, GameStateView, HighScoreData) ->

  class zt.OpenGame

    constructor: (options) ->

      @container = options?.container or document.body
      @model = new zt.GameState()
      @high_score_data = new zt.HighScoreData()
      @state =
        help_is_open: false
        high_scores_is_open: false
        game_over_is_open: false

      window.x = @

      # Event triggers 
      @model.emitter.on 'state_change', =>
        @update_model_state()

      @model.emitter.on 'game_over', (game_data) =>
        @state['game_over_is_open'] = true
        @high_score_data.saveGameInformation game_data

      @high_score_data.emitter.on 'state_change', =>
        @update_model_state()

      # And draw once to start us off
      @update_model_state()

    event_handler: (action, value) =>
      switch action
        when 'open_door' then @model.actionOpenDoor(value)
        when 'reset_doors' then @model.actionResetDoors()
        when 'toggle'
          @state[key] = false for key, value in @state when key isnt value # Ensure all other views are closed
          @state[value] = !@state[value]
          @update_model_state()

    update_model_state: =>
      React.render(React.createElement(GameStateView, {
        model_state: @model.getState() 
        event_handler: @event_handler      
        help_is_open: @state.help_is_open
        high_scores: @high_score_data.getState()
        high_scores_is_open: @state.high_scores_is_open
        game_over_is_open: @state.game_over_is_open
      }), @container)