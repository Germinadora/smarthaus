

Template.board.temp = ->
  last_meassure = Meassurements.findOne({}, {sort: {timestamp: -1}})
  last_meassure?.temp

Template.board.events
  'click #toggle': ->
    console.log "Toggle"
    Meteor.call 'toggle'

data = ->
  temp = []
  measures = Meassurements.find().fetch()
  console.log measures
  if measures.length > 0
    for i in [0..99]
      temp.push({x: i, y: measures[i]?.temp})
  [
    values: temp
    key: 'Temp'
    color: '#ff7f0e'
    ]


Template.temp_graph.rendered = ->
  console.log "Rendered"
  Meteor.autorun ->
    data()
    nv.addGraph ->
      chart = nv.models.lineChart()

      chart.xAxis
        .axisLabel('Time (ms)')
        .tickFormat(d3.format(',r'))

      chart.yAxis
        .axisLabel('Temperature (v)')
        .tickFormat(d3.format('.02f'))

      d3.select('#chart svg')
        .datum(data)
        .transition().duration(500)
        .call(chart);

      nv.utils.windowResize(chart.update)

      chart
