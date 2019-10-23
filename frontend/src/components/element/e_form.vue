<template xmlns:el-col="http://www.w3.org/1999/html">
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


        <!--分栏-->
        <el-row type="flex" class="row" >
          <el-col >
            <el-card class="box-card-1" >
              <div slot="header" class="clearfix">
                <span>库存管理</span>
                 <el-button style="float: right; padding: 3px 5px" type="text" @click="addCommodity()">添加库存</el-button>
                 <el-button style="float: right; padding: 3px 5px" type="text" @click="downloadok()" download="download.csv">导出数据</el-button>
              </div>
              <div >
                <el-form :inline="true" :model="adder" class="demo-form-inline">
                  <el-form-item label="商品编号" label-width="82px">
                    <el-input v-model="adder.cmd_id" placeholder="ID"></el-input>
                  </el-form-item>
                  <el-form-item label="商品名称">
                    <el-input v-model="adder.cmd_name" placeholder="name" ></el-input>
                  </el-form-item>
                  <el-form-item label="生产厂家">
                    <el-input v-model="adder.cmd_manf" placeholder="manufacture" ></el-input>
                  </el-form-item>
                  <el-form-item label="商品标价">
                    <el-input v-model="adder.cmd_saleprice" placeholder="price" ></el-input>
                  </el-form-item>
                  <el-form-item label="进货价格">
                    <el-input v-model="adder.cmd_buyprice" placeholder="prime costs" ></el-input>
                  </el-form-item>
                  <el-form-item label="生产日期" label-width="82px">
                    <el-date-picker
                      v-model="adder.cmd_proDate"
                      type="date"
                      placeholder="选择日期">
                    </el-date-picker>
                  </el-form-item>
                  <el-form-item label="保质期" label-width="82px">
                    <el-date-picker
                      v-model="adder.cmd_shelflife"
                      type="date"
                      placeholder="选择日期">
                    </el-date-picker>
                  </el-form-item>
                  <el-form-item label="添加数量" label-width="82px">
                    <el-input v-model="adder.addnum" placeholder="number"></el-input>
                  </el-form-item>
                </el-form>
              </div>
            </el-card>
          </el-col>

          <el-col >
            <el-card class="box-card-2">
              <div slot="header" class="clear">
                <span>商品库存信息</span>
              </div>
              <el-table
                :data="tableData"
                height="500"
                border
                style="width: 100%">
                <el-table-column type="selection" fixed="left">
                </el-table-column>
                <el-table-column
                  prop="cmd_id"
                  label="商品编号"
                  width="150"
                fixed="left">
                </el-table-column>
                <el-table-column
                  prop="cmd_name"
                  label="商品名称"
                  width="150">
                </el-table-column>
                <el-table-column
                  prop="cmd_manf"
                  label="生产厂家"
                  width="150">
                </el-table-column>
                <el-table-column
                  prop="cmd_saleprice"
                  label="商品标价"
                  width="100">
                </el-table-column>
                <el-table-column
                  prop="cmd_buyprice"
                  label="进货价格"
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
                  prop="cmd_temprature"
                  label="储藏温度"
                  width="100">
                </el-table-column>
                <el-table-column
                  prop="cmd_leftnum"
                  label="剩余数量"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_discount"
                  label="折扣"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_disc_start"
                  label="促销开始"
                  sortable
                  :formatter="dateFormat_disc_start"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_disc_end"
                  label="促销结束"
                  sortable
                  :formatter="dateFormat_disc_end"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_limit"
                  label="限购"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_limit_start"
                  label="限购开始"
                  sortable
                  :formatter="dateFormat_limit_start"
                  width="120">
                </el-table-column>
                <el-table-column
                  prop="cmd_limit_end"
                  label="限购结束"
                  sortable
                  :formatter="dateFormat_limit_end"
                  width="120">
                </el-table-column>

                <el-table-column label="操作" fixed="right" width="140">
                  <template scope="scope">
                    <el-button type="primary" size="small" @click="userDetail(scope.$index, scope.row)">添加</el-button>
                    <el-button type="danger" size="small" @click="deleteUser(scope.$index, scope.row)">删除</el-button>
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
            </el-card>
          </el-col>
        </el-row>
      </el-col>
    </el-row>

