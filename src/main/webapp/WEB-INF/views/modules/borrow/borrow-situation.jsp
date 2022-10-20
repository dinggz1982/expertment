<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>借用情况</title>
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
                                <el-tabs v-model="activeName" type="card" @tab-click="getData">
                                    <el-tab-pane label="实验室" name="lab">
                                        <el-row style="padding-bottom: 20px">
                                            状态选择：
                                            <el-select v-model="pageInfo.lab.status" @change="labChange"
                                                       placeholder="请选择状态">
                                                <el-option label="全部状态" value="-1"></el-option>
                                                <el-option
                                                        v-for="item in statusList" :key="item.id"
                                                        :label="item.desc" :value="item.id">
                                                </el-option>
                                            </el-select>
                                        </el-row>
                                        <el-row>
                                            <el-table border :data="labList" style="width: 100%">
                                                <el-table-column align="center" prop="name" label="实验室名称"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="realName" label="申请人"
                                                                 min-width="150">
                                                </el-table-column>
                                                <el-table-column align="center" prop="formTime" label="申请时间段"
                                                                 min-width="300">
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
                                        <el-row style="padding-bottom: 20px">
                                            状态选择：
                                            <el-select v-model="pageInfo.instrument.status" @change="instrumentChange"
                                                       placeholder="请选择状态">
                                                <el-option label="全部状态" value="-1"></el-option>
                                                <el-option
                                                        v-for="item in statusList" :key="item.id"
                                                        :label="item.desc" :value="item.id">
                                                </el-option>
                                            </el-select>
                                        </el-row>
                                        <el-row>
                                            <el-table border :data="instrumentList" style="width: 100%">
                                                <el-table-column align="center" prop="name" label="仪器名称"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="realName" label="申请人"
                                                                 min-width="150">
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
                                                <el-table-column align="center" label="归还时间" min-width="250">
                                                    <template slot-scope="scope">
                                                        <el-row>
                                                            <el-date-picker v-if="scope.row.status == 4"
                                                                            style="width: 90%"
                                                                            v-model="scope.row.returnTime"
                                                                            @change="returnTimeChange(scope.row)"
                                                                            type="datetime" format="yyyy-MM-dd HH:mm"
                                                                            placeholder="选择归还时间">
                                                            </el-date-picker>
                                                        </el-row>
                                                    </template>
                                                </el-table-column>
                                                <el-table-column align="center" label="状态" min-width="180">
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
                                                <%--                                                <el-table-column fixed="right" align="center" label="操作"--%>
                                                <%--                                                                 min-width="150">--%>
                                                <%--                                                    <template slot-scope="scope">--%>
                                                <%--                                                        <el-button size="mini" type="primary">设置归还时间</el-button>--%>
                                                <%--                                                    </template>--%>
                                                <%--                                                </el-table-column>--%>
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
                                    total: 0,
                                    status: '-1'
                                },
                                instrument: {
                                    page: 1,
                                    limit: 10,
                                    total: 0,
                                    status: '-1'
                                }
                            },
                            labList: [],
                            instrumentList: [],
                            statusList: [],
                        }
                    }, created() {
                        this.getApplyStatusList()
                        this.getData()
                    },
                    methods: {
                        formatDate(date) {
                            let y = date.getFullYear();
                            let m = date.getMonth() + 1;
                            m = m < 10 ? ('0' + m) : m;
                            let d = date.getDate();
                            d = d < 10 ? ('0' + d) : d;
                            let h = date.getHours();
                            let minute = date.getMinutes();
                            minute = minute < 10 ? ('0' + minute) : minute;
                            let second = date.getSeconds();
                            second = minute < 10 ? ('0' + second) : second;
                            return y + '-' + m + '-' + d + ' ' + h + ':' + minute;
                        },
                        returnTimeChange(row) {
                            // console.log('returnTimeChange:', row)
                            let url = '/borrow/situation/updateReturnTime'
                            let returnTime = null
                            if (row.returnTime) {
                                returnTime = this.formatDate(row.returnTime)
                            }
                            c.get(url,
                                {
                                    id: row.id,
                                    returnTime: returnTime
                                },
                                res => {
                                    // // console.log('res:', res)
                                    if (res.code === 0) {
                                        this.$message({type: 'success', message: res.msg})
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                })
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
                        instrumentChange() {
                            this.pageInfo.instrument.page = 1
                            this.getData()
                        },
                        labChange() {
                            this.pageInfo.lab.page = 1
                            this.getData()
                        },
                        instrumentListCurrentChange(val) {
                            this.pageInfo.instrument.page = val
                            this.getData()
                        },
                        labCurrentChange(val) {
                            this.pageInfo.lab.page = val
                            this.getData()
                        },
                        getInstrumentList() {
                            let url = '/borrow/situation/getInstrumentList'
                            c.get(url, {
                                page: this.pageInfo.instrument.page,
                                limit: this.pageInfo.instrument.limit,
                                status: this.pageInfo.instrument.status
                            }, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.instrumentList = res.data.records
                                    this.pageInfo.instrument.total = res.data.total
                                    if (this.instrumentList.length > 0) {
                                        this.instrumentList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    } else if (this.instrumentList.length === 0 && this.pageInfo.instrument.page > 1) {
                                        this.pageInfo.instrumentList.page = this.pageInfo.instrumentList.page - 1
                                        this.getInstrumentList()
                                    }
                                }
                            })
                        },
                        getLabList() {
                            let url = '/borrow/situation/getLabList'
                            c.get(url, {
                                page: this.pageInfo.lab.page,
                                limit: this.pageInfo.lab.limit,
                                status: this.pageInfo.lab.status
                            }, res => {
                                // // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.labList = res.data.records
                                    this.pageInfo.lab.total = res.data.total
                                    if (this.labList.length > 0) {
                                        this.labList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    } else if (this.labList.length === 0 && this.pageInfo.lab.page > 1) {
                                        this.pageInfo.lab.page = this.pageInfo.lab.page - 1
                                        this.getLabList()
                                    }
                                }
                            })
                        },
                        getData() {
                            if (this.activeName === 'lab') {
                                this.getLabList()
                            } else if (this.activeName === 'instrument') {
                                this.getInstrumentList()
                            }
                        },
                        handleClick() {
                            this.getData()
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
