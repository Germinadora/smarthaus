DDPClient = require("ddp")
SerialPort = require("serialport").SerialPort
JSONStream = require('JSONStream')
es = require('event-stream')

#PORT = 3000
#HOST = "localhost"
PORT = 80
HOST = "smarthaus.meteor.com"
#SERIAL_PORT = '/dev/tty.usbmodem1411'
SERIAL_PORT = '/dev/ttyACM0'
BAUD_RATE = 115200

ddpclient = new DDPClient
  host: HOST
  port: PORT
  auto_reconnect: true
  auto_reconnect_timer: 500
  use_ejson: true

parser = JSONStream.parse() 

serialPort = new SerialPort SERIAL_PORT, 
  baudrate: BAUD_RATE

logger = es.mapSync (data) ->
  console.error(data)
  ddpclient.call "add_measurement", [ data ], (err, result) ->
    #console.log "add_measurement called err: " + err + ", result: " + result
  data

serialPort.on "open", ->
  console.log "Connected to device"
  serialPort.pipe(parser)
  parser.pipe(logger)

ddpclient.connect (error) ->
  if (error)
    console.error "Error connecting with platform"
  console.log "Connected to platform"

ddpclient.on 'message', (msg) -> 
  #console.log "DDP Client: " + msg
  msg = JSON.parse(msg)
  #console.log (msg.msg == "added" or msg.msg == "changed") #and msg.collection == "ports"
  if ((msg.msg == "added" or msg.msg == "changed") and msg.collection == "ports")
    port = ddpclient.collections?.ports?[msg.id]
    console.log "Changed port ", port
