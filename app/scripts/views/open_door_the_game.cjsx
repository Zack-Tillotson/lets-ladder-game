define [
  'assets/scripts/namespace.js'
  'react.js'
  'assets/scripts/models/score_state.js'
  'assets/scripts/views/score_state.js'
  'assets/scripts/views/action_options.js'
  'assets/scripts/views/door_list.js'
  'assets/scripts/views/help.js'
  'assets/scripts/views/door_spectrum.js'
  'assets/scripts/views/high_score_data.js'
], (zt, React, ScoreState, ScoreStateView, ActionOptionsView, DoorListView, HelpView, DoorSpectrumView, HighScoreDataView) ->

  OpenDoorTheGame = React.createClass
    render: ->
      <div className="open-door-the-game odtg">
        <ScoreStateView score={@props.model_state.score} />
        <ActionOptionsView doAction={@props.event_handler} action_options={@props.model_state.action_options} />
        <DoorListView doAction={@props.event_handler} door_list={@props.model_state.door_list} />
        <DoorSpectrumView />
        <HelpView initiallyOpen=true />
        <HighScoreDataView model={@props.high_scores} />
      </div>