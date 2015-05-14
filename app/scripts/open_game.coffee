define [
  'namespace', 'react', 'models/game_state', 'views/game_state', 'models/high_score_data'
], (zt, React, GameState, GameStateView, HighScoreData) ->

  class zt.OpenGame

    constructor: (options) ->

      @container = options?.container or document.body
      
      # Event triggers 
      @high_score_data = new zt.HighScoreData()
      @high_score_data.emitter.on 'state_change', =>
        @update_model_state()

      @initialize()

      # And draw once to start us off
      @update_model_state()

      # Call the load finish GA event
      ga('send', 'event', 'open_game', 'loaded', 'load time', new Date().getTime() - window.startLoadTime) if typeof ga is "function"

    initialize: =>
      @model = new zt.GameState()
      
      @toggle_state =
        help_is_open: false
        high_scores_is_open: false
      @recent_state =
        up: false
        down: false
      
      @disable_actions = false
      @current_actions = 0

      @current_model_state = @model.getState()
      @high_score = null

    event_handler: (action, value) =>
      return if @disable_actions

      switch action
        when 'open_door'

          door_result_state = @model.actionOpenDoor(value)

          if door_result_state

            # After a pause update the rest of the state
            @current_actions++
            setTimeout =>
              @current_actions--
              if @current_actions is 0
                
                if door_result_state.level_down or door_result_state.level_up
                  @recent_state.down = door_result_state.level_down ? false
                  @recent_state.up = door_result_state.level_up ? false
                  setTimeout =>
                    @recent_state.down = false
                    @recent_state.up = false
                    @update_model_state()
                  , 1500

                @update_model_state @model.getState()

            , 750

            # For now, just update the state of that door
            @current_model_state.door_list.doors[value] = door_result_state.door            
            @update_model_state()

            # Save the score if it's game over
            if door_result_state.game_over
              @high_score_data.saveGameInformation @model.getState()

        when 'reset_doors'
          @model.actionResetDoors()
          @recent_state.reset = true
          setTimeout =>
            @recent_state.reset = false
            @update_model_state()
          , 1500
          @update_model_state @model.getState()
        when 'toggle'
          @toggle_state[key] = false for key, val in @toggle_state when key isnt value # Ensure all other views are closed
          @toggle_state[value] = !@toggle_state[value]
          @update_model_state()
        when 'update_high_score_name'
          @high_score_data.updateHighScoreInformation name: value
        when 'new_game'
          @initialize()
          @update_model_state()

    update_model_state: (model_state = @current_model_state) =>

      @current_model_state = model_state
      @disable_actions = @current_model_state.score.level isnt @model.getState().score.level
            
      React.render(React.createElement(GameStateView, {
        disable_actions: @disable_actions
        model_state: model_state 
        event_handler: @event_handler      
        help_is_open: @toggle_state.help_is_open
        high_scores: @high_score_data.getState()
        high_scores_is_open: @toggle_state.high_scores_is_open
        game_over_is_open: model_state.score.is_game_over
        recent_state: @recent_state
      }), @container)