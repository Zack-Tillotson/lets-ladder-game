define [
  'assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  ScoreStateView = React.createClass

    onClick: (e) ->
      @props.doAction $(e.target).closest('.option-target').data('action')

    render: ->

      activeOrNot = if @props.action_options.active then "" else "disabled"

      <div className="action-options">
        <div className="option-open">Choose A Door</div>
        <div className="option-verbage">or</div>
        <div className="option-reset option-target #{activeOrNot}" onClick={@onClick} data-action="reset_doors">
          <span className="name">Reset Doors</span>
          <span className="cost">${@props.action_options.reset_doors.cost}</span>
        </div>
      </div>