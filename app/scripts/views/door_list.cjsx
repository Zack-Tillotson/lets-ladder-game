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
      doorElements = @props.doors.map (door, index) =>
        <DoorView doAction={@onClick} 
          index={index} reward={door.reward} is_success={door.is_success} success_odds={door.success_odds} status={door.status}>
        </DoorView>

      <div className="door-list">
        {doorElements}
      </div>