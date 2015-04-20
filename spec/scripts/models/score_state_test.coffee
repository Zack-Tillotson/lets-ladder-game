requirejs ['public/assets/scripts/namespace', 'public/assets/scripts/models/score_state'], (zt, ScoreState) ->
  describe "zt.ScoreState", ->

    describe "in a standard initial state", ->

      beforeEach: ->
        @state = new zt.ScoreState()

      it "has correct starting attributes", ->
        expect(@state.level).toBe(1)
        expect(@state.money).toBe(0)
        expect(@state.strikes).toBe(0)