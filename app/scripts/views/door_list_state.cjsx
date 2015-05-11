define ['namespace', 'react'], (zt, React) ->

  DoorListState = React.createClass

    render: ->

      check_elements = ((
          result_class = if index < @props.doors.check_count then "filled" else "empty"
          <span className="door-result check fa fa-check #{result_class}" />
        ) for index in [0...@props.doors.max_check_count])

      strike_elements = ((
          result_class = if index < @props.doors.strike_count then "filled" else "empty"
          <span className="door-result strike fa fa-times #{result_class}" />
        ) for index in [0...@props.doors.max_strike_count])
        

      <div className="door-list-checks-strikes">
        {check_elements}
        {strike_elements}
      </div>