define ['/assets/scripts/namespace.js'], (zt) ->
  
  class zt.GameState

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (options) ->
      @score_state = options?.score_state or new zt.ScoreState()
      @doors = []
      @resetDoors()
      
    resetDoors: ->
      @doors = []
      @addDoor()

    addDoor: (doors = @doors) ->
       doors.push new zt.Door(@getCurrentSuccessDistribution(), @getCurrentRewardDistribution())

    #### Current actions' values (cost, reward, etc) ##########

    getCurrentSuccessDistribution: (door_count = @doors.length) ->
      new zt.Distribution
        min: 0
        max: 100
        target: door_count
        pattern: 'linear'
        type: 'boolean'

    getCurrentRewardDistribution: (level = @score_state.level, door_count = @doors.length) ->
      new zt.Distribution
        min: level + door_count
        max: 5 + 2 * (level + door_count)
        target: door_count
        pattern: 'linear'
        type: 'numeric'

    getCurrentResetDoorsCost: (level = @score_state.level) ->
      reward_distribution = @getCurrentRewardDistribution()
      Math.ceil((reward_distribution.min + reward_distribution.max) / 2 * 3)

    getCurrentGoUpLevelCost: (level = @score_state.level) ->
      reward_distribution = @getCurrentRewardDistribution()
      Math.ceil((reward_distribution.min + reward_distribution.max) / 2 * 10)

    #### User Actions ##############

    chooseOpenDoor: ->
      current_door = @doors[@doors.length-1]
      @doors.push(new zt.Door(@getCurrentSuccessDistribution(), @getCurrentRewardDistribution()))
      switch current_door.open()
        when "success"
          @score_state.increaseMoney(current_door.reward)
        when "failure"
          @resetDoors() if @score_state.addStrike()

    chooseResetDoors: ->
      @score_state.decreaseMoney @getCurrentResetDoorsCost()
      @resetDoors()

    chooseGoUpLevel: ->
      @score_state.decreaseMoney @getCurrentGoUpLevelCost()
      @resetDoors()
      @score_state.increaseLevel()
