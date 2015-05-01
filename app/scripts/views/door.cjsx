define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  DoorView = React.createClass

    render: ->

      reward_view = switch @props.status
        when "unopened" then ""
        when "strike" then ""
        when "check" then "$#{@props.reward}"

      risk_class = "risk_#{Math.ceil(@props.strike_odds / 5)}"

      <div className="door option-target #{@props.status} #{risk_class}" onClick={@props.doAction} data-action="open_door" data-index={@props.index}>
        <span className="reward #{@props.status}">{reward_view}</span>
      </div>