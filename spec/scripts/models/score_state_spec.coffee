define ['namespace', 'views/score_state'], (zt, ScoreState) ->
  describe "zt.ScoreState", ->

    describe "adding and removing money", ->

      beforeEach ->
        @state = new zt.ScoreState
          money: 100
          level: 3
          starting_lives: 3
          lives: 3

      it "should correctly add a positive amount of money", ->
        
        before_amt = @state.getState().money
        delta = 5

        @state.increaseMoney(delta)

        expect(@state.getState().money).toBe(before_amt + delta)

      it "should correctly add a negative amount of money", ->
        
        before_amt = @state.getState().money
        delta = -5

        @state.increaseMoney(delta)

        expect(@state.getState().money).toBe(before_amt + delta)

      it "should correctly not go below zero money when increasing", ->
        
        before_amt = @state.getState().money
        delta = -10000

        @state.increaseMoney(delta)

        expect(@state.getState().money).toBe(0)

    describe "incraseing and decreasing the level", ->

      beforeEach ->
        @state = new zt.ScoreState
          money: 100
          level: 3
          starting_lives: 3
          lives: 3

      it "should correctly increase the level", ->
        
        before_level = @state.getState().level

        @state.increaseLevel()

        expect(@state.getState().level).toBe(before_level + 1)

      it "should correctly go down a level", ->
        
        before_level = @state.getState().level
        
        @state.decreaseLevel()

        expect(@state.getState().level).toBe(before_level - 1)

      it "should correctly stay at minimum of level 1", ->
        
        @state.decreaseLevel()
        @state.decreaseLevel()
        @state.decreaseLevel()
        @state.decreaseLevel()
        @state.decreaseLevel()

        expect(@state.getState().level).toBe(1)

      