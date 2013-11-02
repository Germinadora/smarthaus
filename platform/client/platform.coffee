

Template.board.temp = ->
  last_meassure = Meassures.findOne({}, {sort: {timestamp: -1}})
  last_meassure?.temp
