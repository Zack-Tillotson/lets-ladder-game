define [
  '/assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  DoorView = React.createClass

    render: ->

      style =
        display: 'inline-block'
        width: 'calc(10% - 42px)!important'
        padding: '10px'
        margin: '10px'
        border: 'solid 1px #ccc'

      rewardView = switch @props.status
        when "unopened" then <div>&nbsp;</div>
        when "strike" then <div>X</div>
        when "check" then <div>{@props.reward}</div>

      <div className="door-item option-target" style={style} onClick={@props.doAction} data-action="open_door" data-index={@props.index}>
        <div>Status: {@props.status}</div>
        <div>Strike: {@props.strike_odds}%</div>
        <br/>
        {rewardView}
      </div>