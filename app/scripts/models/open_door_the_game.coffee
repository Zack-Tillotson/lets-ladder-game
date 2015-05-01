define [
  '/assets/scripts/namespace.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/models/distribution.js'
  '/assets/scripts/models/door.js'
  '/assets/scripts/models/door_list.js'
], (zt) ->
  
  class zt.OpenDoorTheGame

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (options) ->
      @score_state = options?.score_state or new zt.ScoreState()
      @door_count = options?.door_count or 10
      @max_check = options?.max_check or 3
      @max_strike = options?.max_strike or 3
      @resetDoors()

    getState: ->
      score: @score_state.getState()
      door_list: @doors.getState()
      action_options:
        reset_doors: 
          cost: reset_door_cost = @getResetDoorsCost()
          active:  reset_door_cost < @score_state.money
      
    resetDoors: ->
      @doors = new zt.DoorList()
      @addDoor() for i in [1..@door_count]

    addDoor: (doors = @doors) ->
      dist = @getRandomCheckDistribution()
      doors.push new zt.Door(dist.target, dist.getValue(), @getRewardDistribution(@score_state.level, dist.target).getValue())

    #### Current actions' values (cost, reward, etc) ##########

    getRandomCheckDistribution: (dist = @getCheckDistribution()) ->
      new zt.Distribution
        min: 0
        max: 100
        target: dist.getValue()
        pattern: 'linear'
        type: 'boolean'

    getCheckDistribution: (level = @score_state.level) ->
      new zt.Distribution
        min: 15
        max: 80 - 50 / Math.pow(level, .5)
        pattern: 'linear'
        type: 'numeric'

    getRewardDistribution: (level = @score_state.level, target = 1) ->
      new zt.Distribution
        min: Math.pow(1.25, level)
        max: Math.pow(1.25, level) * target / 10
        pattern: 'linear'
        type: 'numeric'

     getResetDoorsCost: (level = @score_state.level) ->
       Math.ceil(Math.pow(1.25, level) * 3.5)

    #### User Actions ##############

    chooseOpenDoor: (index) ->
      return if @score_state.isGameOver()

      door = @doors[index]
      if door.status is "unopened"
        @doors[index].open()
        if @doors.getCheckCount() >= @max_check
            @score_state.increaseMoney @doors.getRewardedTotal()
            @score_state.increaseLevel()
            @resetDoors()
        else if @doors.getStrikeCount() >= @max_strike
          @resetDoors() unless @score_state.loseALife()

    chooseResetDoors: ->
      return if @score_state.isGameOver()

      if @getResetDoorsCost() < @score_state.money
        @score_state.decreaseMoney @getResetDoorsCost()
        @resetDoors()
        return true
      else
        return false