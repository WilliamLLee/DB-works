var db=require('./db');
var express = require('express');
var router = express.Router();

/* POST users listing. */
router.post('/getVipInfo', function(req, res, next) {

    console.log(req.body);
    // Query
    var vipid = req.body.vipid;
    var sqlquerry = "select vip_level from  vip where vip_id= '" + vipid + "'";

    console.log(sqlquerry);

    db.sql(sqlquerry, function (err, recordset) {
        if (err) {
            console.log(err);
            return;
        }
        console.log(recordset.recordset);
        res.json(recordset.recordset);
    });
});

router.post('/insertSale', function(req, res, next) {
        console.log(req.body);
        // Query
        var sqlquerry="insert into sale values('"+req.body.vip_id+"',\n"+
            "'"+req.body.cmd_id+"',"+"(select max(sale_orderid)+1  from sale )\n"+
            ",getdate(),"+req.body.sale_num+","+req.body.sale_price+",null,null)";

        console.log(sqlquerry);

        db.sql(sqlquerry, function (err, result) {
                if (err) {
                    console.log(err);
                    res.send(err);
                    return err;
                }
                console.log(result.recordset);
                res.json(result);
            })
});

router.post('/getSaleInfo', function(req, res, next) {

    console.log(req.body);
    // Query
    var lowdate = req.body.lowdate;
    var highdate=req.body.highdate;
    var sqlquerry = " select * from viewSaleInfo\n"+
    "where datediff(dd,'"+highdate+"',ViewSaleInfo.sale_date)<=0\n"+
    "and datediff(dd,'"+lowdate+"',ViewSaleInfo.sale_date)>=0";

    console.log(sqlquerry);

    db.sql(sqlquerry, function (err, recordset) {
        if (err) {
            console.log(err);
            return;
        }
        console.log(recordset.recordset);
        res.json(recordset.recordset);
    })
});

module.exports = router;