<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>仪器管理</title>
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
                        <el-col :span="22">
                            <el-row style="padding-top: 20px" type="flex" justify="start" align="middle">
                                <el-col>
                                    仪器名称：
                                    <el-input style="width: 20%" @blur="search" v-model="name"
                                              placeholder="输入仪器名称"></el-input>
                                    <el-button icon="el-icon-search" @click="search"></el-button>
                                    <el-button icon="el-icon-plus" @click="showDialog" type="success">添加</el-button>
                                </el-col>
                            </el-row>
                            <el-row type="flex" style="margin-top: 10px" :gutter="8" align="middle" justify="start">
                                <el-col :span="12">
                                    <el-row type="flex" align="middle">
                                        <span>批量上传实验仪器：</span>
                                        <el-button style="margin-left: 10px" @click="getFile">模板下载</el-button>
                                        <el-upload style="margin-left: 10px" :show-file-list="false"
                                                   action="/experiment/instrument/upload"
                                                   :on-success="uploadFileSuccess" :before-upload="beforeUpload"
                                                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                                            <el-button type="primary">上传文件</el-button>
                                        </el-upload>
                                    </el-row>
                                </el-col>
                            </el-row>
                            <el-row style="padding-top: 20px">
                                <el-table border :data="tableData" style="width: 100%">
                                    <el-table-column align="center" prop="name" label="仪器名称" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="lab" label="所属实验室" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="description" label="仪器描述" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="address" label="存放地点" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="teacher1" label="负责教师1" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="teacher2" label="负责教师2" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="teacher3" label="负责教师3" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="addTime" label="创建时间" min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" label="操作">
                                        <template slot-scope="scope">
                                            <el-button size="mini" @click="edit(scope.row)">编辑</el-button>
                                            <el-popconfirm :title="'确定删除仪器：'+scope.row.name+' 吗?'"
                                                           @confirm="handleDelete(scope.row)">
                                                <el-button slot="reference" size="mini" type="danger">删除</el-button>
                                            </el-popconfirm>
                                            <%--                                            <el-button slot="reference" size="mini" type="danger"--%>
                                            <%--                                                       @click="handleDelete(scope.row)">删除--%>
                                            <%--                                            </el-button>--%>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding-top: 30px">
                                <el-col :span="10">
                                    <el-pagination style="text-align: center" layout="prev, pager, next"
                                                   :page-size="limit" @current-change="currentChange" :total="total">
                                    </el-pagination>
                                </el-col>
                            </el-row>
                            <el-dialog @opened="opened" :title="isUpdate==0?'添加仪器':'修改仪器'" :visible.sync="dialogVisible"
                                       width="50%">
                                <el-row type="flex" justify="center">
                                    <el-col :span="18">
                                        <el-form ref="form" :rules="rules" :model="form" label-width="80px">
                                            <el-form-item v-show="false">
                                                <el-input v-model="form.id"></el-input>
                                            </el-form-item>
                                            <el-form-item label="仪器名称" prop="name">
                                                <el-input ref="formNameInput" @keyup.enter.native="toDescription"
                                                          v-model="form.name"></el-input>
                                            </el-form-item>
                                            <el-form-item label="所属实验室" prop="labName">
                                                <el-input ref="formNameInput" @keyup.enter.native="toLabName"
                                                          v-model="form.labName"></el-input>
                                            </el-form-item>
                                            <el-form-item label="存放地点" prop="address">
                                                <el-input ref="formNameInput" @keyup.enter.native="toAddress"
                                                          v-model="form.address"></el-input>
                                            </el-form-item>
                                            <el-form-item label="负责教师1" prop="teacher1">
                                                <el-input ref="formNameInput" @keyup.enter.native="toTeacher1"
                                                          v-model="form.teacher1"></el-input>
                                            </el-form-item>
                                            <el-form-item label="负责教师2" prop="teacher2">
                                                <el-input ref="formNameInput" @keyup.enter.native="toTeacher2"
                                                          v-model="form.teacher2"></el-input>
                                            </el-form-item>
                                            <el-form-item label="负责教师3" prop="teacher3">
                                                <el-input ref="formNameInput" @keyup.enter.native="toTeacher3"
                                                          v-model="form.teacher3"></el-input>
                                            </el-form-item>
                                            <el-form-item label="仪器描述">
                                                <el-input @keyup.enter.native="submit" ref="formDescInput"
                                                          v-model="form.description"></el-input>
                                            </el-form-item>
                                        </el-form>
                                    </el-col>
                                </el-row>
                                <span slot="footer" class="dialog-footer">
                                    <el-button @click="dialogVisible = false">取消</el-button>
                                    <el-button type="success" @click="submit">{{btnName}}</el-button>
                                </span>
                            </el-dialog>
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
                        return {
                            dialogVisible: false,
                            page: 1,
                            limit: 10,
                            total: 0,
                            tableData: [],
                            isUpdate: 0,
                            name: '',
                            btnName: '提交',
                            form: {
                                id: '',
                                name: '',
                                labName: '',
                                address:'',
                                teacher1:'',
                                teacher2:'',
                                teacher3:'',
                                description: ''
                            },
                            rules: {
                                name: [
                                    {required: true, message: '请输入仪器名称', trigger: 'blur'}
                                ],
                            }
                        }
                    }, created() {
                        this.getInstrumentList()
                    },
                    methods: {
                        toDescription() {
                            this.$refs.formDescInput.focus()
                        },
                        opened() {
                            if (this.isUpdate === 0) {
                                this.$refs.formNameInput.focus()
                            }
                        },
                        edit(row) {
                            //编辑
                            this.form = {
                                id: row.id,
                                name: row.name,
                                labName:row.labName,
                                teacher1: row.teacher1,
                                address:row.address,
                                teacher2: row.teacher2,
                                teacher3: row.teacher3,
                                description: row.description
                            }
                            this.isUpdate = 1
                            this.btnName = '修改'
                            this.dialogVisible = true
                        }, search() {
                            this.page = 1
                            this.getInstrumentList()
                        },
                        currentChange(val) {
                            this.page = val
                            this.getInstrumentList()
                        },
                        handleDelete(row) {
                            //删除
                            let url = '/experiment/instrument/del/' + row.id
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.$message({type: 'success', message: res.msg})
                                    this.getInstrumentList()
                                }
                            })
                        },
                        getInstrumentList() {
                            let url = '/experiment/instrument/getInstrumentList'
                            c.get(url, {page: this.page, name: this.name, limit: this.limit}, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    this.tableData = res.data.records
                                    this.total = res.data.total
                                }
                            })
                        },
                        submit() {
                            // console.log('submit:', this.$refs)
                            this.$refs.form.validate(valid => {
                                if (valid) {
                                    let url
                                    if (this.isUpdate === 0) {
                                        url = '/experiment/instrument/saveInstrument'
                                    } else {
                                        url = '/experiment/instrument/updateInstrument'
                                    }
                                    let _that = this
                                    c.ajax({
                                        type: 'POST',
                                        url: url,
                                        data: JSON.stringify(this.form),
                                        headers: {
                                            'Content-Type': 'application/json'
                                        },
                                        success: res => {
                                            if (res.code === 0) {
                                                _that.$message({type: 'success', message: res.msg})
                                                _that.$refs.form.resetFields()
                                                _that.resetForm()
                                                _that.getInstrumentList()
                                                _that.dialogVisible = false
                                            } else {
                                                _that.$message.error(res.msg)
                                            }
                                        }
                                    });
                                } else {
                                    return false
                                }
                            })
                        },
                        resetForm() {
                            this.form = {
                                id: '',
                                name: '',
                                description: ''
                            }
                        },
                        showDialog() {
                            this.isUpdate = 0
                            this.btnName = '提交'
                            this.resetForm()
                            this.dialogVisible = true
                        },
                        getFile() {
                            //点击导出到excel表格
                            this.loading = true
                            let url = '/experiment/instrument/getFile'
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click()
                            this.loading = false
                        },
                        beforeUpload(file) {
                            // // console.log('file:', file)
                            if (file.type !== 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' && file.type !== 'application/vnd.ms-excel') {
                                this.$message.error('上传的文件格式不正确')
                                return false
                            }
                            this.loading = true
                        },
                        uploadFileSuccess(res) {
                            this.loading = false
                            if (res.code === 0) {
                                this.$message({type: 'success', message: res.msg})
                            } else {
                                this.$message.error(res.msg)
                                this.existList = res.data
                                if (res.data.length > 0) {
                                    this.existDialogVisible = true
                                }
                            }
                            this.getInstrumentList()
                        },
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
