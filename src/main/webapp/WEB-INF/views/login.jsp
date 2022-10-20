<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <title>实验管理系统</title>
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
    </head>
    <body>
        <%--        <div id="app"></div>--%>
        <div id="app" class="login-wrapper layui-anim layui-anim-scale layui-hide">
            <form class="layui-form">
                <h2>实验管理系统 - 用户登录</h2>
                <%--                <div class="layui-form-item layui-input-icon-group">--%>
                <%--                    <i class="layui-icon layui-icon-username"></i>--%>
                <%--                    <input class="layui-input" v-model="form.username" placeholder="请输入登录账号"--%>
                <%--                           autocomplete="off"--%>
                <%--                           lay-verType="tips" lay-verify="required" required/>--%>
                <%--                </div>--%>
                <%--                <div class="layui-form-item layui-input-icon-group">--%>
                <%--                    <i class="layui-icon layui-icon-password"></i>--%>
                <%--                    <input class="layui-input" v-model="form.password" placeholder="请输入登录密码"--%>
                <%--                           type="password"--%>
                <%--                           lay-verType="tips" lay-verify="required" required/>--%>
                <%--                </div>--%>

                <el-form :model="form" :rules="rules" ref="ruleForm">
                    <el-form-item prop="username" style="width: 100%">
                        <el-input ref="username" prefix-icon="el-icon-user" @keyup.enter.native="toNext"
                                  placeholder="请输入登录账号" v-model="form.username"></el-input>
                    </el-form-item>
                    <el-form-item prop="password" style="width: 100%">
                        <el-input ref="password" prefix-icon="el-icon-unlock" placeholder="请输入登录密码"
                                  type="password" @keyup.enter.native="loginClick" v-model="form.password"></el-input>
                    </el-form-item>
                </el-form>

                <div class="layui-form-item">
                    <div class="layui-btn layui-btn-fluid" @click.stop="loginClick">登录</div>
                </div>
                <div class="layui-form-item">
                    <div style="display: flex;flex-direction: row-reverse">
                        <a @click="toRegistry">去注册</a>
                    </div>
                </div>
            </form>
        </div>
        <div class="login-copyright">copyright © 2020 easyweb.vip all rights reserved.</div>

        <!-- js部分 -->
        <script>
            layui.use(['layer', 'form'], function () {
                var c = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                c('.login-wrapper').removeClass('layui-hide');

                // $('#registry').click(() => {
                //     window.location.href = '/system/registry/toRegistry'
                // })

                if (self.location !== top.location) {
                    top.location = self.location;
                }

                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            form: {
                                username: '',
                                password: ''
                            },
                            rules: {
                                username: [{required: true, message: '请输入登录账号', trigger: 'blur'}],
                                password: [{required: true, message: '请输入登录密码', trigger: 'blur'}]
                            }
                        }
                    }, mounted() {
                        this.$refs.username.focus()
                    },
                    methods: {
                        toNext() {
                            this.$refs.password.focus()
                        },
                        loginClick() {
                            // // console.log("loginClick")
                            // // console.log('this.form', this.form)
                            // if (this.form.username === '') {
                            //     this.$message.error('用户名不能为空')
                            // }
                            this.$refs.ruleForm.validate((valid) => {
                                if (valid) {
                                    let url = '/login'
                                    let _that = this
                                    c.ajax({
                                        type: 'POST',
                                        url: url,
                                        data: this.form,
                                        success: function (response, status, xhr) {
                                            if (xhr.status === 200) {
                                                //登录成功
                                                top.location = '/system/index'
                                            }
                                        },
                                        error: function (response) {
                                            _that.$message.error(response.responseJSON)
                                        }
                                    });
                                    // c.post(url, this.form, res => {
                                    //     // console.log(res)
                                    // })
                                }
                            })
                        },
                        toRegistry() {
                            window.location.href = '/system/registry/toRegistry'
                        }
                    }
                })

                <%--let msg = `${errMsg}`--%>
                <%--// console.log('msg,', msg)--%>
                <%--if (msg) {--%>
                <%--    layer.msg(msg, {icon: 2})--%>
                <%--}--%>
            });
        </script>
    </body>
</html>
