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

    allDoorsOpened: ->
      !(_.find @, (item) -> item.status is "unopened")
      