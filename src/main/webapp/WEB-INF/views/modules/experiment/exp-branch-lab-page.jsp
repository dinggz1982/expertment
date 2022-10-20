<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验分室</title>
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
        <div id="app" v-loading="loading">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22">
                            <el-row>
                                <el-form :inline="true" :model="searchForm">
                                    <el-form-item label="实验室名称：">
                                        <el-input v-model="searchForm.name" clearable placeholder=""></el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button @click="search">查询</el-button>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button type="success" @click="addNewBranchLab">添加新分室</el-button>
                                    </el-form-item>
                                </el-form>
                            </el-row>
                            <el-row style="margin-top: 10px;">
                                <el-table border :data="dataList" style="width: 100%">
                                    <el-table-column align="center" prop="name" label="名称"></el-table-column>
                                    <el-table-column align="center" prop="address" label="地址"></el-table-column>
                                    <el-table-column align="center" prop="description" label="描述"></el-table-column>
                                    <el-table-column align="center" label="操作" min-width="100">
                                        <template slot-scope="scope">
                                            <el-button type="primary" @click="updateBranchLab(scope.row)">修改</el-button>
                                            <el-popconfirm title="确认删除该实验室吗?" @confirm="delBranchLab(scope.row)">
                                                <el-button slot="reference" type="danger">删除</el-button>
                                            </el-popconfirm>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </el-row>
                            <el-row style="margin-top: 10px">
                                <el-pagination
                                        background @current-change="currentChange"
                                        layout="prev, pager, next" :current-page="page"
                                        :total="total">
                                </el-pagination>
                            </el-row>
                        </el-col>
                        <el-row>
                            <el-dialog :title="title" :close-on-click-modal="false" :visible.sync="dialogVisible">
                                <el-form ref="form" :rules="rules" :model="formData" label-width="150px">
                                    <el-form-item label="实验分室名称" prop="name">
                                        <el-input v-model="formData.name"></el-input>
                                    </el-form-item>
                                    <el-form-item label="实验分室地址" prop="address">
                                        <el-input v-model="formData.address"></el-input>
                                    </el-form-item>
                                    <el-form-item label="功能介绍">
                                        <el-input type="textarea" :autosize="{ minRows: 6 }"
                                                  :maxlength="255" v-model="formData.description">
                                        </el-input>
                                    </el-form-item>
                                </el-form>
                                <div slot="footer">
                                    <el-button @click="dialogVisible = false">取消</el-button>
                                    <el-button :loading="loading" type="primary" @click="submit">确定</el-button>
                                </div>
                            </el-dialog>
                        </el-row>
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
                            loading: false,
                            title: '添加新实验分室',
                            searchForm: {
                                //搜索form
                            },
                            page: 1,
                            limit: 10,
                            total: 0,
                            dataList: [],
                            formData: {
                                //添加修改form
                            },
                            dialogVisible: false,
                            rules: {
                                name: [
                                    {required: true, message: '请输入实验分室名称', trigger: 'blur'}
                                ],
                            }
                        }
                    },
                    async created() {
                        this.loading = true
                        await this.getDataList()
                        this.loading = false
                    },
                    methods: {
                        search() {
                            this.page = 1
                            this.getDataList()
                        },
                        currentChange(val) {
                            this.page = val
                            this.getDataList()
                        },
                        updateBranchLab(row) {
                            this.formData = {...row}
                            this.dialogVisible = true
                        },
                        addNewBranchLab() {
                            this.formData = {}
                            this.dialogVisible = true
                        },
                        async getDataList() {
                            this.loading = true
                            const url = '/exp-branch-lab/getTableList'
                            let _that = this
                            await c.get(url, {page: this.page, limit: this.limit, ...this.searchForm})
                                .then(res => {
                                    console.log('res:', res)
                                    this.loading = false
                                    if (res.code === 0) {
                                        this.dataList = res.data.records
                                        this.total = res.data.total
                                    } else {
                                        _that.$message.error(res.msg)
                                    }
                                })
                        },
                        submit() {
                            this.loading = true
                            const url = '/exp-branch-lab/saveOrUpdate'
                            let postData = {...this.formData}
                            let _this = this
                            c.ajax({
                                url: url,
                                type: 'post',
                                data: JSON.stringify(postData),
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                success: function (res) {
                                    // console.log(res)
                                    _this.$message.success(res.msg)
                                    _this.loading = false
                                    if (res.code === 0) {
                                        // console.log('res:', res)
                                        _this.getDataList()
                                        _this.dialogVisible = false
                                    } else {
                                        _this.$message.error(res.msg)
                                    }
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
