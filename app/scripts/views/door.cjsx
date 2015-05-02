define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  DoorView = React.createClass

    render: ->

      result_class = switch @props.status
        when "unopened" then "fa-question"
        when "check" then "fa-check"
        when "strike" then "fa-times"
      result_text = if @props.status is "check" then "$#{@props.reward}" else ""
      risk_class = "risk-#{Math.ceil(@props.strike_odds / 100 * 5)}"

      <div className="door option-target #{@props.status} #{risk_class}" onClick={@props.doAction} data-action="open_door" data-index={@props.index}>
        <span className="result fa #{result_class}"></span>
        <span className="reward">&nbsp;{result_text}</span>
      </div>