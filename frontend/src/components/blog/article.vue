<template>
  <section>
    <el-row>
      <el-col :span="24">
        <!--表单-->
        <el-form :inline="true" :model="params" class="demo-form-inline">
          <el-form-item label="时间下限">
            <el-date-picker
              v-model="params.lowdate"
              align="right"
              type="date"
              placeholder="时间下限">
            </el-date-picker>
          </el-form-item>
          <el-form-item label="时间上限">
            <el-date-picker
              v-model="params.highdate"
              align="right"
              type="date"
              placeholder="时间上限">
            </el-date-picker>
          </el-form-item>
          <el-button type="primary" @click="searchUser">查询</el-button>
          <el-button type="primary" @click="totalcount">业绩统计</el-button>
          <a href="javascript:;" id="download" style="float: right;color: #169bd5;font-size: 14px;padding-top: 7px" @click="download()" download="download.csv">导出数据</a>
        </el-form>
        
        <!--表格-->
        <el-table
          :data="tableData"
          border
          height="500"
          style="width: 100%">
          <el-table-column type="selection">
          </el-table-column>
          <el-table-column
            prop="sale_orderID"
            label="订单编号"
            width="150">
          </el-table-column>
          <el-table-column
            prop="sale_VIPID"
            label="客户编号"
            width="200">
          </el-table-column>
          <el-table-column
            prop="sale_cmdname"
            label="商品名称"
            width="150">
          </el-table-column>
          <el-table-column
            prop="sale_num"
            label="销售数量"
            width="150">
          </el-table-column>
          <el-table-column
            prop="sale_price"
            label="销售价格"
            width="150">
          </el-table-column>
          <el-table-column
            prop="sale_enterprice"
            label="进货价格"
            width="150">
          </el-table-column>
          <el-table-column
          prop="sale_date"
          label="订单日期"
          sortable
          :formatter="dateFormat"
          width="150">
        </el-table-column>
          <el-table-column
            prop="sale_returntime"
            label="退货日期"
            sortable
            :formatter="dateFormat_1"
            width="150">
          </el-table-column>
          <el-table-column
            prop="sale_returnprice"
            label="退货返价"
            width="150">
          </el-table-column>
<!--          <el-table-column label="操作"  fixed="right">-->
<!--            <template scope="scope">-->
<!--              <el-button type="primary" size="small" @click="userDetail(scope.$index, scope.row)">查看</el-button>-->
<!--              <el-button type="danger" size="small" @click="deleteUser(scope.$index, scope.row)">删除</el-button>-->
<!--            </template>-->
<!--          </el-table-column>-->
        </el-table>
        <div class="block">
          <el-pagination
            @size-change="sizeChange"
            @current-change="currentChange"
            :current-page="params.pageNum"
            :page-sizes="[2, 10, 30, 50, 100, 300, 500]"
            :page-size="params.pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
          </el-pagination>
        </div>
      </el-col>
    </el-row>

    <el-dialog title="便利店业绩统计" v-model="dialogFormVisible" size="tiny">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="销售总额">
          <el-input v-model="form.salecount"></el-input>
        </el-form-item>
        <el-form-item label="商品成本">
          <el-input v-model="form.buytotal"></el-input>
        </el-form-item>
        <el-form-item label="期间毛利">
          <el-input v-model="form.benefit"></el-input>
        </el-form-item>
      </el-form>
    </el-dialog>
  </section>
</template>

<script>
export default {
  data () {
    return {
      params: {
       lowdate:'2019-5-23',
        highdate:"2019-5-29",
        pageNum: 1,
        pageSize: 2
      },
      tableData: [],
      dialogFormVisible: false,
      editLoading: false,
      form: {
        saletotal: '',
        buytotal: '',
        benefit: '',
      },
      total: 500,
      table_index: 999,
    };
  },
  created () {
    // var p = JSON.parse(JSON.stringify(this.params));
    // this.$http.post('/user/getAllUser.do', p).then((response) => {
    //   var pageUser = response.data;
    //   this.total = pageUser.total;
    //   this.params.pageNum = pageUser.pageNum;
    //   this.tableData = pageUser.list;
    // });
  },
  methods: {
    dateFormat (row, column) {
      var date = row['sale_date'];
      if (date === null) {
        return "";
      }
      return this.$dateFormat(date);
    },
    dateFormat_1 (row, column) {
      var date = row['sale_returntime'];
      if (date === null) {
        return "";
      }
      return this.$dateFormat(date);
    },
    searchUser () {
      if(this.params.lowdate===''||this.params.highdate==='')
      {
        this.$message.error('查询输入不能为空！！！');
        return ;
      }
      this.$http.post('/sale/getSaleInfo', {
        lowdate:this.params.lowdate,
        highdate:this.params.highdate
      }).then((response) => {
        this.$message.success("查询成功！！！");
        this.tableData = response.data;
        console.log(this.tableData);
      }).catch((err)=>{
        console.log(err);
        this.$message.error(err);
      })
    },
    deleteUser (index, row) {
      this.tableData.splice(index, 1);
      this.$message({
        message: "操作成功！",
        type: 'success'
      });
    },
    totalcount(){
      this.dialogFormVisible = true;
      var totalsalemoney=0;
      var totalenterprice=0;
      var i=0;
      console.log(this.tableData);
      for(i=0;i< this.tableData.length;i++)
      {
         var row=this.tableData[i];
          //console.log(row);
         totalsalemoney=totalsalemoney+row.sale_num * row.sale_price;
         // console.log("1:"+row.sale_price);
         // console.log("2:"+row.sale_enterprice);
         totalenterprice=totalenterprice+row.sale_enterprice*row.sale_num;
       }
      this.form.buytotal=totalenterprice;
      this.form.salecount=totalsalemoney;
      this.form.benefit=totalsalemoney-totalenterprice;
    },
    userDetail (index, row) {
      // this.dialogFormVisible = true;
      // this.form = Object.assign({}, row);
      // this.table_index = index;
    },
    download: function() {
      var obj = document.getElementById('download');
      var str = "姓名,出生日期,地址\n";
      for (var i = 0; i < this.tableData.length; i++) {
        var item = this.tableData[i];
        str += item.name + ',' + item.date + ',' + item.address;
        str += "\n";
      }
      str = encodeURIComponent(str);
      obj.href = "data:text/csv;charset=utf-8,\ufeff" + str;
      obj.download = "download.csv";
    },
    sizeChange(val) {
      this.params.pageSize = val;
      this.searchUser();
    },
    currentChange(val) {
      this.params.pageNum = val;
      this.searchUser();
    }
  }
};
</script>
<style>
  .el-pagination {
    text-align: center;
    margin-top: 30px;
  }
  .el-message-box__btns .cancel {
    float: right;
    margin-left: 10px;
  }
</style>
