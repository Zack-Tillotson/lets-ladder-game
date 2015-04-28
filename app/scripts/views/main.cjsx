requirejs [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/views/lets_ladder_game.js'
], (zt, React, LetsLadderGame) ->
  React.render(
    <LetsLadderGame />,
    document.getElementById('game-container')
  );