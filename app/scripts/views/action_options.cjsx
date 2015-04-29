define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  ScoreStateView = React.createClass

    onClick: (e) ->
      @props.doAction $(e.target).closest('.option-target').data('action')

    render: ->
      <div className="action-options">
        <div className="option-target" onClick={@onClick} data-action="reset_doors">
          Reset Level ${@props.action_options.reset_doors.cost}
        </div>
      </div>