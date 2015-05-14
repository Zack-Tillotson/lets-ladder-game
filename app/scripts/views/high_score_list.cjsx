define ['namespace', 'react', 'moment'], (zt, React, moment) ->

  HighScoreListView = React.createClass

    render: ->

      high_score_elements = ((
        <li className="list-item">
          <span className="name">{item.name}</span>
          <span className="score">${item.score}</span>
          <span className="level">Level {item.level}</span>
          <span className="date">{moment(item.date).format("MM-DD-YY h:mm a")}</span>
        </li>
      ) for item in @props.high_scores or {})
        
      <div className="high-scores-list #{@props.class_name}">
        <div className="list-title">{@props.title}</div>
        <ol className="list-data">
          {high_score_elements}        
        </ol>
      </div>