const mysql = require('mysql2');
const express = require('express');
const path = require('path');
const bodyParser = require("body-parser");

const encoder = bodyParser.urlencoded();
const app = express();

const frontendPath = path.join(__dirname, '..','..', 'frontend','public');

const connection = mysql.createConnection({
  host: 'localhost',       
  user: 'root',            
  password: '',   
  database: 'test'
});

// Connect to the database
connection.connect(function(error) {
  if (error) {
    throw error
  }
  else
  {
    console.log('fasza')
  }
});

app.get("/",function(req,res)
{
  res.sendFile(path.join(frontendPath,'test.html'));
})

app.post("/",encoder,function(req,res)
{
  var username = req.body.username;
  var password = req.body.password;

  connection.query("SELECT * FROM felhasznalok where Login_name = ? and Password = ?",[username,password],function(error,results,fields){
    if(results.length > 0)
    {
      res.redirect("/test2")
    }
    else
    {
    res.redirect("/");  
    }
    res.end();   
})
})

app.get("/test2",function(req,res){
  res.sendFile(path.join(frontendPath,'test2.html'))
})
app.listen(4500);