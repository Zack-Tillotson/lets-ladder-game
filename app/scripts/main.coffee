requirejs [
  '/assets/scripts/namespace.js'
  'react.js'  
  '/assets/scripts/models/open_door_the_game.js'
  '/assets/scripts/views/open_door_the_game.js'
], (zt, React, OpenDoorTheGame, OpenDoorTheGameView) ->

  openDoorTheGame = new zt.OpenDoorTheGame()

  React.render(React.createElement(OpenDoorTheGameView, {model: openDoorTheGame}), document.getElementById('game-container'));