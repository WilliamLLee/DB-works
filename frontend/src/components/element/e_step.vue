<template>
  <el-tabs v-model="activeName" type="card" @tab-click="handleClick">

    <el-tab-pane label="员工管理" name="first">
      <el-row>
        <el-col :span="24">
          <!--表单-->
          <el-form :inline="true" :model="params" class="demo-form-inline">
            <el-form-item label="姓名">
              <el-input v-model="params.userNickName" placeholder="姓名"></el-input>
            </el-form-item>
            <el-form-item label="病历号">
              <el-input v-model="params.userMedicalRecord" align="right" placeholder="病历号">
              </el-input>
            </el-form-item>
            <el-form-item label="适配时间">
              <el-date-picker
                v-model="params.Date"
                align="right"
                type="date"
                placeholder="适配时间">
              </el-date-picker>
            </el-form-item>
            <el-button type="primary" @click="searchUser">查询</el-button>
            <!--          <a href="javascript:;" id="download" style="float: right;color: #169bd5;font-size: 14px;padding-top: 7px" @click="download()" download="download.csv">导出数据</a>-->
          </el-form>
          <!--分栏-->
          <el-row type="flex" class="row" >
            <el-col >
              <el-card class="box-card-1" >
                <div slot="header" class="clearfix">
                  <span>员工信息添加</span>
                  <el-button style="float: right; padding: 3px 5px" type="text" @click="okvisible()">推荐配镜</el-button>
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
                  <span>员工数据:</span><el-tag v-show="visibed" color="#ADD0F7">露晰得角膜塑形镜(散光片)</el-tag>
                </div>
                <el-table
                  :data="tableData"
                  height="500"
                  border
                  style="width: 100%">
                  <el-table-column type="selection" fixed="left">
                  </el-table-column>
                  <el-table-column
                    prop="commodity_id"
                    label="商品编号"
                    width="200"
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
                    prop="cmd_leftnum"
                    label="剩余数量"
                    width="120">
                  </el-table-column>

                  <el-table-column label="操作" fixed="right">
                    <template scope="scope">
                      <el-button type="primary" size="small" @click="userDetail(scope.$index, scope.row)">查看</el-button>
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
    </el-tab-pane>

    <el-tab-pane label="会员管理" name="second">
      <el-row>
        <el-col :span="24">
          <!--表单-->
          <el-form :inline="true" :model="params" class="demo-form-inline">
            <el-form-item label="姓名">
              <el-input v-model="params.userNickName" placeholder="姓名"></el-input>
            </el-form-item>
            <el-form-item label="病历号">
              <el-input v-model="params.userMedicalRecord" align="right" placeholder="病历号">
              </el-input>
            </el-form-item>
            <el-form-item label="适配时间">
              <el-date-picker
                v-model="params.Date"
                align="right"
                type="date"
                placeholder="适配时间">
              </el-date-picker>
            </el-form-item>
            <el-button type="primary" @click="searchUser">查询</el-button>
            <!--          <a href="javascript:;" id="download" style="float: right;color: #169bd5;font-size: 14px;padding-top: 7px" @click="download()" download="download.csv">导出数据</a>-->
          </el-form>
          <!--分栏-->
          <el-row type="flex" class="row" >
            <el-col >
              <el-card class="box-card-1" >
                <div slot="header" class="clearfix">
                  <span>添加会员</span>
                  <el-button style="float: right; padding: 3px 5px" type="text" @click="okvisible()">推荐配镜</el-button>
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
                  <span>会员数据:</span><el-tag v-show="visibed" color="#ADD0F7">露晰得角膜塑形镜(散光片)</el-tag>
                </div>
                <el-table
                  :data="tableData"
                  height="500"
                  border
                  style="width: 100%">
                  <el-table-column type="selection" fixed="left">
                  </el-table-column>
                  <el-table-column
                    prop="commodity_id"
                    label="商品编号"
                    width="200"
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
                    prop="cmd_leftnum"
                    label="剩余数量"
                    width="120">
                  </el-table-column>

                  <el-table-column label="操作" fixed="right">
                    <template scope="scope">
                      <el-button type="primary" size="small" @click="userDetail(scope.$index, scope.row)">查看</el-button>
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
    </el-tab-pane>

    <el-tab-pane label="系统权限管理" name="third">角色管理</el-tab-pane>
  </el-tabs>
</template>

<script>
export default {
  data() {
    return {
      activeName:'first',
      visibed:false,
      params: {
        userNickName: '',
        userMedicalRecord: '',
        Date: '',
        userKf:'',
        usercyl:'',
        userEs:'',
        userEm:'',
        userdiam:'',
        pageNum: 1,
        pageSize: 2
      },
      adder:{},
      active: 0
    };
  },
  methods: {
    next() {
      if (this.active++ > 3) this.active = 0;
    },
    searchUser:function(){

      this.active=3;
},
  }
};
</script>
<style>
  .h1{
    font-size: 24px;
    margin: 10px 0 30px;
  }
.demo-block {
  border: 1px solid #eaeefb;
  border-radius: 4px;
  transition: .2s;
  margin-bottom: 24px;
  padding: 24px;
}
  .br{
    color: rgb(72, 160, 248);
    cursor: pointer;
  }
  .bt{
    width: 140px;
  }
</style>
