var express = require('express');
var router = express.Router();
var model = require('../models/register');
// var connection  = require('../db_init');
var path = require('path');

router.get('/verify/:email', function(request, response){
  let code = model.generateURLCode(request.params.email)
  console.log("URL", code);

})

module.exports = router;