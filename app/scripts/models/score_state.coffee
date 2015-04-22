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

    decreaseMoney: (amt) ->
      @increaseMoney -1 * amt

    addStrike: ->
      @strikes++
      if @isMaxStrikes()
        @decreaseLevel()
        return true
      else
        return false
      
    isMaxStrikes: ->
      @strikes >= @max_strikes

    @defaults:
      level: 1
      money: 0
      strikes: 0
      max_strikes: 3