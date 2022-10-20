<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验室借用</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <style>
            .main-row {
                border-radius: 2px;
                background-color: #fff;
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 5%);
                padding: 10px 15px;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="16">
                            <el-row style="padding-top: 20px;padding-bottom: 20px">
                                <el-form ref="form" :rules="rules" :model="form" label-width="150px"
                                         style="margin-top: 20px">
                                    <el-form-item label="实验室" prop="labId">
                                        <el-select v-model="form.labId" placeholder="请选择申请的实验室" style="width: 100%">
                                            <el-option :label="item.name" v-for="(item,index) in labList" :key="index"
                                                       :value="item.id+''"></el-option>
                                        </el-select>
                                    </el-form-item>
                                    <el-form-item label="借用时间段" prop="time">
                                        <el-date-picker style="width: 100%"
                                                        v-model="form.time"
                                                        type="datetimerange"
                                                        range-separator="至"
                                                        start-placeholder="开始时间"
                                                        end-placeholder="结束时间">
                                        </el-date-picker>
                                    </el-form-item>
                                    <el-form-item label="申请理由" prop="reason">
                                        <el-input type="textarea" v-model="form.reason"></el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-row style="padding-top: 20px">
                                            <el-button @click="submit" type="success" style="width: 100%">提交</el-button>
                                        </el-row>
                                    </el-form-item>
                                </el-form>
                            </el-row>
                            <el-dialog
                                    title="实验室占用信息"
                                    :visible.sync="dialogVisible"
                                    width="70%">
                                 <span slot="footer" class="dialog-footer">
                                     <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
                                 </span>
                            </el-dialog>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
        <script>
            layui.use(["layer", "index", "admin"], function () {
                var c = layui.jquery;
                var index = layui.index;
                var k = layui.admin
                // var close = function (url) {
                //     let v
                //     if (id) {
                //         v = '/experiment/updateApply/' + id
                //     } else {
                //         v = '/experiment/add'
                //     }
                //     index.closeTab(v);
                // }

                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            form: {
                                labId: '',
                                time: '',
                                reason: ''
                            }, rules: {
                                labId: [{required: true, message: '请选择申请的实验室', trigger: 'change'}],
                                time: [{required: true, message: '请选择借用时间段', trigger: 'change'}],
                                reason: [{required: true, message: '请填写申请理由', trigger: 'blur'}]
                            },
                            labList: [],
                            dialogVisible: false
                        }
                    }, created() {
                        this.getLabList()
                    },
                    methods: {
                        submit() {
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    // alert('submit!')
                                    // // console.log('this.form', this.form)
                                    let url = '/borrow/lab/saveLabRecord'
                                    let _that = this
                                    c.ajax({
                                        url: url,
                                        type: 'post',
                                        dataType: 'json',
                                        data: JSON.stringify(this.form),
                                        cache: false,
                                        headers: {
                                            'Content-Type': 'application/json'
                                        },
                                        success: res => {
                                            // // console.log('res', res)
                                            if (res.code === 0) {
                                                _that.$message({type: 'success', message: res.msg})
                                                _that.$refs.form.resetFields()
                                                index.openTab({
                                                    title: '借用列表',
                                                    url: '/borrow/list/'
                                                })
                                                k.refresh('/borrow/list/')
                                                index.closeTab('/borrow/lab/')
                                            } else {
                                                _that.$message.error(res.msg)
                                                // _that.$notify.error({
                                                //     title: '实验室占用信息',
                                                //     message: res.msg,
                                                //     duration: 0
                                                // });
                                                if (res.data && res.data.length > 0) {
                                                    console.log('data', res.data)
                                                    let data = res.data[0]
                                                    let msg = ''
                                                    if (data.realName) {
                                                        msg += '占用人:' + data.realName
                                                    } else {
                                                        msg += '占用人:' +  data.username
                                                    }
                                                    if (data.email) {
                                                        msg += '、邮箱为:' + data.email
                                                    }
                                                    if ( data.tel) {
                                                        msg += '、电话为:' + data.tel
                                                    }
                                                    if ( data.weichat) {
                                                        msg += '、微信为:' +  data.weichat
                                                    }
                                                    _that.$notify.error({
                                                        title: '实验室占用信息',
                                                        message: msg,
                                                        duration: 0
                                                    });
                                                }
                                            }
                                        }
                                    })
                                } else {
                                    // // // console.log('error submit!!')
                                    return false
                                }
                            });
                        },
                        getLabList() {
                            let url = '/borrow/lab/getLabList'
                            c.get(url, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.labList = res.data
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
