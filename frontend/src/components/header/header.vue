<template>
  <div>
    <header>
      <img src="./Logo.png" class="header-logo">
      <ul class="header-operations">
        <li>
          <span class="header-lang is-active">便利店数据库管理系统</span>
        </li>
        <li > <router-link to="/login" class="lr ">
          登陆
        </router-link>
          <router-link to="/register" class="lr ">
            /注册
          </router-link></li>
      </ul></header>
  </div>
</template>

<script>
  export default {
    props: {

      user: {
      }
    },
    data () {
      return {
      };
    },
  };
</script>
<style>
  header {
    background-color: rgb(165, 208, 251);
    height: 80px;
    position: absolute;
    width: 100%;
    top: 0;
    left: 0;
    padding: 0 20px;
    z-index: 999;
    box-sizing: border-box;
    position: fixed;
  }
  .header-logo {
    height: 80px;
    top: 0;
    left: 0;
    width: 80px;
    display: inline-block;
    vertical-align: middle;
  }
  .lr{
    color: #fff;
    display: inline-block;
    vertical-align: middle;
    padding: 0 0;
    margin: 0 0;
    line-height: 80px;
    cursor: pointer;
  }
  .header-operations {
    display: inline-block;
    float: right;
    padding-right: 30px;
    height: 100%;
  }
  .header-operations li {
    color: #fff;
    display: inline-block;
    vertical-align: middle;
    padding: 0 10px;
    margin: 0 10px;
    line-height: 80px;
    cursor: pointer;
  }
  .header-operations li:first-child{
    cursor: default
  }
  .header-opacity{
    opacity: .7;
  }
  .header-operations:after, header:after {
    display: inline-block;
    content: "";
    height: 100%;
    vertical-align: middle;
  }
</style>
