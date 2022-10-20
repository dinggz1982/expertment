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
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22">
                            <el-row>
                                <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
                                    <el-tab-pane label="实验室" name="lab">
                                        <el-row style="padding:20px 0">
                                            <el-button icon="el-icon-plus" type="success" @click="toApplyPage">申请借用实验室
                                            </el-button>
                                        </el-row>
                                        <el-row>
                                            <el-table border :data="labList" style="width: 100%">
                                                <el-table-column align="center" prop="name" label="实验室名称"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="formTime" label="申请时间段"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="reason" label="申请原因"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="applyTime" label="申请时间"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" label="状态" min-width="180">
                                                    <template slot-scope="scope">
                                                        <el-popover v-if="scope.row.status==3" placement="top-start"
                                                                    title="驳回理由" width="200" trigger="hover">
                                                            <span style="color: red">{{scope.row.teacherRejectReason}}</span>
                                                            <span style="color: red" slot="reference">{{scope.row.statusName}}</span>
                                                        </el-popover>
                                                        <el-popover v-else-if="scope.row.status == 5"
                                                                    placement="top-start" title="驳回理由" width="200"
                                                                    trigger="hover">
                                                            <span style="color: red">{{scope.row.experimenterRejectReason}}</span>
                                                            <span style="color: red" slot="reference">{{scope.row.statusName}}</span>
                                                        </el-popover>
                                                        <span v-else>{{scope.row.statusName}}</span>
                                                    </template>
                                                </el-table-column>
                                            </el-table>
                                        </el-row>
                                        <el-row type="flex" justify="center" style="padding-top: 30px">
                                            <el-col :span="10">
                                                <el-pagination style="text-align: center" layout="prev, pager, next"
                                                               :page-size="pageInfo.lab.limit"
                                                               @current-change="labCurrentChange"
                                                               :total="pageInfo.lab.total">
                                                </el-pagination>
                                            </el-col>
                                        </el-row>
                                    </el-tab-pane>
                                    <el-tab-pane label="仪器" name="instrument">
                                        <el-row style="padding:20px 0">
                                            <el-button icon="el-icon-plus" type="success"
                                                       @click="toInstrumentApplyPage">申请借用仪器
                                            </el-button>
                                        </el-row>
                                        <el-row>
                                            <el-table border :data="instrumentList" style="width: 100%">
                                                <el-table-column align="center" prop="name" label="仪器名称"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="formTime" label="申请时间段"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="reason" label="申请原因"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="applyTime" label="申请时间"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="statusName" label="状态"
                                                                 min-width="180">
                                                    <template slot-scope="scope">
                                                        <el-popover v-if="scope.row.status == 3" placement="top-start"
                                                                    title="驳回理由" width="200" trigger="hover">
                                                            <span style="color: red">{{scope.row.teacherRejectReason}}</span>
                                                            <span style="color: red" slot="reference">{{scope.row.statusName}}</span>
                                                        </el-popover>
                                                        <el-popover v-else-if="scope.row.status == 5"
                                                                    placement="top-start" title="驳回理由" width="200"
                                                                    trigger="hover">
                                                            <span style="color: red">{{scope.row.experimenterRejectReason}}</span>
                                                            <span style="color: red" slot="reference">{{scope.row.statusName}}</span>
                                                        </el-popover>
                                                        <span v-else>{{scope.row.statusName}}</span>
                                                    </template>
                                                </el-table-column>
                                                <el-table-column align="center" label="归还时间" min-width="250">
                                                    <template slot-scope="scope">
                                                        <el-row>
                                                            <el-date-picker v-if="scope.row.status == 4"
                                                                            :disabled="true" style="width: 90%"
                                                                            v-model="scope.row.returnTime"
                                                                            type="datetime" format="yyyy-MM-dd HH:mm"
                                                                            placeholder="选择归还时间">
                                                            </el-date-picker>
                                                        </el-row>
                                                    </template>
                                                </el-table-column>
                                            </el-table>
                                        </el-row>
                                        <el-row type="flex" justify="center" style="padding-top: 30px">
                                            <el-col :span="10">
                                                <el-pagination style="text-align: center" layout="prev, pager, next"
                                                               :page-size="pageInfo.instrument.limit"
                                                               @current-change="instrumentListCurrentChange"
                                                               :total="pageInfo.instrument.total">
                                                </el-pagination>
                                            </el-col>
                                        </el-row>
                                    </el-tab-pane>
                                </el-tabs>
                            </el-row>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>

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
                            activeName: 'lab',
                            pageInfo: {
                                lab: {
                                    page: 1,
                                    limit: 10,
                                    total: 0
                                },
                                instrument: {
                                    page: 1,
                                    limit: 10,
                                    total: 0
                                }
                            },
                            labList: [],
                            instrumentList: [],
                            statusList: [],
                        }
                    }, created() {
                        // console.log('this.fjewoq', this.pageInfo.lab.limit)
                        // this.getApplyStatusList()
                        this.getData()
                    },
                    methods: {
                        toInstrumentApplyPage() {
                            index.openTab({
                                title: '仪器借用',
                                url: '/borrow/instrument/'
                            })
                        },
                        toApplyPage() {
                            index.openTab({
                                title: '实验室借用',
                                url: '/borrow/lab/'
                            })
                        },
                        formatterStatus(row) {
                            let res = ''
                            // console.log('row:', row)
                            if (this.statusList.length > 0 && row.status) {
                                this.statusList.forEach(item => {
                                    // console.log('item:', item)
                                    if (item.id === row.status) {
                                        res = item.desc
                                    }
                                })
                            }
                            return res
                        },
                        getApplyStatusList() {
                            let url = '/borrow/list/getBorrowStatusList'
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.statusList = res.data
                                    if (this.statusList.length > 0) {
                                        this.statusList.forEach(item => {
                                            item.id = item.id + ''
                                        })
                                    }
                                }
                            })
                        },
                        instrumentListCurrentChange(val) {
                            this.pageInfo.instrument.page = val
                            this.getData()
                        },
                        labCurrentChange(val) {
                            this.pageInfo.lab.page = val
                            this.getData()
                        },
                        getApplyInstrumentList() {
                            let url = '/borrow/list/instrumentList'
                            c.get(url, {
                                page: this.pageInfo.instrument.page,
                                limit: this.pageInfo.instrument.limit
                            }, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    this.instrumentList = res.data.records
                                    this.pageInfo.instrument.total = res.data.total
                                    if (this.instrumentList.length > 0) {
                                        this.instrumentList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    }
                                }
                            })
                        },
                        getApplyLabList() {
                            let url = '/borrow/list/labList'
                            c.get(url, {
                                page: this.pageInfo.lab.page,
                                limit: this.pageInfo.lab.limit
                            }, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.labList = res.data.records
                                    this.pageInfo.lab.total = res.data.total
                                    if (this.labList.length > 0) {
                                        this.labList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    }
                                }
                            })
                        },
                        getData() {
                            if (this.activeName === 'lab') {
                                this.getApplyLabList()
                            } else if (this.activeName === 'instrument') {
                                this.getApplyInstrumentList()
                            }
                        },
                        handleClick() {
                            // this.page = 1
                            this.getData()
                        }
                    }
                })
            })
        </script>
    </body>
</html>
