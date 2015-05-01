define [
  '/assets/scripts/namespace.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/models/distribution.js'
  '/assets/scripts/models/door.js'
  '/assets/scripts/models/door_list.js'
  '/assets/scripts/models/game_engine.js'
], (zt) ->
  
  class zt.OpenDoorTheGame

  	constructor: (options) ->
      @game_engine = new zt.GameEngine()
      @score_state = new zt.ScoreState(game_engine: @game_engine)
      @doors = new zt.DoorList(game_engine: @game_engine)

    getState: ->
      score: @score_state.getState()
      door_list: @doors.getState()
      action_options:
        reset_doors: 
          cost: reset_door_cost = @game_engine.getResetDoorsCost()
          active:  reset_door_cost < @score_state.money and not @score_state.isGameOver()

    #### User Actions ##############

    chooseOpenDoor: (index) ->
      return if @score_state.isGameOver() or @doors[index].status isnt "unopened"

      @doors[index].open()
      if @doors.isAtMaxChecks()
        @score_state.increaseMoney @doors.getRewardedTotal()
        @game_engine.level = @score_state.increaseLevel()
        @doors.resetDoors()
      else if @doors.isAtMaxStrikes()
        @doors.resetDoors() if @game_engine.level = @score_state.loseALife()

    chooseResetDoors: ->
      return if @score_state.isGameOver()

      if @game_engine.getResetDoorsCost() < @score_state.money
        @score_state.decreaseMoney @game_engine.getResetDoorsCost()
        @doors.resetDoors()