require ['public/assets/scripts/main', 'public/assets/scripts/models/score_state'], ->
  describe "zt.ScoreState", ->

    describe "in a standard initial state", ->

      beforeEach: ->
        @state = new zt.ScoreState()

      it "has correct starting attributes", ->
        console.log(@, @state, zt.ScoreState)
        expect(@state.level).toBe(1)
        expect(@state.money).toBe(0)
        expect(@state.strikes).toBe(0)