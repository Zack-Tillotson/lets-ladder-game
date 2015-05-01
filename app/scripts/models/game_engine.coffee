define [
  '/assets/scripts/namespace.js'
], (zt) ->
  
  class zt.GameEngine

    constructor: (options) ->
      options = _.extend {}, GameEngine.defaults, options
      
      @level = options.level

    getRandomCheckDistribution: (dist = @getCheckDistribution()) ->
      new zt.Distribution
        min: 0
        max: 100
        target: dist.getValue()
        pattern: 'linear'
        type: 'boolean'

    getCheckDistribution: (level = @level) ->
      new zt.Distribution
        min: 15
        max: 80 - 50 / Math.pow(level, .5)
        pattern: 'linear'
        type: 'numeric'

    getRewardDistribution: (target = 1, level = @level)  ->
      new zt.Distribution
        min: Math.pow(1.25, level)
        max: Math.pow(1.25, level) * target / 10
        pattern: 'linear'
        type: 'numeric'

    getResetDoorsCost: (level = @level) ->
      Math.ceil(Math.pow(1.25, level) * 3.5)

    @defaults:
      level: 1