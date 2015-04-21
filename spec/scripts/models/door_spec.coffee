define ['/assets/scripts/namespace.js', '/assets/scripts/models/door.js'], (zt, Door) ->
  describe "zt.Door", ->

    describe "in a standard initial state", ->

      beforeEach ->
        @door = new zt.Door()

      it "has correct starting reward", ->
        expect(@door.reward).toBe 0

      it "has correct starting state", ->
        expect(@door.result).toBe 'unopened'

      it "has the expected success distribution", ->
        expect(@door.success_distribution.getValue()).toBe true

      it "has the expected reward distribution", ->
        expect(@door.reward_distribution.getValue()).toBe 0

      it "should react correctly to being opened", ->
        expect(@door.reward).toBe 0
        expect(@door.result).toBe "unopened"
        @door.open()
        expect(@door.reward).toBe 0
        expect(@door.result).toBe "success"

    describe "using non standard distributions", ->

      beforeEach ->
        @door = new zt.Door
          reward: 0
          result: 'unopened'
          success_distribution:
            getValue: ->
              false
          reward_distribution:
            getValue: ->
              21

      it "should return the correct success", ->
        expect(@door.success_distribution.getValue()).toBe false

      it "should return the correct reward", ->
        expect(@door.reward_distribution.getValue()).toBe 21

      it "should react correctly to being opened", ->
        expect(@door.reward).toBe 0
        expect(@door.result).toBe "unopened"
        @door.open()
        expect(@door.reward).toBe 0
        expect(@door.result).toBe "failure"

    describe "using non standard successful distributions", ->

      beforeEach ->
        @door = new zt.Door
          reward: 0
          result: 'unopened'
          success_distribution:
            getValue: ->
              true
          reward_distribution:
            getValue: ->
              21

      it "should react correctly to being opened", ->
        expect(@door.reward).toBe 0
        expect(@door.result).toBe "unopened"
        @door.open()
        expect(@door.reward).toBe 21
        expect(@door.result).toBe "success"

