define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/models/score_state.js'
], (zt, React, ScoreState) ->

  ScoreStateView = React.createClass
    render: ->
      <div class="score-state">
        <div class="level">Level: {this.props.level}</div>
        <div class="money">Money: {this.props.money}</div>
        <div class="stikes">Strikes: {this.props.strikes}</div>
        <div class="max-strikes">Max Strikes: {this.props.max_strikes}</div>
      </div>