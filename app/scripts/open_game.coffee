define [
  'namespace', 'react', 'models/game_state', 'views/game_state', 'models/high_score_data'
], (zt, React, GameState, GameStateView, HighScoreData) ->

  class zt.OpenGame

    constructor: (options) ->

      @container = options?.container or document.body
      @help_is_open = options?.help_is_open or false
      @auto_play_is_open = options?.auto_play_is_open or false
      @auto_play_timer = null
      @auto_play_turn_time = 3000

      # Event triggers 
      @high_score_data = new zt.HighScoreData()
      @high_score_data.emitter.on 'state_change', =>
        @update_model_state()

      @initialize()

      # Call the load finish GA event
      ga('send', 'event', 'open_game', 'loaded', 'load time', new Date().getTime() - window.startLoadTime) if typeof ga is "function"

    initialize: =>

      @model = new zt.GameState() 

      # Used to show elements of the UI which can be hidden
      @toggle_state =
        help_is_open: @help_is_open
        high_scores_is_open: false
        auto_play_is_open: @auto_play_is_open

      # Used for color highlighting pieces of the UI
      @recent_state =
        up: false
        down: false
      
      # Keep track of UI element
      @disable_actions = false
      @current_actions = 0

      # Should the computer control, keep between game
      @auto_play_state = @auto_play_state or
        active: false

      # The game's state
      @current_model_state = @model.getState()

      # And draw once to start us off
      @update_model_state()

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
          @update_model_state @model.getState()
          
          setTimeout =>
            @recent_state.reset = false
            @update_model_state()
          , 1500
          
        when 'toggle'

          @toggle_state[key] = false for key, val in @toggle_state when key isnt value # Ensure all other views are closed
          @toggle_state[value] = !@toggle_state[value]
          @update_model_state()

        when 'update_high_score_name'

          @high_score_data.updateHighScoreInformation name: value

        when 'new_game'

          @initialize()

        when 'auto-player'

          switch value
            when 'play' 
              @auto_play_state.active = true
              @auto_play_state.last_action_time = new Date().getTime()
              @auto_play_timer = setInterval(@triggerAutoPlay, 50) if not @auto_play_timer?
            when 'pause'
              @auto_play_state.active = false
              clearInterval @auto_play_timer if @auto_play_timer?
              @auto_play_timer = null
            when 'faster'
              @auto_play_turn_time *= .75
            when 'slower'
              @auto_play_turn_time /= .75
          
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
        auto_play_state: @auto_play_state
        auto_play_is_open: @toggle_state.auto_play_is_open
        auto_play_time_to_action: @getAutoPlayTimeLeft()
      }), @container)

    triggerAutoPlay: =>
      if @auto_play_state.active && @getAutoPlayTimeLeft() <= 0
        @auto_play_state.last_action_time = new Date().getTime()
        @event_handler 'open_door', @current_model_state.suggestion
      @update_model_state()

    getAutoPlayTimeLeft: ->
      parseInt((@auto_play_turn_time - (new Date().getTime() - @auto_play_state.last_action_time))/@auto_play_turn_time*100)