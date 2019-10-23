<template>
  <div class="ba  bg-purple-dark">
    <div align="center"> <img src="./header/Logo.png" class="logo"></div>
    <el-form label-position="left" :module="params" label-width="0px" class="login-container">

      <h3 class="title">便利店数据管理系统注册</h3>

      <el-form-item>
        <el-input type="text" v-model="params.ID" auto-complete="off" placeholder="账号"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="text" v-model="params.name" auto-complete="off" placeholder="真实姓名"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="password" v-model="params.password" auto-complete="off" placeholder="密码"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="password" v-model= "checkpassword" auto-complete="off" placeholder="核对密码"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="text"  v-model="params.phonenumber" auto-complete="off" placeholder="电话号码"></el-input>
      </el-form-item>

      <el-form-item>
        <el-input type="text" v-model="params.email" auto-complete="off" placeholder="邮箱：email@xx.xx"></el-input>
      </el-form-item>

      <el-form-item>
        <el-date-picker
          v-model="params.birthday"
          type="date"
          placeholder="生日">
        </el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-input
          placeholder="请输入验证码"
          v-model="input"
          clearable>
        </el-input>

      <div class="code" @click="refreshCode">
        <SIdentify :identifyCode="identifyCode"></SIdentify>
      </div>
      </el-form-item>

      <el-form-item style="width:100%;">
          <el-button class="submit"  @click="submit()" style="width:100%;">立即登录</el-button>
        <!--<el-button @click.native.prevent="handleReset2">重置</el-button>-->
      </el-form-item>
      <el-form-item style="width:100%;">
          <li><el-button style="width:100%;" class="reg" @click="reg()">注册 稍后登陆</el-button></li>
        <!--<el-button @click.native.prevent="handleReset2">重置</el-button>-->
      </el-form-item>
    </el-form>
    <p align="center" class="buttom" >李伟 1711350 计算机科学与技术专业</p >
    <p align="center" class="buttom" >@2019-5-18</p >
  </div>
</template>



<script>
  import SIdentify from './element/identify';   //局部调用引入
  export default {
    name: "register",
    components:{
      SIdentify
  },
    data(){
      return {
        identifyCodes: "1234567890",
        identifyCode: "",
        input :"",
        params:{
          ID:'1711343',
          name:'王二',
          phonenumber:"17822016262",
          email:'123@163.com',
          birthday:'2015-3-10',
          password:'123456',
        },
        checkpassword:'123456',
      };
    },
    mounted() {
      this.identifyCode = "";
      this.makeCode(this.identifyCodes, 4);
    },
    methods: {
      submit: function () {
        if (this.params.name === '' || this.params.phonenumber === '' || this.params.email === '' || this.params.birthday === '' || this.params.password === '' || this.checkpassword === '') {
          this.$message("输入信息不能是空！！！");
        } else if (this.params.password === this.checkpassword) {
          if (this.identifyCode === this.input) {
            var message = this.$message;
            var router = this.$router;
            var temp= this;

            this.$http.post('/register', {
              user: this.params,
            })
              .then(function (res) {
                if (res.data !== '错误！') {
                  message.success('注册成功，欢迎登陆视界数据管理系统！！！');
                  router.push({path: '/index'});
                } else {
                  message.error('注册失败！！！');
                  temp.refreshCode();
                }
                console.log(res);
              })
              .catch(function (error) {
                message.error('注册失败！！！');
                console.log(error);
                return 1;
              })

          } else {
            this.$message('验证码输入错误！！！');
            this.input = '';
            this.refreshCode();
          }
        } else {
          this.$message('密码不匹配！！！');
          this.params.password = '';
          this.checkpassword = '';
          this.input = '';
          this.refreshCode();
        }
      },
      reg(){
        if(this.params.name===''|| this.params.phonenumber===''||this.params.email===''||this.params.birthday===''||this.params.password===''||this.checkpassword==='')
        {
          this.$message("输入信息不能是空！！！");
        }
        else if(this.params.password===this.checkpassword)
        {
          if (this.identifyCode===this.input)
          {
            var message = this.$message;
            var router = this.$router;
            var temp= this;

            this.$http.post('/register', {
              user: this.params,
            })
              .then(function (res) {
                if (res.data !== '错误！') {
                  message.success('注册成功，请尽快登陆视界数据管理系统哟！！！');
                  router.push({path: '/login'});
                } else {
                  message.error('注册失败！！！');
                  temp.refreshCode();
                }
                console.log(res);
              })
              .catch(function (error) {
                message.error('注册失败！！！');
                console.log(error);
                return 1;
              })
          }
          else
          {
            this.$message('验证码输入错误！！！');
            this.input='';
            this.refreshCode();
          }
        }
        else{
          this.$message('密码不匹配！！！');
          this.params.password='';
          this.checkpassword='';
          this.input='';
          this.refreshCode();
        }
      },

      randomNum(min, max) {
        return Math.floor(Math.random() * (max - min) + min);
      },
      refreshCode() {
        this.identifyCode = "";
        this.makeCode(this.identifyCodes, 4);
      },
      makeCode(o, l) {
        for (let i = 0; i < l; i++) {
          this.identifyCode += this.identifyCodes[
            this.randomNum(0, this.identifyCodes.length)
            ];
        }
        console.log(this.identifyCode);
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

  .buttom{
    padding : 10px 0px 10px 0px;
  }

  .code {
    margin: 20px 0 0 0 ;
    width: 112px;
    height: 32px;
    border: 1px solid #cac6c6;
    align:left;
  }
</style>

