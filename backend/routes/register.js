var db=require('./db');
var express = require('express');
var router = express.Router();

/* POST users listing. */
router.post('/', function(req, res, next) {
        // Query
    var user=req.body.user;
    db.sql("insert into Login values('"+user.ID+"','"+user.name+"','"+
        user.password+"','"+user.email+"','"+user.phonenumber+"','"+user.birthday+"')",function(err,recordset){
        console.log(recordset.recordset);
        res.json({list:recordset.recordset})
    });
});

module.exports = router;