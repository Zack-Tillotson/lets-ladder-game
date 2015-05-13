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

    getState: =>
      score: @score_state.getState()
      door_list: @doors.getState()
      action_options:
        reset_doors: 
          cost: reset_door_cost = @game_engine.getResetDoorsCost()
          active:  reset_door_cost < @score_state.money and not @score_state.isGameOver()

    #### User Actions ##############

    actionOpenDoor: (index = 0) ->
      return if @score_state.isGameOver() or @doors[index].status isnt "unopened"

      result = {}
      result.door = @doors[index].open()
      
      if @doors.isAtMaxChecks()
        
        @score_state.increaseMoney @doors.getRewardedTotal()
        @game_engine.level = @score_state.increaseLevel()
        
        @doors.resetDoors()
        result.reset = true
        result.level_up = true

      else if @doors.isAtMaxStrikes()

        @game_engine.level = @score_state.decreaseLevel()
        if @score_state.loseALife()
          @doors.resetDoors()
          result.reset = true
          result.level_down = true
        else
          result.game_over = true

      result

    actionResetDoors: ->
      return if @score_state.isGameOver()

      if @game_engine.getResetDoorsCost() < @score_state.money
        @score_state.decreaseMoney @game_engine.getResetDoorsCost()
        @doors.resetDoors()
