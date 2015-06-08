define ['namespace', 'models/door_list', 'models/door'], (zt, DoorList, Door) ->
  describe "zt.DoorList", ->

    describe "in a standard initial state", ->

      beforeEach ->
        @doors = new zt.DoorList
          door_count: 10

      it "should have the correct number of doors", ->
        expect(@doors.length).toBe 10

      it "should say we don't have any checks or strikes", ->
        expect(@doors.getState().is_max_checks).toBe false
        expect(@doors.getState().check_count).toBe 0
        expect(@doors.getState().is_max_strikes).toBe false        
        expect(@doors.getState().strike_count).toBe 0

    describe "When there are three check doors", ->

      beforeEach ->
        @doors = new zt.DoorList 
          doors: [
            new Door status: 'check'
            new Door status: 'check'
            new Door status: 'check' 
            new Door ]
          door_count: 4


      it "should say we don't have any strikes", ->
        expect(@doors.getState().is_max_strikes).toBe false        
        expect(@doors.getState().strike_count).toBe 0

      it "should say we have the max checks", ->
        expect(@doors.getState().is_max_checks).toBe true
        expect(@doors.getState().check_count).toBe 3

    describe "When there are three strike doors", ->

      beforeEach ->
        @doors = new zt.DoorList 
          doors: [
            new Door status: 'strike'
            new Door status: 'strike'
            new Door status: 'check' 
            new Door status: 'strike' ]
          door_count: 4


      it "should say we don't have any strikes", ->
        expect(@doors.getState().is_max_strikes).toBe true        
        expect(@doors.getState().strike_count).toBe 3

      it "should say we have the max checks", ->
        expect(@doors.getState().is_max_checks).toBe false
        expect(@doors.getState().check_count).toBe 1
