define ['/assets/scripts/namespace.js'], (zt) ->
  
  class zt.ScoreState

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (initial_state = ScoreState.defaults) ->
      @level = initial_state.level
      @money = initial_state.money
      @strikes = initial_state.strikes
      @max_strikes = initial_state.max_strikes
      @is_game_over = initial_state.is_game_over

    getState: ->
      level: @level
      money: @money
      strikes: @strikes
      max_strikes: @max_strikes
      is_game_over: @is_game_over

    increaseLevel: ->
      @level++

    decreaseLevel: ->
      @money = 0
      @level-- if @level > 1

    increaseMoney: (amt) ->
      @money += amt

    decreaseMoney: (amt) ->
      @increaseMoney -1 * amt

    addStrike: ->
      @strikes++
      @setGameOver @isMaxStrikes()
      
    resetStrikes: ->
      @strikes = 0
      
    isMaxStrikes: ->
      @strikes >= @max_strikes

    setGameOver: (is_game_over = false)->
      @is_game_over = is_game_over

    @defaults:
      level: 1
      money: 0
      strikes: 0
      max_strikes: 3
      is_game_over: false