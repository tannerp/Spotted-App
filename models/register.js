const db = require('../db');
const shortid = require('shortid');


const host = "WWW.LYT.com/"


exports.generateURLCode = function generateCode(email) {
  const URLCode = host + shortid.generate();

  return URLCode
}