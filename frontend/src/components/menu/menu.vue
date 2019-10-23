<template>
	<div id='menu'>
	<el-menu :default-active="$route.path" class="mar-l el-menu-vertical-demo el-col el-col-3" light router>
      <el-menu-item-group title="销售前台">
        <template v-for="(item,index) in blog_item">

          
          <el-menu-item :index="item.path" ><i class="fa" :class="item.class"></i>{{item.title}}</el-menu-item>
        </template>
	  </el-menu-item-group>
	  <el-menu-item-group title="后台管理">
        <template v-for="(item,index) in element_item">
          <el-menu-item :index="item.path" ><i class="fa" :class="item.class"></i>{{item.title}}</el-menu-item>
        </template>
	  </el-menu-item-group>
    </el-menu>
    </div>
</template>
<script>

  export default {
    data() {
      return {
        element_item: [
          {
            title: '库存管理',
            path: '/index/form',
            class: 'fa-search'
          },  {
            title: '人员管理',
            path: '/index/step',
            class: 'fa-step-forward'
          }
        ],

        blog_item: [
          {
            title: '商品销售',
            path: '/index/user',
            class: 'fa-user'
          }, {
            title: '销售业绩',
            path: '/index/article',
            class: 'fa-newspaper-o'
          },
        ]
      }
    }
  }
</script>
<style>
  i.fa {
    vertical-align: baseline;
    margin-right: 10px;
  }
  #menu .el-menu {
    height: 100%;
    background-color: #fff;
    position: fixed;
    float: left;
    border-right: solid 1px #ccc;
    overflow: auto;
  }
</style>
