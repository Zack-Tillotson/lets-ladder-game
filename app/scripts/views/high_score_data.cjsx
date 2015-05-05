define [
  'assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  HighScoreView = React.createClass

    render: ->

      <div className="high-scores-container">
        Global high scores: {@props.high_scores.global_scores?[0]?.score} {@props.high_scores.global_scores?[0]?.who}
      </div>