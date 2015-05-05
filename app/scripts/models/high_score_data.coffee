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

      fb.on 'value', (data) =>
        @global_scores = (item for key, item of data.val())
        @local_scores = (item for key, item of data.val() when item.who is fb.getAuth().auth.uid)
        @recent_scores = (item for key, item of data.val() when item.date > new Date().getTime() - 1000 * 60 * 60 * 24 * 7)

        @emitter.emit 'state_change'

    getState: ->
      global_scores: @global_scores
      local_scores: @local_scores
      recent_scores: @recent_scores
