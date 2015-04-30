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
          index={index} reward={door.reward} is_success={door.is_success} success_odds={door.success_odds} status={door.status}>
        </DoorView>

      <div className="door-list">
        <div className="doors">
          {doorElements}
        </div>
        <div className="status">
          <div class="status-item">Success Count: {@props.door_list.success_count}</div>
          <div class="status-item">Failure Count: {@props.door_list.failure_count}</div>
          <div class="status-item">Unopened Count: {@props.door_list.unopened_count}</div>
        </div>
      </div>