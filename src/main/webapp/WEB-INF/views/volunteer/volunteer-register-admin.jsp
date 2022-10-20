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
                min-height: 700px;
            }

            .language-tag {
                margin-left: 10px;
            }

            .language-tag:nth-child(1) {
                margin-left: 0;
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
                                <el-form :inline="true" :model="formInline" class="demo-form-inline">
                                    <el-form-item label="姓名:">
                                        <el-input v-model="formInline.name" placeholder=""></el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button type="success" @click="search">查询</el-button>
                                        <el-button type="primary" @click="exportExcel">导出excel</el-button>
                                    </el-form-item>

                                </el-form>
                            </el-row>
                            <el-row>
                                <el-table border :data="dataList" style="width: 100%">
                                    <el-table-column align="center"
                                                     prop="registerDate"
                                                     label="注册日期"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="name"
                                                     label="姓名"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="sex"
                                                     label="性别"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="nationality"
                                                     label="民族"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="registerType"
                                                     label="为谁注册"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="mobile"
                                                     label="电话"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     prop="email"
                                                     label="邮箱"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center"
                                                     label="语言"
                                                     min-width="180">
                                        <template slot-scope="scope">
                                            <el-row style="display: flex;flex-wrap: wrap;">
                                                <el-tag v-if="item&&item!==''"
                                                        style="margin-left: 10px;margin-top: 10px;"
                                                        v-for="(item,index) in JSON.parse(scope.row.language)"
                                                        :key="index">{{item}}
                                                </el-tag>
                                            </el-row>
                                        </template>
                                    </el-table-column>
                                    <el-table-column min-width="100" align="center" label="操作">
                                        <template slot-scope="scope">
                                            <el-button type="primary" @click="showDetail(scope.row)">详情</el-button>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </el-row>
                            <el-row style="margin-top: 10px;">
                                <el-pagination @current-change="currentChange"
                                               background :page-size="limit"
                                               layout="prev, pager, next"
                                               :total="total">
                                </el-pagination>
                            </el-row>
                            <el-row>
                                <el-dialog title="提示" :visible.sync="dialogVisible" width="70%">
                                    <el-row>
                                        <el-form ref="form" label-width="200px">
                                            <el-form-item label="您为谁注册？">
                                                <el-tag type="success">{{detailItem.registerType}}</el-tag>
                                            </el-form-item>
                                            <el-form-item label="姓名:" prop="name">
                                                <el-tag type="success">{{detailItem.name}}</el-tag>
                                            </el-form-item>
                                            <el-form-item label="出生年月日:" prop="birth">
                                                <el-tag type="success">{{detailItem.birth}}</el-tag>
                                            </el-form-item>
                                            <el-form-item label="性别:" prop="sex">
                                                <el-tag type="success">{{detailItem.sex}}</el-tag>
                                            </el-form-item>
                                            <el-form-item label="民族:" prop="nationality">
                                                <el-tag type="success">{{detailItem.nationality}}</el-tag>
                                            </el-form-item>
                                            <el-form-item label="使用语言:" prop="language">
                                                <el-tag class="language-tag" type="success" v-if="item&&item!==''"
                                                        v-for="(item,index) in  detailItem.languageArr"
                                                        :key="index">{{item}}
                                                </el-tag>
                                            </el-form-item>
                                            <el-form-item label="参与者的诊断信息:" prop="info">
                                                <el-row v-if="item" v-for="(item,index) in detailItem.info"
                                                        :key="index">
                                                    <el-tag type="success">{{item.diagnosisInfo}}</el-tag>
                                                </el-row>
                                            </el-form-item>
                                            <el-form-item label="Email:" prop="email">
                                                <el-tag v-if="detailItem.email" type="success">{{detailItem.email}}
                                                </el-tag>
                                            </el-form-item>
                                            <el-form-item label="手机号码:" prop="mobile">
                                                <el-tag v-if="detailItem.mobile" type="success">{{detailItem.mobile}}
                                                </el-tag>
                                            </el-form-item>
                                            <el-form-item label="微信:" prop="wechat">
                                                <el-tag v-if="detailItem.wechat" type="success">{{detailItem.wechat}}
                                                </el-tag>
                                            </el-form-item>
                                        </el-form>
                                    </el-row>
                                </el-dialog>
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
                        return {
                            page: 1,
                            limit: 10,
                            total: 0,
                            detailItem: {},
                            dataList: [],
                            dialogVisible: false,
                            diagnosisTypeList: [],
                            formInline: {
                                name: ''
                            }
                        }
                    },
                    async created() {
                        this.loading = true
                        await this.getDiagnosisType()
                        await this.getDataList()
                        this.loading = false
                    },
                    methods: {
                        exportExcel() {
                            //导出到excel表格
                            const url = '/volunteer/admin/exportExcel'
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click()
                        },
                        search() {
                            this.page = 1;
                            this.getDataList()
                        },
                        async getDiagnosisType() {
                            const url = '/volunteer/register/getDiagnosisType'
                            await c.get(url).then(res => {
                                console.log('res:', res)
                                if (res.code === 0) {
                                    this.diagnosisTypeList = res.data
                                }
                            })
                        },
                        showDetail(item) {
                            this.detailItem = item
                            console.log('showDetail start')
                            this.detailItem.languageArr = JSON.parse(this.detailItem.language)
                            console.log('showDetail item', item)
                            this.dialogVisible = true
                        },
                        currentChange(val) {
                            this.page = val
                            this.getDataList()
                        },
                        async getDataList() {
                            this.loading = true
                            const url = '/volunteer/admin/getRegisterDataList'
                            let postData = {page: this.page, limit: this.limit, ...this.formInline}
                            c.ajax({
                                type: 'POST',
                                url: url, dataType: 'json',
                                contentType: 'application/json;charset=UTF-8',
                                data: JSON.stringify(postData),
                                success: res => {
                                    this.loading = false
                                    // console.log('  res', res)
                                    if (res.code === 0) {
                                        this.dataList = res.data.records
                                        this.total = res.data.total
                                    }
                                },
                            });
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
