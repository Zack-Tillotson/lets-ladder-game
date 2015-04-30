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
      state = (@[i].getState() for i in [0...@length])

    getDoorsOfStatus: (status = "unopened") ->
      _.where @, status: status

    getSuccessDoors: ->
      @getDoorsOfStatus "success"

    getFailureDoors: ->
      @getDoorsOfStatus "failure"

    getSuccessRewardTotal: ->
      _.reduce @getSuccessDoors(), ((memo, item) -> memo + item.reward), 0

    getSuccessCount: ->
      @getSuccessDoors().length

    getFailureCount: ->
      @getFailureDoors().length


      