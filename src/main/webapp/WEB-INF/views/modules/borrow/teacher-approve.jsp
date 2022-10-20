<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验室与仪器导师审批</title>
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
                                        <el-row v-if="multipleSelection.lab.length>0"
                                                style="padding-bottom: 10px">
                                            <el-button type="primary" @click="allApprove('labList')">全部审核</el-button>
                                        </el-row>
                                        <el-row>
                                            <el-table @selection-change="handleLabSelectionChange" border
                                                      :data="labApproveList" style="width: 100%">
                                                <el-table-column :selectable="handleSelectable" align="center"
                                                                 type="selection" min-width="55">
                                                </el-table-column>
                                                <el-table-column align="center" prop="name" label="实验室名称"
                                                                 min-width="100">
                                                </el-table-column>
                                                <el-table-column align="center" prop="realName" label="申请人"
                                                                 min-width="100">
                                                </el-table-column>
                                                <el-table-column align="center" prop="formTime" label="申请时间段"
                                                                 min-width="200">
                                                </el-table-column>
                                                <el-table-column align="center" prop="reason" label="申请原因"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="applyTime" label="申请时间"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="statusName" label="状态"
                                                                 min-width="150">
                                                </el-table-column>
                                                <el-table-column align="center" label="操作">
                                                    <template slot-scope="scope">
                                                        <el-button @click="approve('lab',scope.row)" size="mini"
                                                                   v-if="scope.row.status===1" type="primary"> 审核
                                                        </el-button>
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
                                        <el-row v-if="multipleSelection.instrument.length>0"
                                                style="padding-bottom: 10px">
                                            <el-button type="primary" @click="allApprove('instrumentList')">全部审核
                                            </el-button>
                                        </el-row>
                                        <el-row>
                                            <el-table @selection-change="handleInstrumentSelectionChange" border
                                                      :data="instrumentApproveList" style="width: 100%">
                                                <el-table-column :selectable="handleSelectable" align="center"
                                                                 type="selection" min-width="55">
                                                </el-table-column>
                                                <el-table-column align="center" prop="name" label="仪器名称"
                                                                 min-width="100">
                                                </el-table-column>
                                                <el-table-column align="center" prop="realName" label="申请人"
                                                                 min-width="100">
                                                </el-table-column>
                                                <el-table-column align="center" prop="formTime" label="申请时间段"
                                                                 min-width="200">
                                                </el-table-column>
                                                <el-table-column align="center" prop="reason" label="申请原因"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="applyTime" label="申请时间"
                                                                 min-width="180">
                                                </el-table-column>
                                                <el-table-column align="center" prop="statusName" label="状态"
                                                                 min-width="150">
                                                </el-table-column>
                                                <el-table-column align="center" label="操作">
                                                    <template slot-scope="scope">
                                                        <el-button @click="approve('instrument',scope.row)" size="mini"
                                                                   v-if="scope.row.status===1" type="primary">审核
                                                        </el-button>
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
                                <el-dialog
                                        :title="activeName=='lab'?'实验室申请导师审核':'仪器申请导师审核'"
                                        :visible.sync="dialogVisible"
                                        width="50%">
                                    <span>
                                      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px">
                                            <el-form-item label="审批状态:" prop="isApprove">
                                                <el-radio-group v-model="ruleForm.isApprove">
                                                    <el-radio label="1">通过</el-radio>
                                                    <el-radio label="0">驳回</el-radio>
                                                </el-radio-group>
                                            </el-form-item>
                                            <el-row>
                                                <el-col :span="20" prop="reason">
                                                    <el-form-item label="驳回理由:" v-if="ruleForm.isApprove==0">
                                                        <el-input type="textarea" v-model="ruleForm.reason"></el-input>
                                                    </el-form-item>
                                                </el-col>
                                            </el-row>
                                        </el-form>
                                    </span>
                                    <span slot="footer" class="dialog-footer">
                                        <el-button @click="dialogVisible = false">取 消</el-button>
                                        <el-button @click="submitConfirm" type="primary">提 交</el-button>
                                    </span>
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
                            activeName: 'lab',
                            dialogVisible: false,
                            multipleSelection: {
                                lab: [],
                                instrument: []
                            },
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
                            ruleForm: {
                                id: '',
                                type: '',
                                isApprove: '1',
                                reason: ''
                            },
                            rules: {
                                isApprove: [
                                    {required: true}
                                ],
                                reason: []
                            },
                            instrumentApproveList: [],
                            labApproveList: [],
                            statusList: []
                        }
                    },
                    created() {
                        // this.getApplyStatusList()
                        this.getData()
                    },
                    methods: {
                        handleSelectable(row) {
                            return row && row.status === 1
                        },
                        instrumentListCurrentChange(val) {
                            this.pageInfo.instrument.page = val
                            this.getData()
                        },
                        handleInstrumentSelectionChange(val) {
                            this.multipleSelection.instrument = val
                        },
                        handleLabSelectionChange(val) {
                            this.multipleSelection.lab = val
                        },
                        allApprove(type) {
                            this.ruleForm = {
                                id: '-1',
                                type: type,
                                isApprove: '1',
                                reason: '',
                                ids: []
                            }
                            if (type === 'labList') {
                                this.multipleSelection.lab.forEach(item => {
                                    this.ruleForm.ids.push(item.id)
                                })
                            } else if (type === 'instrumentList') {
                                this.multipleSelection.instrument.forEach(item => {
                                    this.ruleForm.ids.push(item.id)
                                })
                            }
                            // // // console.log('allApprove:', this.ruleForm)
                            this.dialogVisible = true
                        },
                        approve(type, row) {
                            this.ruleForm = {
                                id: row.id,
                                type: type,
                                isApprove: '1',
                                reason: ''
                            }
                            this.dialogVisible = true
                        },
                        submitConfirm() {
                            let url = '/borrow/teacher/approve/submitApprove'
                            let _that = this
                            c.ajax({
                                url: url,
                                type: 'post',
                                dataType: 'json',
                                data: JSON.stringify(this.ruleForm),
                                cache: false,
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                success: res => {
                                    // // console.log('res:', res)
                                    if (res.code === 0) {
                                        _that.$message({type: 'success', message: res.msg})
                                        _that.dialogVisible = false
                                        _that.getData()
                                    } else {
                                        _that.$message.error(res.msg)
                                    }
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
                        formatterStatus(row) {
                            let res = ''
                            // // // console.log('row:', row)
                            if (this.statusList.length > 0 && row.status) {
                                this.statusList.forEach(item => {
                                    // // // console.log('item:', item)
                                    if (item.id === row.status) {
                                        res = item.desc
                                    }
                                })
                            }
                            return res
                        },
                        labCurrentChange(val) {
                            this.pageInfo.lab.page = val
                            this.getData()
                        },
                        getData() {
                            if (this.activeName === 'lab') {
                                this.getLabApproveList()
                            } else if (this.activeName === 'instrument') {
                                this.getInstrumentApproveList()
                            }
                        },
                        getInstrumentApproveList() {
                            let url = '/borrow/teacher/approve/getInstrumentApproveList'
                            c.get(url, {
                                page: this.pageInfo.instrument.page,
                                limit: this.pageInfo.instrument.limit
                            }, res => {
                                if (res.code === 0) {
                                    this.pageInfo.instrument.total = res.data.total
                                    this.instrumentApproveList = res.data.records
                                    if (this.instrumentApproveList.length > 0) {
                                        this.instrumentApproveList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    }
                                    if (this.instrumentApproveList.length === 0 && this.pageInfo.instrument.page > 1) {
                                        this.pageInfo.instrument.page = this.pageInfo.instrument.page - 1
                                        this.getInstrumentApproveList()
                                    }
                                }
                            })
                        },
                        getLabApproveList() {
                            let url = '/borrow/teacher/approve/getLabApproveList'
                            c.get(url, {
                                page: this.pageInfo.lab.page,
                                limit: this.pageInfo.lab.limit
                            }, res => {
                                // // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.pageInfo.lab.total = res.data.total
                                    this.labApproveList = res.data.records
                                    if (this.labApproveList.length > 0) {
                                        this.labApproveList.forEach(item => {
                                            item.formTime = item.startTime + ' - ' + item.endTime
                                        })
                                    }
                                    if (this.labApproveList.length === 0 && this.pageInfo.lab.page > 1) {
                                        this.pageInfo.lab.page = this.pageInfo.lab.page - 1
                                        this.getLabApproveList()
                                    }
                                }
                            })
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
