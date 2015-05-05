define [
  'assets/scripts/namespace.js'
  'eventemitter2.js'
  'https://cdn.firebase.com/js/client/2.2.4/firebase.js'
], (zt, EventEmitter2, Firebase2_4) ->
  
  class zt.HighScoreData

    constructor: (options) ->

      @emitter = new EventEmitter2()

      fb = new Firebase("https://blistering-inferno-4564.firebaseio.com/v1_0/scores");
      fb.authAnonymously (error, authData) ->
        if (error)
          console.log("Login Failed!", error)
        else
          console.log("Authenticated successfully with payload:", authData);

      fb.on 'value', (data) ->
        @global_data = (item for key, item of data.val())
        @local_data = (item for key, item of data.val() when item.who is fb.getAuth().auth.uid)
        @recent_data = (item for key, item of data.val() when item.date > new Date().getTime() - 1000 * 60 * 60 * 24 * 7)

    getState: ->
      global_data: @global_data
      local_data: @local_data
      recent_data: @recent_data
