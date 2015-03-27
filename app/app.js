var express = require('express');
//var https = require('https');
var http = require('http');
var fs = require('fs');

// var options = {
//   key: fs.readFileSync('/vagrant/setup/vagrant/root/certs/yourkey.pem'),
//   cert: fs.readFileSync('/vagrant/setup/vagrant/root/certs/yourcert.pem')
// };

// Create a service (the app object is just a callback).
var app = express();
app.get('/', function(request, response) {
  response.send('My awesome node app!');
});


// Create an HTTP service.
var httpServer = http.createServer(app).listen(3000);
// Create an HTTPS service identical to the HTTP service.
// var httpsServer = https.createServer(options, app).listen(3001);

httpServer.on('listening', function() {
   console.log("Sweet! All up and running. Listening HTTP requests on 3000"); 
});


// httpsServer.on('listening', function() {
//    console.log("Sweet! All up and running. Listening HTTPS requests on 3000"); 
// });