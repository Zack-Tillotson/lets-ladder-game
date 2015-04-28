define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  ScoreStateView = React.createClass

    onClick: (e) ->
      @props.doAction $(e.target).closest('.option-target').data('action')

    render: ->
      <div className="action-options">
        <div className="option-target" onClick={@onClick} data-action="open_door">
          Open Door: 
          {@props.success_distribution.target} > [{@props.success_distribution.min}, {@props.success_distribution.max}]
        </div>
        <div className="option-target" onClick={@onClick} data-action="reset_doors">
        Reset Level: 
        {@props.reset_doors_cost}
        </div>
        <div className="option-target" onClick={@onClick} data-action="go_up_level">
        Level Up: 
        {@props.go_up_level_cost}
        </div>
      </div>