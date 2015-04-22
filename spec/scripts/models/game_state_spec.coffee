define [
  '/assets/scripts/namespace.js'
  '/assets/scripts/models/door.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/models/game_state.js'
], (zt, Door, ScoreState) ->

  describe "zt.GameState", ->

    describe "in a standard initial state", ->

      beforeEach ->
        @game_state = new zt.GameState()

      it "has correct starting reward", ->
        expect(@game_state.score_state).not.toBe null
        expect(@game_state.doors).toBeTruthy()
        expect(@game_state.doors.length).toBe 1

      it "has a sensible success distribution", ->
        dist = @game_state.getCurrentSuccessDistribution(0)
        expect(typeof dist.getValue()).toBe "boolean"

      it "has a sensible reward distribution", ->
        val = @game_state.getCurrentRewardDistribution().getValue()
        expect(typeof val).toBe "number"

      it "has a sensible reset doors cost", ->
        val = @game_state.getCurrentResetDoorsCost()
        expect(typeof val).toBe "number"
        expect(val).toBeGreaterThan 0

      it "has a sensible go up level cost", ->
        val = @game_state.getCurrentGoUpLevelCost()
        expect(typeof val).toBe "number"
        expect(val).toBeGreaterThan 0

    describe "handling the user actions from default initial state", ->

      beforeEach ->
        @game_state = new zt.GameState()

      it "opening a door successfully", ->
        spyOn(@game_state.doors[0], 'open').and.callThrough()
        spyOn(@game_state.doors[0], 'isSuccessful').and.returnValue true
        spyOn(@game_state.doors[0], 'generateReward').and.returnValue 58
        
        @game_state.chooseOpenDoor()

        expect(@game_state.doors.length).toBe(2)
        expect(@game_state.doors[0].result).toBe("success")
        expect(@game_state.score_state.money).toBe(58)

      it "opening a door unsuccessfully", ->
        spyOn(@game_state.doors[0], 'open').and.callThrough()
        spyOn(@game_state.doors[0], 'isSuccessful').and.returnValue false

        @game_state.chooseOpenDoor()

        expect(@game_state.doors.length).toBe(2)
        expect(@game_state.doors[0].result).toBe("failure")
        expect(@game_state.score_state.money).toBe(0)

    describe "handling the user actions from a far state", ->

      beforeEach ->
        @game_state = new zt.GameState
          score_state: new zt.ScoreState
            level: 10
            money: 100
            strikes: 2
            max_strikes: 3

      it "opening the last door unsuccessfully", ->
        spyOn(@game_state.doors[0], 'open').and.callThrough()
        spyOn(@game_state.doors[0], 'isSuccessful').and.returnValue false

        @game_state.chooseOpenDoor()

        expect(@game_state.doors.length).toBe 1
        expect(@game_state.doors[0].result).toBe 'unopened'
        expect(@game_state.score_state.money).toBe 0
        expect(@game_state.score_state.level).toBe 9

      it "reseting the doors", ->

        spyOn(@game_state, 'getCurrentResetDoorsCost').and.returnValue 12

        @game_state.chooseResetDoors()

        expect(@game_state.getCurrentResetDoorsCost).toHaveBeenCalled()
        expect(@game_state.doors.length).toBe 1
        expect(@game_state.doors[0].result).toBe 'unopened'
        expect(@game_state.score_state.money).toBe 88
        expect(@game_state.score_state.level).toBe 10
        expect(@game_state.score_state.strikes).toBe 2

      it "goes up a level", ->

        spyOn(@game_state, 'getCurrentGoUpLevelCost').and.returnValue 50

        @game_state.chooseGoUpLevel()

        expect(@game_state.getCurrentGoUpLevelCost).toHaveBeenCalled()
        expect(@game_state.doors.length).toBe 1
        expect(@game_state.doors[0].result).toBe 'unopened'
        expect(@game_state.score_state.money).toBe 50
        expect(@game_state.score_state.level).toBe 11
        expect(@game_state.score_state.strikes).toBe 0
        
        