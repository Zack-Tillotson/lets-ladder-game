define ['/assets/scripts/namespace.js'], (zt) ->

    class zt.Door
      constructor: (success_odds, is_success, reward) ->
        @initializeState success_odds, is_success, reward

      initializeState: (success_odds = Door.defaults.success_odds, is_success = Door.defaults.is_success, reward = Door.defaults.reward) ->
        @reward = reward
        @success_odds = success_odds
        @is_success = is_success
        @status = Door.defaults.status

      getState: ->
        reward: @reward
        status: @status
        is_success: @is_success
        success_odds: @success_odds

      open: (is_success = @is_success) ->
        @status = if is_success then 'success' else 'failure'
          
      @defaults:
        reward: 0        
        status: 'unopened' # [unopened, success, failure]
        success_odds: 1
        is_success: true