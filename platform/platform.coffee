@Meassures = new Meteor.Collection("meassures")

Meteor.methods
  'add_measurement': (measurement) ->
    measurement.timestamp = new Date()
    Meassures.insert measurement
    console.log measurement

