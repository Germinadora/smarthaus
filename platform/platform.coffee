@Meassures = new Meteor.Collection "meassures"
@Ports = new Meteor.Collection "ports"

Meteor.methods
  'add_measurement': (measurement) ->
    measurement.timestamp = new Date()
    Meassures.insert measurement
    console.log measurement
  'toggle': ->
    console.log "Toggle"
    port = Ports.findOne port: 2
    if (!port)
      Ports.insert
        port:2
        state: false
    else
      if port.state == false
        new_state = true
      else
        new_state = false
      Ports.update port._id,
        $set:
          state: new_state
