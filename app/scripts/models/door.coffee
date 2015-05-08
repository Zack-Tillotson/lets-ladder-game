define ['namespace'], (zt) ->

    class zt.Door

      constructor: (options) ->
        options = _.extend {}, Door.defaults, options

        @reward = options.reward
        @strike_odds = options.strike_odds
        @is_check = options.is_check
        @status = options.status

      getState: ->
        reward: @reward
        status: @status
        is_check: @is_check
        strike_odds: @strike_odds

      open: (is_check = @is_check) ->
        @status = if is_check then 'check' else 'strike'
          
      @defaults:
        reward: 0        
        status: 'unopened' # [unopened, check, strike]
        strike_odds: 1
        is_check: true