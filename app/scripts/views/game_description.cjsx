define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  GameDescription = React.createClass
      
    render: ->
      <div className="wordy-desc">
        <div className="main-c2a">Open 3 Doors To Level Up</div>
        <ul className="more-info">
          <li>However, 3 <span className="strike" /> and you lose a life.</li>
          <li>Once you're out of lives it's game over!</li>
        </ul>
      </div>