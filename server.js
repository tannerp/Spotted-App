var bodyParser = require('body-parser');
var express = require('express');

var app = express();

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var verifyEmailRoute = require('./routers/verify.js');         // get an instance of the express Router

app.use('/api', verifyEmailRoute);


// app.post('/', function (req, res) {
//    res.send('Hello World');
// })

var server = app.listen(3000, function () {
   console.log("listening at port 3000")
})
