define ['/assets/scripts/namespace.js'], (zt) ->
  
  class zt.ScoreState

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (initial_state = ScoreState.defaults) ->
      @level = initial_state.level
      @money = initial_state.money
      @strikes = initial_state.strikes
      @max_strikes = initial_state.max_strikes

    doIncreaseLevel: ->
      @level++
      @strikes = 0

    doDecreaseLevel: ->
      @strikes = 0
      @money = 0
      @level-- if @level > 1

    doIncreaseMoney: (amt) ->
      @money += amt

    doStrike: ->
      @strikes++
      @doDecreaseLevel() if @isMaxStrikes()
      
    isMaxStrikes: ->
      @strikes >= @max_strikes

    @defaults:
      level: 1
      money: 0
      strikes: 0
      max_strikes: 3