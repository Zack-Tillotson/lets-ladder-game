define [
  'assets/scripts/namespace.js'
  'react.js'
], (zt, React) ->

  DoorSpectrumView = React.createClass
    
    render: ->
      <div className="door-spectrum">
        <span className="safe-label">Safe, Low Value</span>
        <span className="door-color risk-1" />
        <span className="door-color risk-2" />
        <span className="door-color risk-3" />
        <span className="door-color risk-4" />
        <span className="door-color risk-5" />
        <span className="door-color risk-6" />
        <span className="door-color risk-7" />
        <span className="door-color risk-8" />
        <span className="door-color risk-9" />
        <span className="door-color risk-10" />
        <span className="risky-label">Risky, High Value</span>
      </div>