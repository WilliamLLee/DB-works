var mssql=require('mssql');
var db={};
const config={
    user:'sa',
    password:'lio6218@163.com',
    server:'localhost',
    database:'CCStore',
    // requestTimeout: 3000,
    // connectionTimeout:3000,
    pool: {
        min: 0,
        max: 1000,
        idleTimeoutMillis: 3000
    }
};

db.sql = function (sql, callBack) {
    var connection = new mssql.ConnectionPool(config, function (err) {
        if (err) {
            //console.log(err);
            callback(err,null);
            return err;
        }
        var ps = new mssql.PreparedStatement(connection);
        ps.prepare(sql, function (err) {
            if (err){
               // console.log(err);
                callback(err);
                return err;
            }
            ps.execute('', function (err1, result) {
                if (err){
                    //console.log(err);
                    return err;
                }
                ps.unprepare(function (err) {
                    if (err){
                        //console.log(err);
                        callback(err);
                        return err;
                    }
                    callBack(err1, result);
                });
            })
        });
    });
};

module.exports = db;




