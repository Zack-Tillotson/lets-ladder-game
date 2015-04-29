define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/models/score_state.js'
], (zt, React, ScoreState) ->

  ScoreStateView = React.createClass
    render: ->
      <div className="score-state">
        <div className="level">Level: {@props.score.level}</div>
        <div className="money">Money: {@props.score.money}</div>
        <div className="stikes">Strikes: {@props.score.strikes}</div>
        <div className="max-strikes">Max Strikes: {@props.score.max_strikes}</div>
      </div>