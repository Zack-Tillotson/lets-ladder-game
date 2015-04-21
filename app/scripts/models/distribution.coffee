define ['/assets/scripts/namespace.js', 'math-1.5.1.min.js'], (zt) ->

    class zt.Distribution
      constructor: (options) ->
        @initializeState options

      initializeState: (initial_state = Distribution.defaults) ->
        @min = initial_state.min
        @max = initial_state.max
        @type = initial_state.type
        @target = initial_state.target
        @pattern = initial_state.pattern

      getValue: ->
        val = switch @pattern
          when "linear"
            mathjs.randomInt(@min, @max)

        @convertToType val

      convertToType: (value) ->

        switch @type
          when "numeric" then value
          when "boolean" then (if value > @target then true else false)

      @defaults:
        min: 0
        max: 100
        target: 10
        pattern: 'linear' # [ linear, numeric ]
        type: 'numeric' # [ numeric, boolean ]