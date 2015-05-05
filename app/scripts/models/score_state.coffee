define ['assets/scripts/namespace.js'], (zt) ->
  
  class zt.ScoreState

  	constructor: (options) ->
      options = _.extend {}, ScoreState.defaults, options

      @level = options.level
      @money = options.money
      @starting_lives = options.starting_lives
      @lives = options.lives

    getState: ->
      level: @level
      money: @money
      lives: @lives
      starting_lives: @starting_lives
      is_game_over: @isGameOver()

    increaseLevel: ->
      @level++

    decreaseLevel: ->
      @level-- if @level > 1
      @level

    increaseMoney: (amt) ->
      @money += amt

    decreaseMoney: (amt) ->
      @increaseMoney -1 * amt

    loseALife: ->
      --@lives
      
    isGameOver: ->
      @lives is 0

    @defaults:
      level: 1
      money: 0
      starting_lives: 3
      lives: 3