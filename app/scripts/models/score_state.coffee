define ['/assets/scripts/namespace.js'], (zt) ->
  
  class zt.ScoreState

  	constructor: (options) ->
  		@initializeState options

  	initializeState: (initial_state = ScoreState.defaults) ->
      @level = initial_state.level
      @money = initial_state.money
      @starting_lives = initial_state.starting_lives
      @lives = initial_state.lives

    getState: ->
      level: @level
      money: @money
      lives: @lives
      starting_lives: @starting_lives
      is_game_over: @isGameOver()

    increaseLevel: ->
      @level++

    decreaseLevel: ->
      @money = 0
      @level-- if @level > 1

    increaseMoney: (amt) ->
      @money += amt

    decreaseMoney: (amt) ->
      @increaseMoney -1 * amt

    loseALife: ->
      @lives--
      @isGameOver()
      
    isGameOver: ->
      @lives is 0

    @defaults:
      level: 1
      money: 0
      starting_lives: 3
      lives: 3