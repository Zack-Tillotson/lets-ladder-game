define ['namespace', 'react', 'views/high_score_list'], (zt, React, HighScoreList) ->

  GameOverView = React.createClass

    onClick: (e) ->
      @props.doAction 'toggle', 'game_over_is_open'

    render: ->
      overlay_active_class = if @props.is_open then "active" else "inactive"
      <div className="game-over-view">
        <div className="game-over-overlay #{overlay_active_class}" onClick={@onClick}>
          <div className="title">Game Over!</div>
          <input className="name">Open Minded Person</input>
          <div className="score">${@props.score.money}</div>
          <div className="level">
            <span className="title">Level</span>
            <span className="value">{@props.score.level}</span>
          </div>
          <HighScoreList high_scores={@props.high_scores.local_scores} title="My High Scores" class_name="small-list" />
        </div>
      </div>