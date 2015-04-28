requirejs [
  '/assets/scripts/namespace.js'
  'react.js'  
  '/assets/scripts/models/lets_ladder_game.js'
  '/assets/scripts/views/lets_ladder_game.js'
], (zt, React, LetsLadderGame, LetsLadderGameView) ->

  letsLadderGame = new zt.LetsLadderGame()

  React.render(React.createElement(LetsLadderGameView, {model: letsLadderGame}), document.getElementById('game-container'));