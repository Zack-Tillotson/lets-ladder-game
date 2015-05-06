define [
  'assets/scripts/namespace.js'
], (zt) ->
  
  class zt.GameEngine


    constructor: (options) ->
      options = _.extend {}, GameEngine.defaults, options
      
      @level = options.level
      @growth_factor = options.growth_factor

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
        min: Math.pow(@growth_factor, level)
        max: Math.pow(@growth_factor, level) * target / 10
        pattern: 'linear'
        type: 'numeric'

    getResetDoorsCost: (level = @level) ->
      Math.ceil(Math.pow(@growth_factor, level) * 3.5)

    @defaults:
      level: 1
      growth_factor: 1.2