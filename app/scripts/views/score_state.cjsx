define ['namespace', 'react', 'models/score_state'], (zt, React, ScoreState) ->

  ScoreStateView = React.createClass
    render: ->

      game_over_class = if @props.score.is_game_over then "game_over" else "game_over"
      lives_elements = (<span className="fa heart #{if i > @props.score.lives then 'fa-heart-o lost-heart' else 'fa-heart'}" /> for i in [1..@props.score.starting_lives])
      level_up_class = if @props.recent_state.up then "recent-up" else ""
      level_down_class = if @props.recent_state.down then "recent-down" else ""
      money_up_class = if @props.recent_state.up then "recent-up" else ""
      money_down_class = if @props.recent_state.reset then "recent-down" else ""
          
      <div className="score-state #{game_over_class}">
        <div className="level #{level_up_class} #{level_down_class}">
          <div className="title">Level</div>
          <div className="value">{@props.score.level}</div>
        </div>
        <div className="money #{level_up_class} #{money_up_class} #{money_down_class}">${@props.score.money}</div>
        <div className="lives">{lives_elements}</div>
      </div>