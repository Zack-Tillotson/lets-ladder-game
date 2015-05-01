define [
  '/assets/scripts/namespace.js'
  'react.js'
  '/assets/scripts/views/door.js'
], (zt, React, DoorView) ->

  DoorListView = React.createClass

    onClick: (e) ->
      element = $(e.target).closest('.option-target')
      @props.doAction element.data('action'), element.data('index')

    render: ->
      doorElements = @props.door_list.doors.map (door, index) =>
        <DoorView doAction={@onClick} 
          index={index} reward={door.reward} is_check={door.is_check} strike_odds={door.strike_odds} status={door.status}>
        </DoorView>

      <div className="door-list">
        <div className="doors">
          {doorElements}
        </div>
        <div className="status">
          <div class="status-item">Check Count: {@props.door_list.check_count} (${@props.door_list.exposed_rewards})</div>
          <div class="status-item">Strike Count: {@props.door_list.strike_count}</div>
          <div class="status-item">Unopened Count: {@props.door_list.unopened_count}</div>
        </div>
      </div>