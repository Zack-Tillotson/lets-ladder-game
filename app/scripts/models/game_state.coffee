define [
  'namespace'
  'libs/eventemitter2'
  'models/score_state'
  'models/distribution'
  'models/door'
  'models/door_list'
  'models/game_engine'
], (zt, EventEmitter2) ->
  
  class zt.GameState

  	constructor: (options) ->

      @game_engine = new zt.GameEngine()
      @score_state = new zt.ScoreState(game_engine: @game_engine)
      @doors = new zt.DoorList(game_engine: @game_engine)
      
      @emitter = new EventEmitter2()
      @allow_events = true # Used to prevent multiple events from being triggered at once

    getState: ->
      allow_events: @allow_events
      score: @score_state.getState()
      door_list: @doors.getState()
      action_options:
        reset_doors: 
          cost: reset_door_cost = @game_engine.getResetDoorsCost()
          active:  reset_door_cost < @score_state.money and not @score_state.isGameOver()

    #### User Actions ##############

    delayAction: (fn, waitTime = 1500) ->
      @emitter.once 'ui_wait', fn
      @allow_events = false
      setTimeout( => 
        @allow_events = true
        @emitter.emit 'ui_wait'
        @emitter.emit 'state_change'
      , waitTime)

    actionOpenDoor: (index) ->
      return if not @allow_events or @score_state.isGameOver() or @doors[index].status isnt "unopened"

      @doors[index].open()
      
      if @doors.isAtMaxChecks()
        
        @score_state.increaseMoney @doors.getRewardedTotal()
        @game_engine.level = @score_state.increaseLevel()
        
        @delayAction =>
          @doors.resetDoors()

      else if @doors.isAtMaxStrikes()

        @game_engine.level = @score_state.decreaseLevel()
        if @score_state.loseALife()
          @delayAction =>
            @doors.resetDoors()
        else
          @delayAction => @emitter.emit('game_over', @getState())

      @emitter.emit 'state_change'

    actionResetDoors: ->
      return if not @allow_events or @score_state.isGameOver()

      if @game_engine.getResetDoorsCost() < @score_state.money
        @score_state.decreaseMoney @game_engine.getResetDoorsCost()
        @doors.resetDoors()

      @emitter.emit 'state_change'