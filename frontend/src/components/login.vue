<template>
  <div class="ba  bg-purple-dark">
    <div align="center"> <img src="./header/Logo.png" class="logo"></div>
    <el-form label-position="left"  label-width="0px" class="login-container">

      <h3 class="title">便利店数据管理系统登录</h3>
        
      <el-form-item>
        <el-input v-model="userID" placeholder="账户"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="password" placeholder="请输入密码" v-model="Password" show-password  clearable></el-input>
      </el-form-item>

      <el-checkbox class="remember" v-model="checked">记住密码</el-checkbox>

      <el-form-item style="width:100%;">
        <el-button class="submit" @click="submit()" style="width:100%;">登录</el-button>
        <!--<el-button @click.native.prevent="handleReset2">重置</el-button>-->
      </el-form-item>
      <el-form-item style="width:100%;">
        <router-link to="/register"><li><el-button style="width:100%;" class="reg" >现在注册</el-button></li></router-link>
        <!--<el-button @click.native.prevent="handleReset2">重置</el-button>-->
      </el-form-item>
    </el-form>
    <p align="center" class="buttom1" >李伟 1711350 计算机科学与技术专业</p >
    <p align="center" class="buttom" >@2019-5-18</p >
  </div>
</template>



<script>
  import axios from '../api/axio_config.js'
  export default {
    name:'login',
    data(){
      return {
        userID:'1711350',
        Password:'li123456',
        checked: true
      };
    },
    methods: {
      submit(){
        if(this.Password==='')
        {
          this.$message.error('密码不能为空！！！');
          return;
        }
        var password=this.Password;
        var router=this.$router;
        var message=this.$message;

        axios.post("/login",{
              userID: this.userID,
        })
          .then(function(response){
            //console.log(response.data[0]);
            var data=response.data[0];
            if( password === data.userpassword) {
              message.success(data.username+' 欢迎登陆系统！！！');
              router.push({path: '/index'});
            }
            else
              message.error('账号或密码错误！');
          })
          .catch(function (error){
            message.error('用户不存在！！！');
            console.log(error);
          })
      },
    },
  }
</script>

<style scoped>
  .logo{
    height: 140px;
    width: 140px;
    padding : 30px 0px 30px 0px
  }
  .bg-purple-dark {
    background: rgb(184,203,241);
  }
  .login-container {
    /*box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);*/
    -webkit-border-radius: 5px;
    border-radius: 5px;
    -moz-border-radius: 5px;
    background-clip: padding-box;
    margin: auto;
    width: 350px;
    padding: 35px 35px 15px 35px;
    background: #ffffff;
    border: 1px solid #eaeaea;
    box-shadow: 0 0 25px #cac6c6;
  }
  .title {
    margin: 0px auto 40px auto;
    text-align: center;
    color: #505458;
  }
  .remember {
    margin: 0px 0px 35px 0px;
  }
  .buttom1{
    padding : 100px 0px 10px 0px;
  }
  .buttom{
    padding : 10px 0px 10px 0px;
  }
</style>
