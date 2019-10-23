var db=require('./db');
var express = require('express');
var router = express.Router();
var sql=require('mssql');



/* POST users listing. */
router.post('/', function(req, res, next) {
         console.log(req.body);
         // Query
         var name=req.body.name;
         var id=req.body.id;
         var sql1='select *  from  ViewCommodityinfo';
         var sql2="select *  from  ViewCommodityinfo where cmd_name= '"+name+"'";
        var sql3="select *  from  ViewCommodityinfo where cmd_name= '"+name+"' and cmd_ID='"+id+"'";
        var sql4="select *  from  ViewCommodityinfo where cmd_ID= '"+id+"'";

        var sqlquerry;
        if(name===''&& id==='')
            sqlquerry=sql1;
        else if(name===''&&id!=='')
            sqlquerry=sql4;
        else if(name!==''&&id==='')
            sqlquerry=sql2;
        else
            sqlquerry=sql3;

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



router.post('/getInfoForManagement', function(req, res, next) {
    console.log(req.body);
    // Query
    var name=req.body.name;
    var id=req.body.id;
    var sql1='select *  from  ViewCommodityInfoForManagement';
    var sql2="select *  from  ViewCommodityInfoForManagement where cmd_name= '"+name+"'";
    var sql3="select *  from  ViewCommodityInfoForManagement where cmd_name= '"+name+"' and cmd_ID='"+id+"'";
    var sql4="select *  from  ViewCommodityInfoForManagement where cmd_ID= '"+id+"'";

    var sqlquerry;
    if(name===''&& id==='')
        sqlquerry=sql1;
    else if(name===''&&id!=='')
        sqlquerry=sql4;
    else if(name!==''&&id==='')
        sqlquerry=sql2;
    else
        sqlquerry=sql3;

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


router.post('/UpdateCommodity', function(req, res, next) {
    console.log(req.body);
    // Query
    var adder=req.body.adder;
    var sqlquerry= "exec spUpdateCommodity '"+ adder.cmd_id
        +"', '"+adder.cmd_name+"','"+adder.cmd_manf+"',"+
        adder.cmd_saleprice+","+adder.cmd_buyprice+",'"+adder.cmd_proDate+
        "','"+adder.cmd_shelflife+"',"+adder.addnum;
    console.log(sqlquerry);

    db.sql(sqlquerry,function (err,result) {
        if (err) {
            console.log(err);
            res.send(err);
            return err;
        }
        console.log(result.recordset);
        res.json(result);
    });
});


router.post('/DeleteCommodity', function(req, res, next) {
    console.log(req.body.commodity.cmd_id);
    // Query
    var cmd_id=req.body.commodity.cmd_id;
    console.log(cmd_id);
    var sqlquerry = "begin tran\n" +
        "declare @error int,@cmd_id varchar(40);\n" +
        "set @error=0;\n" +
        "Set @cmd_id='"+cmd_id+"';\n" +
        "begin try\n" +
        "\t--删除前先将Sale中以及Supply表中的数据转存\n" +
        "\tinsert into DeletedSale select Sale_orderID,getdate(), VIP_ID ,Cmd_ID ,Sale_time ,Sale_num ,Sale_price ,Sale_returnTime ,Sale_returnPrice\n" +
        "\tfrom sale where Cmd_ID=@cmd_id;\n" +
        "\tinsert into DeletedSupply select getdate(),Store_ID,Cmd_ID ,Supplier_ID ,Supply_time,Supply_num \n" +
        "\tfrom supply where Cmd_id=@cmd_id;\n" +
        "\t--删除子类中数据\n" +
        "\tdelete from sale where Cmd_id=@cmd_id;\n" +
        "\tdelete from Supply where Cmd_ID=@cmd_id;\n" +
        "\tdelete from DiscountCommodity where DiscountCommodity.Cmd_ID=@cmd_id;\n" +
        "\tdelete from LimitCommodity where LimitCommodity.Cmd_ID=@cmd_id;\n" +
        "\tdelete from freshCommodity where FreshCommodity.Cmd_ID=@cmd_id;\n" +
        "\tdelete from commodity where cmd_id=@cmd_id;\n" +
        "end try\n" +
        "begin catch\n" +
        "\tset @error=@error+1;\n" +
        "end catch\n" +
        "if(@error!=0)\n" +
        "begin\n" +
        "\trollback tran \n" +
        "\tprint @error\n" +
        "end\n" +
        "else\n" +
        "begin\n" +
        "\tcommit tran\n" +
        "end ";

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
module.exports = router;