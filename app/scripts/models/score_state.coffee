define ['/assets/scripts/namespace.js'], (zt) ->
  
  class zt.ScoreState

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (initial_state = ScoreState.defaults) ->
      @level = initial_state.level
      @money = initial_state.money
      @strikes = initial_state.strikes
      @max_strikes = initial_state.max_strikes

    increaseLevel: ->
      @level++
      @strikes = 0

    decreaseLevel: ->
      @strikes = 0
      @money = 0
      @level-- if @level > 1

    increaseMoney: (amt) ->
      @money += amt

    addStrike: ->
      @strikes++
      @decreaseLevel() if @isMaxStrikes()
      
    isMaxStrikes: ->
      @strikes >= @max_strikes

    @defaults:
      level: 1
      money: 0
      strikes: 0
      max_strikes: 3