define ['namespace', 'react', 'views/door'], (zt, React, DoorView) ->

  DoorListView = React.createClass

    onClick: (e) ->
      element = $(e.target).closest('.option-target')
      @props.doAction element.data('action'), element.data('index')

    render: ->
      doorElements = @props.door_list.doors.map (door, index) =>
        suggested_class = if @props.auto_play_state.active and @props.suggestion is index then "suggested" else ""
        <DoorView doAction={@onClick} 
          index={index} 
          reward={door.reward} 
          is_check={door.is_check} 
          strike_odds={door.strike_odds} 
          status={door.status}
          suggested_class={suggested_class}>
        </DoorView>

      <div className="door-list">
        {doorElements}
      </div>