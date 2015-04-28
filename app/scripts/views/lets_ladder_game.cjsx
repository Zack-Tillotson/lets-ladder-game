define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/models/score_state.js'
  '/assets/scripts/views/score_state.js'
  '/assets/scripts/views/action_options.js'
], (zt, React, ScoreState, ScoreStateView, ActionOptionsView) ->

  LetsLadderGame = React.createClass
    getInitialState: ->
      @props.model.getState()

    doAction: (action) ->
      switch action
        when 'open_door' then @props.model.chooseOpenDoor()
        when 'reset_doors' then @props.model.chooseResetDoors()
        when 'go_up_level' then @props.model.chooseGoUpLevel()

      @setState @props.model.getState()
      
    render: ->
      <div className="lets-ladder-game">
        <ScoreStateView 
          level={@state.score.level} 
          money={@state.score.money} 
          strikes={@state.score.strikes} 
          max_strikes={@state.score.max_strikes} >
        </ScoreStateView>
        <ActionOptionsView 
          success_distribution={@state.actions.success_distribution}
          reset_doors_cost={@state.actions.reset_doors_cost}
          go_up_level_cost={@state.actions.go_up_level_cost}
          doAction={@doAction} />
      </div>