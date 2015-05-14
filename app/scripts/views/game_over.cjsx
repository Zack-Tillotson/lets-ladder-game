define ['namespace', 'react', 'views/high_score_list'], (zt, React, HighScoreList) ->

  GameOverView = React.createClass

    onNewGameClick: (e) ->
      @props.doAction 'new_game'

    onNameChange: (e) ->
      @props.doAction 'update_high_score_name', e.target.value

    render: ->
      overlay_active_class = if @props.is_open then "active" else "inactive"
      <div className="game-over-overlay #{overlay_active_class}">
        <div className="game-over-view" onClick={@onClick}>
          <div className="title">Game Over!</div>
          <label className="name-label" for="name-input">Name: </label>
          <input name="name-input" id="name-input" className="game-name" onChange={@onNameChange} />
          <div className="game-score">${@props.score.money}</div>
          <div className="game-level">
            <span className="level-title">Level</span>
            <span className="value">{@props.score.level}</span>
          </div>
          <HighScoreList high_scores={@props.high_scores.local_scores} title="My High Scores" class_name="main-list" />
          <div class="new-game-button" onClick={@onNewGameClick}>New Game</div>
        </div>
      </div>