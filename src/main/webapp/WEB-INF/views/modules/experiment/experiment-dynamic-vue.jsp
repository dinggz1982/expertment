<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>我的实验</title>
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
                    <el-row class="main-row">
                        <el-col :span="22">
                            <el-button type="primary" @click="addNewDynamic">发布新动态</el-button>
                        </el-col>
                        <el-col :span="22" style="margin-top: 10px">
                            <el-table border highlight-current-row :data="dynamicList" style="width: 100%">
                                <el-table-column align="center" prop="title" label="动态标题"
                                                 min-width="180"></el-table-column>
                                <el-table-column align="center" prop="content" label="动态内容"
                                                 min-width="180"></el-table-column>
                                <el-table-column align="center" prop="createTime" label="时间"
                                                 min-width="180"></el-table-column>
                                <el-table-column align="center" prop="isPublish" label="是否发布"
                                                 min-width="180">
                                    <template slot-scope="scope">
                                        <el-switch v-model="scope.row.isPublish===1?true:false" active-color="#13ce66"
                                                   @change="switchChange($event,scope.row)" inactive-color="#ff4949">
                                        </el-switch>
                                    </template>
                                </el-table-column>
                                <el-table-column align="center" label="操作" min-width="250">
                                    <template slot-scope="scope">
                                        <el-button @click="update(scope.row)" type="primary">修改</el-button>
                                        <el-popconfirm title="确定删除该公告吗？" @confirm="confirmDel(scope.row)">
                                            <el-button slot="reference" type="danger">删除</el-button>
                                        </el-popconfirm>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </el-col>
                        <el-col :span="22" style="margin-top: 10px">
                            <el-pagination @current-change="currentPageChange" :page-size="limit"
                                           layout="prev, pager, next" :total="total">
                            </el-pagination>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
            <el-dialog :close-on-click-modal="false" :title="dialogData.title" :visible.sync="dialogData.show"
                       width="60%">
                <el-form ref="form" :rules="rules" :model="dialogData.formData" label-width="80px">
                    <el-form-item label="动态标题" prop="title">
                        <el-input v-model="dialogData.formData.title"></el-input>
                    </el-form-item>
                    <el-form-item label="动态内容" prop="content">
                        <el-input type="textarea" autosize v-model="dialogData.formData.content"></el-input>
                    </el-form-item>
                </el-form>
                <span slot="footer" class="dialog-footer">
                    <el-button @click="cancel">取 消</el-button>
                    <el-button type="primary" @click="submit">确 定</el-button>
                </span>
            </el-dialog>
        </div>
        <!-- js部分 -->
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            rules: {
                                title: [
                                    {required: true, message: '请输入动态标题', trigger: 'blur'},
                                ],
                                content: [
                                    {required: true, message: '请输入动态内容', trigger: 'blur'},
                                ]
                            },
                            dialogData: {
                                show: false,
                                title: '添加新公告',
                                formData: {
                                    id: '',
                                    title: '',
                                    content: ''
                                }
                            },
                            loading: false,
                            page: 1,
                            limit: 10,
                            total: 0,
                            dynamicList: []
                        }
                    },
                    created() {
                        this.getDynamicList()
                    },
                    methods: {
                        submit() {
                            this.loading = true
                            const url = '/experiment/dynamic/saveOrUpdate'
                            c.ajax({
                                url: url,
                                type: 'post',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                data: JSON.stringify(this.dialogData.formData),
                                success: res => {
                                    this.loading = false
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.$message.success('操作成功')
                                        this.getDynamicList()
                                        this.dialogData.show = false
                                    } else {
                                        this.$message.error(res.msg)
                                        this.getDynamicList()
                                    }
                                }
                            })
                        },
                        cancel() {
                            this.dialogData.show = false
                        },
                        update(row) {
                            this.dialogData.title = '修改新动态'
                            this.dialogData.formData = {
                                ...row
                            }
                            this.dialogData.show = true
                        },
                        addNewDynamic() {
                            this.dialogData.title = '添加新动态'
                            this.dialogData.formData = {
                                id: '',
                                content: '',
                                title: ''
                            }
                            this.dialogData.show = true
                        },
                        confirmDel(row) {
                            this.loading = true
                            //删除公告
                            const url = '/experiment/dynamic/delById/' + row.id
                            c.ajax({
                                url: url,
                                type: 'get',
                                success: res => {
                                    this.loading = false
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.$message.success('删除成功')
                                        this.getDynamicList()
                                    } else {
                                        this.$message.error(res.msg)
                                        this.getDynamicList()
                                    }
                                }
                            })
                        },
                        switchChange($event, row) {
                            if ($event === true) {
                                row.isPublish = 1
                            } else {
                                row.isPublish = 0
                            }
                            const url = '/experiment/dynamic/updatePublish'
                            let postData = {id: row.id, isPublish: row.isPublish}
                            c.ajax({
                                url: url,
                                type: 'post',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                data: JSON.stringify(postData),
                                success: res => {
                                    this.loading = false
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.$message.success('更新成功')
                                    } else {
                                        this.$message.error(res.msg)
                                        this.getDynamicList()
                                    }
                                }
                            })
                        },
                        currentPageChange(val) {
                            this.page = val
                            this.getDynamicList()
                        },
                        getDynamicList() {
                            this.loading = true
                            const url = '/experiment/dynamic/listAll'
                            let postData = {page: this.page, limit: this.limit}
                            c.ajax({
                                url: url,
                                type: 'post',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                data: JSON.stringify(postData),
                                success: res => {
                                    this.loading = false
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.total = res.data.total
                                        this.dynamicList = res.data.records
                                    }
                                }
                            })
                        }
                    }
                })
            })
        </script>

    </body>
</html>