<!--    <el-dialog title="修改个人信息" v-model="dialogFormVisible" size="tiny">-->
<!--      <el-form ref="form" :model="form" label-width="80px">-->
<!--        <el-form-item label="姓名">-->
<!--          <el-input v-model="form.userNickName"></el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="地址">-->
<!--          <el-input v-model="form.address"></el-input>-->
<!--        </el-form-item>-->
<!--        <el-form-item label="出生日期">-->
<!--          <el-date-picker type="date" placeholder="选择日期" v-model="form.birthday" style="width: 100%;" ></el-date-picker>-->
<!--        </el-form-item>-->
<!--      </el-form>-->
<!--    </el-dialog>-->
  </section>
</template>

<script>
  export default {
    data () {
      return {
        activeName: '0',
        params: {
          searchname: '娃哈哈矿泉水',
          searchID :'',
          pageNum: 1,
          pageSize: 2
        },
        adder:{},
        tableData: [],
        dialogFormVisible: false,
        editLoading: false,
        form: {
          userName: '',
          address: '',
          birthday: '',
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
      dateFormat_proDate (row, column) {
        var date = row['cmd_proDate'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      dateFormat_shelflife (row, column) {
        var date = row['cmd_shelflife'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      dateFormat_disc_start (row, column) {
        var date = row['cmd_disc_start'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      dateFormat_disc_end (row, column) {
        var date = row['cmd_disc_end'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      dateFormat_limit_end (row, column) {
        var date = row['cmd_limit_end'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      dateFormat_limit_start (row, column) {
        var date = row['cmd_limit_start'];
        if (date === null) {
          return "";
        }
        return this.$dateFormat(date);
      },
      reset () {
        this.params.searchname = '';
        this.params.searchID = '';
        this.searchUser();
      },
      searchUser () {
        this.$http.post('/selectCommodity/getInfoForManagement',{
          name:this.params.searchname,
          id:this.params.searchID,
        }).then((response) => {
          this.tableData = response.data;
          console.log(response.data);
          if(this.tableData.length===0)
          {
            this.$message({
              message:'抱歉，没有找到你要的商品哦！',
              type:'error',
            })
          }
        });
      },
      addCommodity(){
        var logmessage = this.$message;
        var reset=this.reset;
        this.$http.post('/selectCommodity/UpdateCommodity', {
          adder: this.adder
        }).then(function(response){
          console.log(response);
          if(response.data.originalError!==undefined)
          {
              logmessage.error(response.data.originalError.info.message);
              reset();
          }else
          {
            logmessage.success("更新库存成功");
            reset();
          }
        })
      },
      deleteUser (index, row) {
        var mymessage=this.$message;
        this.$http.post('/selectCommodity/DeleteCommodity',{
          commodity:this.tableData[index]
        }).then((response) => {
          this.tableData = response.data;
          console.log(response.data);
          mymessage({
            message: "操作成功！",
            type: 'success'
          });
          this.reset();

        }) .catch(function(err)
        {
          console.log('{err}');
          mymessage({
            message:'抱歉，更新库存失败！',
            type:'error',
          })
        });
      },
      userDetail (index, row) {
        //this.dialogFormVisible = true;
        this.adder= Object.assign({}, row);
        //this.table_index = index;
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
      downloadok:function(){

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
    margin-left: 0;
  }
  .text {
    font-size: 14px;
  }

  .box-card-1 {
    width: 350px;
    height: 650px;
    padding:0 0 0 0;
    box-shadow: #99a9bf;
  }
  .box-card-2 {
    width: 1050px;
    height: 650px;
    padding:0 0 0 0;
    box-shadow: #99a9bf;
  }
  .clear{
    height: 16px;
  }
</style>
