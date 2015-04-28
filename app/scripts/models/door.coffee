define ['/assets/scripts/namespace.js'], (zt) ->

    class zt.Door
      constructor: (success_distribution, reward_distribution) ->
        @initializeState success_distribution, reward_distribution

      initializeState: (success_distribution = Door.defaults.success_distribution, reward_distribution = Door.defaults.reward_distribution) ->
        @reward = Door.defaults.reward
        @result = Door.defaults.result
        @success_distribution = success_distribution
        @reward_distribution = reward_distribution

      getState: ->
        reward = @reward
        result = @result
        success_distribution = @success_distribution
        reward_distribution = @reward_distribution

      open: (success_distribution = @success_distribution, reward_distribution = @reward_distribution) ->
        
        if @isSuccessful(success_distribution)
          @reward = @generateReward(reward_distribution)
          @result = 'success'
        else
          @result = 'failure'

        @result

      isSuccessful: (success_distribution = @success_distribution) ->
        success_distribution.getValue()

      generateReward: (reward_distribution = @defaults.reward_distribution) ->
        reward_distribution.getValue()

      @defaults:
        reward: 0        
        result: 'unopened' # [unopened, success, failure]
        success_distribution: # Result is either true (succssful) or false (unsuccessful)
          getValue: ->
            true
        reward_distribution: # Result is a number [0, Inf) which is the amount of money the door is worth
          getValue: ->
            0