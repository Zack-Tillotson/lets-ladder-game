describe "ScoreState", ->

  describe "a standard initial state", ->

    beforeEach: ->
      state = new ScoreState()

    it "has correct starting attributes", ->
      expect(state.level).toBe(1)
      expect(state.money).toBe(0)
      expect(state.strikes).toBe(0)