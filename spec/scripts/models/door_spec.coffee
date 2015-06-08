define ['namespace', 'models/distribution', 'models/door'], (zt, Distribution, Door) ->
  describe "zt.Door", ->

    describe "in a standard initial state", ->

      beforeEach ->
        @door = new zt.Door()

      it "has correct starting reward", ->
        expect(@door.getState().reward).toBe 0

      it "has correct starting state", ->
        expect(@door.getState().status).toBe 'unopened'

      it "has the expected success odds", ->
        expect(@door.getState().strike_odds).toBe 1

      it "has the expected success or not boolean", ->
        expect(@door.getState().is_check).toBe true

      it "should react correctly to being opened", ->
        expect(@door.getState().status).toBe "unopened"
        @door.open()
        expect(@door.getState().status).toBe "check"