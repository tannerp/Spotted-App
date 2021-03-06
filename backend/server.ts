import express from 'express';
import { sequelize } from './sequelize';

import { IndexRouter } from './controllers/v0/index.router';

import path from 'path';
import bodyParser from 'body-parser';
import { config } from './config/config';
import { V0MODELS } from './controllers/v0/model.index';

const c = config.dev;

(async () => {
  await sequelize.addModels(V0MODELS);
  await sequelize.sync();

  const app = express();
  const port = process.env.PORT || 8082; // default port to listen
  
  // app.use(express.static('./html'));
  // app.use(express.static('./static/confirm.html'));

  app.use(bodyParser.json());

  //CORS Should be restricted
  app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Authorization");
    next();
  });
  app.use('/api/v0/', IndexRouter)

  // Root URI call
  app.get( "/", async ( req, res ) => {
    res.send( "/api/v0/" );
  } );

  app.use(express.static(path.join(__dirname, '../frontend/web')));

  // Email Registration Link
  app.use('/register', express.static(path.join(__dirname, './static/register')));

  app.get( "/register/:hash", async ( req, res ) => {
    // console.log(req.body);
    res.sendFile(path.join(__dirname, './static/register/confirm.html'));
  } );    


  // Start the Server
  app.listen( port, () => {
      console.log( `server running ` + port );
      console.log( `press CTRL+C to stop server` );
  } );
})();