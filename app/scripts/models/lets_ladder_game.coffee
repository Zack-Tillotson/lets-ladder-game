define [
  '/assets/scripts/namespace.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/models/distribution.js'
  '/assets/scripts/models/door.js'
  '/assets/scripts/models/door_list.js'
  '/assets/scripts/views/lets_ladder_game.js'
], (zt) ->
  
  class zt.LetsLadderGame

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (options) ->
      @score_state = options?.score_state or new zt.ScoreState()
      @door_count = options?.door_count or 5
      @resetDoors()

    getState: ->
      score: @score_state.getState()
      doors: @doors.getState()
      action_options:
        reset_doors: 
          cost: @getCurrentResetDoorsCost()
          active:  @getCurrentResetDoorsCost() < @score_state.money
      
    resetDoors: ->
      @doors = new zt.DoorList()
      @addDoor() for i in [1..@door_count]

    addDoor: (doors = @doors) ->
      dist = @getRandomCurrentSuccessDistribution()
      doors.push new zt.Door(dist.target, dist.getValue(), @getCurrentRewardDistribution(@score_state.level, dist.target).getValue())

    getCurrentDoor: (doors = @doors) ->
      current_door = doors[doors.length-1]

    #### Current actions' values (cost, reward, etc) ##########

    getRandomCurrentSuccessDistribution: (dist = @getCurrentSuccessDistribution()) ->
      new zt.Distribution
        min: 0
        max: 100
        target: dist.getValue()
        pattern: 'linear'
        type: 'boolean'

    getCurrentSuccessDistribution: (level = @score_state.level) ->
      new zt.Distribution
        min: 10
        max: 50 - 20 / level
        pattern: 'linear'
        type: 'numeric'

    getCurrentRewardDistribution: (level = @score_state.level, target = 1) ->
      new zt.Distribution
        min: Math.pow(1.25, level)
        max: Math.pow(1.25, level) * target / 10
        pattern: 'linear'
        type: 'numeric'

     getCurrentResetDoorsCost: (level = @score_state.level) ->
       Math.ceil(Math.pow(1.25, level) * 3.5)

    #### User Actions ##############

    chooseOpenDoor: (index) ->
      door = @doors[index]
      if door.status is "unopened"
        switch @doors[index].open()
          when "success"
            @score_state.increaseMoney(@doors[index].reward)
          when "failure"
            @resetDoors() if @score_state.addStrike()
        if @doors.allDoorsOpened()
            @score_state.increaseLevel()
            @resetDoors()
        return true
      return false

    chooseResetDoors: ->
      if @getCurrentResetDoorsCost() < @score_state.money
        @score_state.decreaseMoney @getCurrentResetDoorsCost()
        @resetDoors()
        @score_state.resetStrikes()
        return true
      else
        return false