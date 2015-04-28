define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/views/score_state.js'
  '/assets/scripts/views/action_options.js'
], (zt, React, ScoreState) ->

  LetsLadderGame = React.createClass
    getInitialState: ->
      score: {money: 3}
    onChange: (e) ->
      this.setState text: e.target.value
    render: ->
      <div class="lets-ladder-game">
        <header class="about-header">
          <div class="about-help">?</div>
          <div class="about-author">ZT</div>
        </header>
        {#<ScoreState score={this.state.score.money} />}
        {#<ActionOptions />}
        <section class="footer">
        </section>
      </div>