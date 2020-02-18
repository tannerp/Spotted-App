const mysql = require('mysql');
const bcrypt = require('bcrypt');

var db_cred = {
  host     : '127.0.0.1',
  user     : 'root',
  password : 'Lytdb2020',
  database : 'lytdb_schema'
  //TODO
  //multipleStatements : true,
  //connectionLimit : 100
};

bcrypt.hash(db_cred.password, 10, function(err, hash){
  if(err) console.log(err);
  db_cred.password = hash;
});

var con = mysql.createConnection(db_cred);

//module.exports = connection;

con.connect( function(err) {
  if(err){
    console.log("Unble to connect to MySQL");
    console.log(err);
    process.exit(1);
  }
  console.log("Connection to MySQL successful");
});
