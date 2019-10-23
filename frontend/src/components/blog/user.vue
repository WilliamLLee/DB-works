<template>
  <section>
    <el-row>
      <el-col :span="24">
        <!--表单-->
        <el-form :inline="true" :model="params" class="demo-form-inline">
          <el-form-item label="商品名称">
            <el-input v-model="params.searchname" placeholder="商品名称"></el-input>
          </el-form-item>
          <el-form-item label="商品编号">
            <el-input v-model="params.searchID" placeholder="商品编号"></el-input>
          </el-form-item>
<!--          <el-form-item label="时间下限">-->
<!--            <el-date-picker-->
<!--              v-model="params.userMedicalRecord"-->
<!--              align="right"-->
<!--              type="date"-->
<!--              placeholder="时间下限">-->
<!--            </el-date-picker>-->
<!--          </el-form-item>-->
<!--          <el-form-item label="时间上限">00-->
<!--            <el-date-picker-->
<!--              v-model="params.Date"-->
<!--              align="right"-->
<!--              type="date"-->
<!--              placeholder="时间上限">-->
<!--            </el-date-picker>-->
<!--          </el-form-item>-->
          <el-button type="primary" icon="search" @click="searchUser">查询</el-button>
<!--          <el-button type="primary" icon="delete" @click="deleteAll">批量删除</el-button>-->
          <el-button type="primary" @click="reset">重置</el-button>
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
            prop="Cmd_ID"
            label="商品编号"
            width="200">
          </el-table-column>
          <el-table-column
            prop="cmd_name"
            label="商品名称"
            width="150">
          </el-table-column>
          <el-table-column
            prop="cmd_saleprice"
            label="商品标价"
            width="100">
          </el-table-column>
          <el-table-column
            prop="cmd_proDate"
            label="生产日期"
            sortable
            :formatter="dateFormat_proDate"
            width="120">
          </el-table-column>
          <el-table-column
            prop="cmd_shelflife"
            label="保质期"
            sortable
            :formatter="dateFormat_shelflife"
            width="120">
          </el-table-column>
          <el-table-column
            prop="cmd_leftnum"
            label="剩余数量"
            width="120">
          </el-table-column>
          <el-table-column
            prop="cmd_discount"
            label="促销折扣"
            :formatter="discount"
            width="120">
          </el-table-column>
          <el-table-column
            prop="cmd_limitnum"
            label="限购数量"
            :formatter="limit"
            width="120">
          </el-table-column>
          <el-table-column label="操作"  fixed="right">
            <template scope="scope">
              <el-button type="primary" size="small" @click="userDetail(scope.$index, scope.row)">销售</el-button>
<!--              <el-button type="danger" size="small" @click="deleteUser(scope.$index, scope.row)">删除</el-button>-->
            </template>
          </el-table-column>
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

    <el-dialog title="商品销售页面" v-model="dialogFormVisible" size="tiny">
      <el-form ref="form" :model="form" label-width="80px">
        <el-form-item label="购买数量">
          <el-input v-model="form.salenumber"></el-input>
        </el-form-item>
        <el-form-item label="会员编号">
          <el-input v-model="form.vipid"></el-input>
        </el-form-item>
        <el-form-item >
          <el-button type="primary" size="small" @click="commitsale">确认购买</el-button>
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
        searchname: '娃哈哈矿泉水',
        searchID :'',
        pageNum: 1,
        pageSize: 2
      },
      tableData: [],
      dialogFormVisible: false,
      editLoading: false,
      form: {
        salenumber:'5',
        vipid:'020201905208111',
      },
      total: 0,
      table_index: 999,
    };
  },
  created () {
  },
  methods: {
    dateFormat_proDate (row, column) {
      var date = row['cmd_proDate'];
      if (date === undefined) {
        return "";
      }
      return this.$dateFormat(date);
    },
    dateFormat_shelflife (row, column) {
      var date = row['cmd_shelflife'];
      if (date === undefined) {
        return "";
      }
      return this.$dateFormat(date);
    },
    discount (row, column) {
      var data = row['cmd_discount'];
      if (data === null) {
        return "无折扣";
      }
      return data;
    },
    limit(row, column) {
      var data = row['cmd_limitnum'];
      if (data === null) {
        return "不限购";
      }
      return data;
    },
    searchUser () {
      this.$http.post('/selectCommodity',{
        name:this.params.searchname,
        id:this.params.searchID,
      }).then((response) => {
        this.tableData = response.data;
        console.log(response.data);
       if(this.tableData.length!==0)
       {
        //  this.$message({
        //   message:'查询成功',
        //   type:'success',
        // })
       }
       else
       {
         this.$message({
           message:'抱歉，没有找到你要的商品哦！',
           type:'error',
         })
       }
      });
    },
    reset () {
      this.params.searchname = '';
      this.params.searchID = '';
      this.searchUser();
    },
    userDetail (index, row) {
      this.dialogFormVisible = true;
      //this.form = Object.assign({}, row);
      this.table_index = index;     //将表格指针置位为当前位置
    },
    commitsale(){
      var viplevel=0;
      if(this.form.vipid!=='')
      {
        this.$http.post('/sale/getVipInfo',{
              vipid:this.form.vipid
            }).then((res)=>{
              viplevel=res.data[0].vip_level;
              console.log('会员等级'+viplevel);
      })  .catch(function(error){
              console.log(error);
              message.error('会员编号不存在！！！');
            })
      }
      console.log(this.tableData[this.table_index]);
      var data=this.tableData[this.table_index];

      var VIPprice=0;
      if(data.cmd_discount!==null)
      {
        VIPprice=data.cmd_discount*data.cmd_saleprice*(1-0.05*viplevel);   //不同级别的客户有不同的VIP折扣，0.05折扣为间隔
      }
      else{
        VIPprice=data.cmd_saleprice*(1-0.05*viplevel);
      }

      console.log('价格：'+parseFloat(VIPprice));

      var message=this.$message;
      var formvalues=this.form;
      this.$http.post('/sale/insertSale',{
        vip_id: this.form.vipid,
        cmd_id: data.Cmd_ID,
        sale_num: parseInt(this.form.salenumber),
        sale_price: parseFloat(VIPprice),
      }).then(function(res){
        console.log(res);
        if(res.data.originalError!==undefined)
        {
          message.error(res.data.originalError.info.message);
        }else
        {
          message.success('购买成功！！！\n'+'购买价格（含会员折扣）：'+VIPprice+'\n消费总额：'+VIPprice*formvalues.salenumber);
        }
      });
      this.reset();
      this.dialogFormVisible=false;
    },
    deleteAll () {
      this.$message.error('还没做呢!');
    },
    deleteUser (index, row) {
      this.tableData.splice(index, 1);
      this.$message({
        message: "操作成功！",
        type: 'success'
      });
    },
    download: function() {
      var obj = document.getElementById('download');
      var str = "账户名,昵称,真实姓名,出生日期,电话号码,微信号,qq号,邮箱,省份,城市\n";
      for (var i = 0; i < this.tableData.length; i++) {
        var item = this.tableData[i];
        str += item.userName + ',' + item.userNickname + ',' + item.userTruename + ',' + item.birthday + ',';
        str += item.telphone + ',' + item.wechat + ',' + item.qq + ',';
        str += item.email + ',' + item.province + ',' + item.city;
        str += "\n";
      }
      str = encodeURIComponent(str);
      obj.href = "data:text/csv;charset=utf-8,\ufeff" + str;
      obj.download = "users.csv";
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
