define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/models/score_state.js'
], (zt, React, ScoreState) ->

  ScoreStateView = React.createClass
    render: ->

      game_over_class = if @props.score.is_game_over then "game_over" else "game_over"
      lives_elements = (<span className="fa heart #{if i > @props.score.lives then 'fa-heart-o lost-heart' else 'fa-heart'}" /> for i in [1..@props.score.starting_lives])
          
      <div className="score-state #{game_over_class}">
        <div className="level">
          <div className="title">Level</div>
          <div className="value">{@props.score.level}</div>
        </div>
        <div className="money">${@props.score.money}</div>
        <div className="lives">{lives_elements}</div>
      </div>