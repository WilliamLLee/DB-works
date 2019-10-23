var express = require('express');
var router = express.Router();
var db=require('./db');


/* POST users listing. */
router.post('/', function(req, res, next) {
         console.log(req.body.userID);
         // Query
         var userID=req.body.userID;

    db.sql( "select userpassword,username from Login where userID = '"+userID+"'", function (err,result) {
        if (err) {
            console.log(err);
            return;
        }
        console.log(result);
        res.json(result.recordset);
    });

});

module.exports = router;