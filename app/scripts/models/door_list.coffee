define [
  '/assets/scripts/namespace.js'
  '/assets/scripts/models/distribution.js'
  '/assets/scripts/models/door.js'
], (zt) ->
  
  class zt.DoorList

    constructor: (options) ->
      @initializeState options

    initializeState: (options) ->
      if options?.length > 0
        @length = options.length
        @[i] = options[i] for i in [0...@length]
      else
        @length = 0

    push: (item) ->
      @[@length++] = item

    getState: ->
      check_count: @getCheckCount()
      strike_count: @getStrikeCount()
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


      