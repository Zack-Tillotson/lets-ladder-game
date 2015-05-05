define [
  'assets/scripts/namespace.js'
  'react.js'
  'assets/scripts/views/high_score_list.js'
], (zt, React, HighScoreList) ->

  HighScoreDataView = React.createClass

    render: ->
      <div className="high-scores-container">
        <HighScoreList high_scores={@props.high_scores.global_scores} title="Global Scores" />
        <HighScoreList high_scores={@props.high_scores.local_scores} title="Local Scores" />
        <HighScoreList high_scores={@props.high_scores.recent_scores} title="Recent Scores" />
      </div>