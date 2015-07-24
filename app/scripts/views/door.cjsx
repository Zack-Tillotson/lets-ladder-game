define ['react'], (React) ->

  DoorView = React.createClass

    render: ->

      result_class = switch @props.status
        when "unopened" then ""
        when "check" then "fa-check"
        when "strike" then "fa-times"
      door_class = switch @props.status
        when "unopened" then "closed"
        else "opened"
      result_text = if @props.status is "check" then "$#{@props.reward}" else "\u00a0"
      risk_class = "risk-#{Math.ceil(@props.strike_odds / 10)}"

      <div className="door option-target #{@props.status} #{@props.suggested_class}" 
           onClick={@props.doAction} 
           data-action="open_door" 
           data-index={@props.index}>
        <div className="door-mover #{door_class}">
          <span className="door-seal fa fa-question #{risk_class}"></span>
          <span className="door-left"></span>          
          <span className="door-right"></span>
        </div>
        <span className="result fa #{result_class}"></span>
        <span className="reward">{result_text}</span>
      </div>