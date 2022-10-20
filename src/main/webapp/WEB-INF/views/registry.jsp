<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>用户注册</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <style>
            body {
                background-repeat: no-repeat;
                background-size: cover;
                min-height: 100vh;
            }

            body:before {
                content: "";
                background-color: rgba(0, 0, 0, .2);
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
            }

            .login-wrapper {
                max-width: 420px;
                padding: 20px;
                margin: 0 auto;
                position: relative;
                box-sizing: border-box;
                z-index: 2;
            }

            .login-wrapper > .layui-form {
                padding: 25px 30px;
                background-color: #fff;
                box-shadow: 0 3px 6px -1px rgba(0, 0, 0, 0.19);
                box-sizing: border-box;
                border-radius: 4px;
            }

            .login-wrapper > .layui-form > h2 {
                color: #333;
                font-size: 18px;
                text-align: center;
                margin-bottom: 25px;
            }

            .login-wrapper > .layui-form > .layui-form-item {
                margin-bottom: 25px;
                position: relative;
            }

            .login-wrapper > .layui-form > .layui-form-item:last-child {
                margin-bottom: 0;
            }

            .login-wrapper > .layui-form > .layui-form-item > .layui-input {
                height: 46px;
                line-height: 1;
                border-radius: 2px !important;
            }

            .login-wrapper .layui-input-icon-group > .layui-input {
                padding-left: 46px;
            }

            .login-wrapper .layui-input-icon-group > .layui-icon {
                width: 46px;
                height: 46px;
                line-height: 46px;
                font-size: 20px;
                color: #909399;
                position: absolute;
                left: 0;
                top: 0;
                text-align: center;
            }

            .login-wrapper > .layui-form > .layui-form-item.login-captcha-group {
                padding-right: 135px;
            }

            .login-wrapper > .layui-form > .layui-form-item.login-captcha-group > .login-captcha {
                height: 46px;
                width: 120px;
                cursor: pointer;
                box-sizing: border-box;
                border: 1px solid #e6e6e6;
                border-radius: 2px !important;
                position: absolute;
                right: 0;
                top: 0;
            }

            .login-wrapper > .layui-form > .layui-form-item > .layui-form-checkbox {
                margin: 0 !important;
                padding-left: 25px;
            }

            .login-wrapper > .layui-form > .layui-form-item > .layui-form-checkbox > .layui-icon {
                width: 15px !important;
                height: 15px !important;
            }

            .login-wrapper > .layui-form .layui-btn-fluid {
                height: 48px;
                line-height: 48px;
                font-size: 16px;
                border-radius: 2px !important;
            }

            .login-wrapper > .layui-form > .layui-form-item.login-oauth-group > a > .layui-icon {
                font-size: 26px;
            }

            .login-copyright {
                color: #eee;
                padding-bottom: 20px;
                text-align: center;
                position: relative;
                z-index: 1;
            }

            @media screen and (min-height: 550px) {
                .login-wrapper {
                    margin: -250px auto 0;
                    position: absolute;
                    top: 50%;
                    left: 0;
                    right: 0;
                    width: 100%;
                }

                .login-copyright {
                    position: absolute;
                    bottom: 0;
                    right: 0;
                    left: 0;
                }
            }

            .layui-btn {
                background-color: #5FB878;
                border-color: #5FB878;
            }

            .layui-link {
                color: #5FB878 !important;
            }
        </style>
        <style>
            .registry-form {
                padding: 25px 30px;
                background-color: #fff;
                box-shadow: 0 3px 6px -1px rgb(0 0 0 / 19%);
                box-sizing: border-box;
                border-radius: 4px;
                /*position: absolute;*/
                /*left: 50%;*/
                /*top: 50%;*/
                /*transform: translate(-50%, -50%);*/
            }
        </style>
    </head>
    <body>
        <div id="app">
            <el-container style="height: 100%">
                <el-header></el-header>
                <el-main>
                    <el-row type="flex" justify="center">
                        <el-col :span="7">
                            <div class="registry-form">
                                <el-row type="flex" justify="center">
                                    <h2 style="padding-bottom: 20px">实验管理系统 - 用户注册</h2>
                                </el-row>
                                <el-form label-position="left" :rules="rules"
                                         ref="ruleForm" :model="ruleForm" label-width="80px">
                                    <el-form-item prop="name" label="用户名">
                                        <el-input v-model="ruleForm.name"></el-input>
                                    </el-form-item>
                                    <el-form-item label="密码" prop="pass">
                                        <el-input type="password" v-model="ruleForm.pass" autocomplete="off"></el-input>
                                    </el-form-item>
                                    <el-form-item label="确认密码" prop="checkPass">
                                        <el-input type="password" v-model="ruleForm.checkPass"
                                                  autocomplete="off"></el-input>
                                    </el-form-item>
                                    <el-form-item label="出生年月" prop="birth">
                                        <el-date-picker
                                                style="width: 100%"
                                                v-model="ruleForm.birth"
                                                type="month"
                                                placeholder="选择出生年月">
                                        </el-date-picker>
                                    </el-form-item>
                                    <el-form-item label="电话" prop="tel">
                                        <el-input placeholder="请输入电话" v-model="ruleForm.tel"></el-input>
                                    </el-form-item>
                                    <el-form-item label="微信号" prop="weichat">
                                        <el-input placeholder="请输入微信号" v-model="ruleForm.weichat"></el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-row>
                                            <el-button style="width: 100%" type="success" @click.stop="onSubmit">
                                                注册
                                            </el-button>
                                        </el-row>
                                        <el-row>
                                            <div style="display: flex;flex-direction: row-reverse">
                                                <a @click.stop="toLogin">去登录</a>
                                            </div>
                                        </el-row>
                                    </el-form-item>
                                </el-form>
                            </div>
                        </el-col>
                    </el-row>
                </el-main>
                <el-footer>
                    <el-row type="flex" justify="center">
                        <div>
                            copyright © 2020 easyweb.vip all rights reserved.
                        </div>
                    </el-row>
                </el-footer>
            </el-container>
        </div>
        <!-- js部分 -->
        <script>
            layui.use(['layer', 'form'], function () {
                var c = layui.jquery
                var index = layui.index
                var vue = new Vue({
                    el: '#app',
                    data() {
                        var validatePass = (rule, value, callback) => {
                            if (value === '') {
                                callback(new Error('请输入密码'));
                            } else {
                                if (value.length < 6) {
                                    callback(new Error('密码长度必须大于6'));
                                }
                                if (this.ruleForm.checkPass !== '') {
                                    this.$refs.ruleForm.validateField('checkPass');
                                }
                                callback();
                            }
                        }
                        var validatePass2 = (rule, value, callback) => {
                            if (value === '') {
                                callback(new Error('请再次输入密码'));
                            } else if (value !== this.ruleForm.pass) {
                                callback(new Error('两次输入密码不一致!'));
                            } else {
                                callback();
                            }
                        }
                        return {
                            ruleForm: {
                                name: '',
                                pass: '',
                                checkPass: '',
                                tel: '',
                                weichat: '',
                                birth: ''
                            },
                            rules: {
                                name: [
                                    {required: true, message: '请输入用户名', trigger: 'blur'}
                                ],
                                pass: [
                                    {required: true, validator: validatePass, trigger: 'blur'}
                                ],
                                checkPass: [
                                    {required: true, validator: validatePass2, trigger: 'blur'}
                                ],
                                tel: [
                                    {required: true, message: '请输入电话', trigger: 'blur'}
                                ],
                                weichat: [
                                    {required: true, message: '请输入微信号', trigger: 'blur'}
                                ],
                                birth: [
                                    {required: true, message: '请选择出生年月', trigger: 'change'}
                                ]
                            }
                        }
                    }, created() {
                    }, methods: {
                        onSubmit() {
                            let _that = this
                            console.log('this.ruleForm', this.ruleForm)
                            this.$refs.ruleForm.validate((valid) => {
                                if (valid) {
                                    let url = '/system/registry/registry'
                                    let data = {
                                        username: this.ruleForm.name,
                                        password: this.ruleForm.pass,
                                        tel: this.ruleForm.tel,
                                        weichat: this.ruleForm.weichat,
                                        birth: new Date(this.ruleForm.birth).Format('yyyy-MM')
                                    }
                                    console.log('data,:', data)
                                    c.ajax({
                                        type: 'POST',
                                        url: url,
                                        contentType: "application/json; charset=utf-8",
                                        data: JSON.stringify(data),
                                        success: (res) => {
                                            // console.log('res:', res)
                                            if (res.code === 0) {
                                                _that.$message({
                                                    message: res.msg,
                                                    type: 'success',
                                                    onClose: () => {
                                                        _that.toLogin()
                                                    }
                                                })
                                            }
                                        }
                                    })
                                } else {
                                    return false
                                }
                            })
                        },
                        toLogin() {
                            window.location.href = '/login'
                        }
                    }
                })
            });
        </script>
    </body>
</html>
