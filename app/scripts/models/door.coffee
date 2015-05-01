define ['/assets/scripts/namespace.js'], (zt) ->

    class zt.Door
      constructor: (strike_odds, is_check, reward) ->
        @initializeState strike_odds, is_check, reward

      initializeState: (strike_odds = Door.defaults.strike_odds, is_check = Door.defaults.is_check, reward = Door.defaults.reward) ->
        @reward = reward
        @strike_odds = strike_odds
        @is_check = is_check
        @status = Door.defaults.status

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