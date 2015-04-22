requirejs ['/assets/scripts/namespace.js', '/assets/scripts/models/lets_ladder_game.js'], ->
  tmp = new zt.LetsLadderGame()
  console.log "LetsLadderGame!", tmp