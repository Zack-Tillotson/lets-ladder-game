define [
  'assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  GameDescription = React.createClass
      
    render: ->
      <div className="wordy-desc">
        <div className="main-c2a">Get 3 <span className="fa fa-check check" /> To Level Up</div>
        <ul className="more-info">
          <li>However, 3 <span className="fa fa-times strike" /> and you lose a life.</li>
          <li>How much money can you earn before it's game over?</li>
        </ul>
      </div>