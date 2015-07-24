define [
  'namespace'
  'react'
], (zt, React) ->

  AutoPlayerControls = React.createClass

    getDefaultProps: ->
      auto_play_state:
        active: false

    clickHandler: (eventName) ->
      @props.doAction 'auto-player', eventName

    clickToggleHandler: (e) ->
      @props.doAction 'toggle', 'auto_play_is_open'

    render: ->

      status_msg = if @props.auto_play_state.active then "Active" else "Inactive"
      play_btn_class = if not @props.auto_play_state.active then "active" else ""
      pause_btn_class = if @props.auto_play_state.active then "active" else ""
      toggle_class = if @props.is_open then "open" else "closed"
      toggle_up_class = if @props.is_open then "" else "active"
      toggle_down_class = if @props.is_open then "active" else ""

      <div className="auto-player-controls #{toggle_class}">
        <div className="toggler" onClick={@clickToggleHandler}>
          <div className="title">
            Computer Control:
            <div className="status #{pause_btn_class}">{status_msg}</div>
          </div>
          <i className="toggle-icon fa fa-angle-double-up #{toggle_up_class}"></i>
          <i className="toggle-icon fa fa-angle-double-down #{toggle_down_class}"></i>
        </div>
        <div className="more-container">
          <div className="control play-control #{play_btn_class}" onClick={@clickHandler.bind(this, 'play')}>
            <i className="fa fa-play-circle-o"></i>
          </div>
          <div className="control pause-control #{pause_btn_class}" onClick={@clickHandler.bind(this, 'pause')}>
            <i className="fa fa-pause"></i>
          </div>
          <div className="time-left">
            <span className="time-bar" style={{width: @props.time_to_action + "%"}}></span>
          </div>
          <div className="control faster-control active" onClick={@clickHandler.bind(this, 'faster')}>
            <i className="fa fa-plus"></i>
          </div>
          <div className="control slower-control active" onClick={@clickHandler.bind(this, 'slower')}>
            <i className="fa fa-minus"></i>
          </div>
        </div>
      </div>