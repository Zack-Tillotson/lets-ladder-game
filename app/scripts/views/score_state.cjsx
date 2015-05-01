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
        <div className="lives">Lives: {@props.score.lives}</div>
        <div className="starting-lives">Starting Lives: {@props.score.starting_lives}</div>
        <div className="is-game-over">Game Over? {if @props.score.is_game_over then "true" else "false"}</div>
      </div>