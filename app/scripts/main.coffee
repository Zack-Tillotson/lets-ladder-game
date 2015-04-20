requirejs ['/assets/scripts/namespace.js', '/assets/scripts/models/score_state.js'], ->
  tmp = new zt.ScoreState()
  console.log "ScoreState!", tmp.level, tmp.money, tmp.strikes