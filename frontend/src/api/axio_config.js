import axios from 'axios'

axios.defaults.baseURL = 'http://localhost:3000';
axios.defaults.headers = {
  'Content-Type': 'application/json;charset=utf-8',
  'Access-Control-Allow-Methods': 'PUT,POST,GET,DELETE,OPTIONS',
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':'Content-Type, Content-Length, Authorization, Accept, X-Requested-With , yourHeaderFeild'
};

axios.interceptors.response.use(function (config) {
  return config;
}, function (error) {
  return Promise.reject(error);
});

export default axios
