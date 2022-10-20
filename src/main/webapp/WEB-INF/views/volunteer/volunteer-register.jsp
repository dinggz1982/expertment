<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>广州大学教育学院自闭症研究项目志愿者注册</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <style>
            .el-radio__label {
                font-size: 20px;
            }

            .el-checkbox__label {
                font-size: 20px;
            }

            .main-row {
                border-radius: 2px;
                background-color: #fff;
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 5%);
                padding: 10px 15px;
            }

            .el-form-item__label {
                font-weight: 700;
                font-size: 1.25em;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22">
                            <el-steps :active="active" finish-status="success" simple
                                      style="margin-top: 20px;">
                                <el-step title="须知"></el-step>
                                <el-step title="注册"></el-step>
                            </el-steps>
                            <el-row style="margin-top: 30px;">
                                <div class="content">
                                    <div v-if="active===0" style="min-height: 680px;">
                                        <div v-html='notice'></div>
                                    </div>
                                    <div v-else>
                                        <el-form ref="form" label-position="top" :rules="rules" :model="form"
                                                 label-width="200px">
                                            <el-form-item label="您为谁注册？" prop="registerType">
                                                <el-radio-group v-model="form.registerType">
                                                    <el-radio label="我的孩子">我的孩子</el-radio>
                                                    <el-radio label="我自己">我自己</el-radio>
                                                </el-radio-group>
                                            </el-form-item>
                                            <el-form-item label="姓名:" prop="name">
                                                <el-input v-model="form.name"></el-input>
                                            </el-form-item>
                                            <el-form-item label="出生年月日:" prop="birth">
                                                <%--                                    <el-input v-model="form.birth"></el-input>--%>
                                                <el-date-picker v-model="form.birth" type="date"
                                                                value-format="yyyy-MM-dd" format="yyyy-MM-dd"
                                                                placeholder="请选择出生年月日">
                                                </el-date-picker>
                                            </el-form-item>
                                            <el-form-item label="性别:" prop="sex">
                                                <el-radio-group v-model="form.sex">
                                                    <el-radio label="男">男</el-radio>
                                                    <el-radio label="女">女</el-radio>
                                                </el-radio-group>
                                            </el-form-item>
                                            <el-form-item label="民族:" prop="nationality">
                                                <el-input v-model="form.nationality"></el-input>
                                            </el-form-item>
                                            <el-form-item label="使用语言:" prop="language">
                                                <el-checkbox-group v-model="form.language">
                                                    <el-checkbox label="汉语">汉语</el-checkbox>
                                                    <el-checkbox label="普通话 ">普通话</el-checkbox>
                                                    <el-checkbox label="粤语">粤语</el-checkbox>
                                                    <el-checkbox label="英语">英语</el-checkbox>
                                                    <el-checkbox :label="form.languageOther"> 其他
                                                        <el-input v-model="form.languageOther"></el-input>
                                                    </el-checkbox>
                                                </el-checkbox-group>
                                            </el-form-item>
                                            <el-form-item label="参与者的诊断信息:" prop="info">
                                                <el-checkbox-group v-model="form.info">
                                                    <el-row v-for="(item,index) in diagnosisTypeList" :key="index">
                                                        <el-checkbox :label="item.code+''">{{item.desc}}</el-checkbox>
                                                    </el-row>
                                                    <el-row>
                                                        <el-checkbox label="-1">
                                                            其他
                                                            <el-input v-model="form.infoOther"></el-input>
                                                        </el-checkbox>
                                                    </el-row>
                                                </el-checkbox-group>
                                            </el-form-item>
                                            <el-form-item label="Email:" prop="email">
                                                <el-input v-model="form.email"></el-input>
                                            </el-form-item>
                                            <el-form-item label="手机号码:" prop="mobile">
                                                <el-input maxlength="11" minlength="11"
                                                          v-model="form.mobile"></el-input>
                                            </el-form-item>
                                            <el-form-item label="微信:" prop="wechat">
                                                <el-input v-model="form.wechat"></el-input>
                                            </el-form-item>
                                            <el-form-item prop="isAgree">
                                                <el-checkbox @change="isAgreeChange" v-model="form.isAgree" label="1">
                                                    我同意将我/我孩子的信息添加到此数据库中，并同意广州大学教育学院就参与研究项目与我联系。
                                                </el-checkbox>
                                            </el-form-item>
                                            <el-form-item>
                                                <el-row style="display: flex;justify-content: flex-end;align-items: center">
                                                    <el-button type="primary" @click="submit">提交注册</el-button>
                                                </el-row>
                                            </el-form-item>
                                        </el-form>
                                    </div>
                                </div>
                            </el-row>
                            <el-row v-if="active===0"
                                    style="margin-top: 10px;display: flex;justify-content: flex-end;align-items: center">
                                <el-button type="primary" @click="next">下一步</el-button>
                            </el-row>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var vue = new Vue({
                    el: '#app',
                    data() {
                        var checkPhone = (rule, value, callback) => {
                            const phoneReg = /^1[3|4|5|7|8][0-9]{9}$/
                            if (!value) {
                                return callback(new Error('手机号码不能为空'))
                            }
                            setTimeout(() => {
                                // Number.isInteger是es6验证数字是否为整数的方法,但是我实际用的时候输入的数字总是识别成字符串
                                // 所以我就在前面加了一个+实现隐式转换
                                if (!Number.isInteger(+value)) {
                                    callback(new Error('请输入数字值'))
                                } else {
                                    if (phoneReg.test(value)) {
                                        callback()
                                    } else {
                                        callback(new Error('手机号码格式不正确'))
                                    }
                                }
                            }, 100)
                        }
                        var checkEmail = (rule, value, callback) => {
                            const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/
                            if (!value) {
                                return callback(new Error('邮箱不能为空'))
                            }
                            setTimeout(() => {
                                if (mailReg.test(value)) {
                                    callback()
                                } else {
                                    callback(new Error('请输入正确的邮箱格式'))
                                }
                            }, 100)
                        }
                        return {
                            active: 0,
                            checkedLanguage: false,
                            form: {
                                registerType: '',
                                info: [],
                                language: [],
                                sex: '',
                                languageOther: '',
                                infoOther: '',
                                mobile: '',
                                email: '',
                            }, rules: {
                                registerType: [{required: true, message: '请选择为谁注册', trigger: 'change'}],
                                name: [{required: true, message: '请输入姓名', trigger: 'blur'}],
                                birth: [{required: true, message: '请输入出生年月日', trigger: 'blur'}],
                                sex: [{required: true, message: '请选择性别', trigger: 'change'}],
                                isAgree: [{required: true, message: '请同意', trigger: 'change'}],
                                language: [{required: true, message: '请选择语言', trigger: 'change'}],
                                nationality: [{required: true, message: '请填写民族', trigger: 'blur'}],
                                info: [{required: true, message: '请填写参与者诊断信息', trigger: 'change'}],
                                email: [{validator: checkEmail, trigger: 'blur'}],
                                mobile: [{validator: checkPhone, trigger: 'blur'}],
                            },
                            diagnosisTypeList: [],
                            notice: '',
                        }
                    },
                    async created() {
                        await this.getDiagnosisType()
                        await this.getNotice()
                    },
                    methods: {
                        async getNotice() {
                            const url = '/volunteer/notice/getVolunteerNotice'
                            await c.get(url).then(res => {
                                if (res.code === 0) {
                                    this.notice = res.data.value
                                }
                            })
                        },
                        next() {
                            this.active = 1;
                        },
                        isAgreeChange(val) {
                            console.log('isAgreeChange', val)
                            if (val) {
                                this.form.isAgree = val
                            } else {
                                this.form.isAgree = null
                            }
                        },
                        submit() {
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    const url = '/volunteer/register/saveVolunteerRegister'
                                    c.ajax({
                                        type: 'POST',
                                        url: url, dataType: 'json',
                                        contentType: 'application/json;charset=UTF-8',
                                        data: JSON.stringify(this.form),
                                        success: res => {
                                            console.log('submit res', res)
                                            if (res.code === 0) {
                                                this.$message.success('提交成功')
                                                setTimeout(() => {
                                                    top.location = '/index'
                                                }, 2000)
                                            }
                                        },
                                    });
                                } else {
                                    console.log('error submit!!');
                                    return false;
                                }
                            })
                        },
                        async getDiagnosisType() {
                            const url = '/volunteer/register/getDiagnosisType'
                            await c.get(url).then(res => {
                                console.log('res:', res)
                                if (res.code === 0) {
                                    this.diagnosisTypeList = res.data
                                }
                            })
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
