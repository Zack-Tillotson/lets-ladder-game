define [
  'assets/scripts/namespace.js'
  'react.js'
  'assets/scripts/views/high_score_list.js'
], (zt, React, HighScoreList) ->

  HighScoreDataView = React.createClass

    onClick: (e) ->
      @props.doAction 'toggle', 'high_scores_is_open'

    render: ->
      overlay_active_class = if @props.is_open then "active" else "inactive"
      game_over_class = if @props.is_game_over then "visible" else ""
      <div className="high-scores-data-view" onClick={@onClick}>
        <div className="action-target high-scores-toggle fa fa-star" />
        <div className="high-scores-overlay #{overlay_active_class}">          
          <div className="high-scores-container">
            <div className="game-over-message #{game_over_class}">Game Over!</div>
            <HighScoreList high_scores={@props.high_scores.global_scores} title="World Wide High Scores" class_name="main-list" />
            <HighScoreList high_scores={@props.high_scores.local_scores} title="My High Scores" class_name="small-list" />          
            <HighScoreList high_scores={@props.high_scores.recent_scores} title="High Scores Within 1 Hour" class_name="small-list" />
          </div>
        </div>
      </div>