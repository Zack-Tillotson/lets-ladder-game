define [
  'namespace'
  'models/distribution'
  'models/door'
  'models/game_engine'
], (zt) ->
  
  class zt.DoorList

    constructor: (options) ->

      options = _.extend {}, DoorList.defaults, options

      @game_engine = options.game_engine
      @door_count = options.door_count
      @max_check = options.max_check
      @max_strike = options.max_strike

      @resetDoors()

      if options.doors?.length? > 0
        @[i] = options.doors[i] for i in [0...options.doors.length]

    push: (item) ->
      @[@length++] = item

    addDoor: ->
      dist = @game_engine.getRandomCheckDistribution()
      @push new zt.Door
        strike_odds: dist.target
        is_check: dist.getValue()
        reward: @game_engine.getRewardDistribution(dist.target).getValue()

    resetDoors: ->
      @length = 0
      @addDoor() for i in [1..@door_count]

    getState: ->
      check_count: @getCheckCount()
      max_check_count: @max_check
      is_max_checks: @getCheckCount() >= @max_check
      strike_count: @getStrikeCount()
      max_strike_count: @max_strike
      is_max_strikes: @getStrikeCount() >= @max_strike
      unopened_count: @getUnopenedCount()
      exposed_rewards: @getRewardedTotal()
      doors: (@[i].getState() for i in [0...@length])

    getDoors: (status) ->
      if status?
        _.where @, status: status
      else
        @

    getCheckDoors: ->
      @getDoors "check"

    getStrikeDoors: ->
      @getDoors "strike"

    getRewardedTotal: ->
      _.reduce @getCheckDoors(), ((memo, item) -> memo + item.reward), 0

    getCheckCount: ->
      @getCheckDoors().length

    getStrikeCount: ->
      @getStrikeDoors().length

    getUnopenedCount: ->
      @getDoors("unopened").length

    isAtMaxChecks: ->
      @getCheckCount() >= @max_check

    isAtMaxStrikes: ->
      @getStrikeCount() >= @max_strike
    
    @defaults:
      door_count: 10
      max_check: 3
      max_strike: 3
      game_engine: new zt.GameEngine()

      