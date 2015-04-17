#= require 'ScoreState'

class GameState
	constuctor: ->
		@initializeState()

	initializeState: () ->
		score = new ScoreState()