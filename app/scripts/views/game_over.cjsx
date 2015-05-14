define ['namespace', 'react', 'views/high_score_list'], (zt, React, HighScoreList) ->

  GameOverView = React.createClass

    onNewGameClick: (e) ->
      @props.doAction 'new_game'

    render: ->
      overlay_active_class = if @props.is_open then "active" else "inactive"
      <div className="game-over-overlay">
        <div className="game-over-view #{overlay_active_class}" onClick={@onClick}>
          <div className="title">Game Over!</div>
          <input className="name"></input>
          <div className="score">${@props.score.money}</div>
          <div className="level">
            <span className="title">Level</span>
            <span className="value">{@props.score.level}</span>
          </div>
          <HighScoreList high_scores={@props.high_scores.local_scores} title="My High Scores" class_name="small-list" />
          <button onClick={@onNewGameClick}>New Game</button>
        </div>
      </div>