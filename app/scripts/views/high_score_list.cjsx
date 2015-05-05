define [
  'assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  HighScoreListView = React.createClass

    render: ->

      high_score_elements = ((
        <li class="high-score-item">
          <span class="score">{item.score}</span>
          <span class="who">{item.who}</span>
          <span class="date">{item.date}</span>
        </li>
      ) for item in @props.high_scores or {})
        
      <div class="high-score-list">
        <div class="list-title">{@props.title}</div>
        <ol className="high-scores-container">
          {high_score_elements}        
        </ol>
      </div>