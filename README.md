

== Building and Upload to the Arduino SmartThings 

cd devices/smarthings-arduino
ino build
ino upload

== Starting the platform

cd platform
meteor

== Starting the Serial Reader

cd serialreader
npm install
coffee reader.coffee

== Updating smarthaus.meteor.com

cd platform
meteor deploy smarthaus.meteor.com

== Configuring Serial Reader

To send data locally or to smarthaus.meteor.com

cd serialreader
nano reader.coffee
edit HOST, PORT and SERIAL_PORT

