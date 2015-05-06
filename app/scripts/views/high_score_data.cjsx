define [
  'assets/scripts/namespace.js'
  'react.js'
  'assets/scripts/views/high_score_list.js'
], (zt, React, HighScoreList) ->

  HighScoreDataView = React.createClass

    getInitialState: ->
      is_open: if @props.initiallyOpen? then @props.initiallyOpen or false

    doAction: ->
      @setState is_open: !@state.is_open

    render: ->
      overlay_active_class = if @state.is_open then "active" else "inactive"
      <div className="high-scores-data-view" onClick={@doAction}>
        <div className="action-target high-scores-toggle fa fa-star" />
        <div className="high-scores-overlay #{overlay_active_class}">
          <HighScoreList high_scores={@props.high_scores.global_scores} title="Global Scores" />
          <HighScoreList high_scores={@props.high_scores.local_scores} title="Local Scores" />
          <HighScoreList high_scores={@props.high_scores.recent_scores} title="Recent Scores" />
        </div>
      </div>