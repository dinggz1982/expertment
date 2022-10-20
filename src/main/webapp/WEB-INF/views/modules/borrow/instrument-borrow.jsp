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
                                    <el-form-item label="仪器" prop="id">
                                        <el-select v-model="form.id" placeholder="请选择申请的仪器" style="width: 100%">
                                            <el-option :label="item.name" v-for="(item,index) in list" :key="index"
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

                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            form: {
                                id: '',
                                time: '',
                                reason: ''
                            },
                            rules: {
                                id: [{required: true, message: '请选择申请的仪器', trigger: 'change'}],
                                time: [{required: true, message: '请选择借用时间段', trigger: 'change'}],
                                reason: [{required: true, message: '请填写申请理由', trigger: 'blur'}]
                            },
                            list: [],
                        }
                    }, created() {
                        this.getInstrumentList()
                    },
                    methods: {
                        submit() {
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    // alert('submit!')
                                    // // // console.log('this.form', this.form)
                                    let url = '/borrow/instrument/saveInstrumentRecord'
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
                                            // // // console.log('res', res)
                                            if (res.code === 0) {
                                                _that.$message({type: 'success', message: res.msg})
                                                _that.$refs.form.resetFields()
                                                index.openTab({
                                                    title: '借用列表',
                                                    url: '/borrow/list/'
                                                })
                                                k.refresh('/borrow/list/')
                                                index.closeTab('/borrow/instrument/')
                                            } else {
                                                _that.$message.error(res.msg)
                                            }
                                        }
                                    })
                                } else {
                                    // // // console.log('error submit!!')
                                    return false
                                }
                            });
                        },
                        getInstrumentList() {
                            let url = '/borrow/instrument/getInstrumentList'
                            c.get(url, res => {
                                // // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.list = res.data
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
