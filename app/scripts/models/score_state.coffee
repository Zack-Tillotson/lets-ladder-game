class ScoreState
	constructor: ->
		@initializeState()

	initializeState: (level = 1) ->
		@level = level
		@money = 0
		@strikes = 0