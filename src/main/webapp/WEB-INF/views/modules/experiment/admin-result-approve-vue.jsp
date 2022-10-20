<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验时审核</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
    </head>
    <body>
        <div id="app">
            <el-container v-if="show" v-loading="loading">
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-row type="flex" justify="center" align="middle">
                                <el-col :span="22">
                                    <el-form :inline="true" class="demo-form-inline">
                                        <el-form-item label="实验名称:">
                                            <el-select @change="changeSelect" v-model="applyId" filterable
                                                       placeholder="请选择实验">
                                                <el-option label="全部" :value="-1"></el-option>
                                                <el-option v-for="(item,index) in applyList" :key="index"
                                                           :label="item.name" :value="item.id">
                                                </el-option>
                                            </el-select>
                                        </el-form-item>
                                        <el-form-item label="状态:">
                                            <el-select v-model="status" @change="statusSelect" placeholder="请选择状态">
                                                <el-option label="全部" :value="-1"></el-option>
                                                <el-option v-for="(item,index) in statusList" :key="index"
                                                           :label="item.desc" :value="item.id">
                                                </el-option>
                                            </el-select>
                                        </el-form-item>
                                        <el-form-item>
                                            <el-button @click="handleAllApproveBtn" style="margin-left: 10px"
                                                       type="primary" v-if="multipleSelection.length>0">全部审核
                                            </el-button>
                                        </el-form-item>
                                    </el-form>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center">
                                <el-col :span="22" style="margin: 10px 0;">
                                    <el-table border :data="tableData"
                                              style="width: 100%" @selection-change="handleSelectionChange">
                                        <el-table-column :selectable="rowSelectable"
                                                         type="selection"
                                                         width="55">
                                        </el-table-column>
                                        <el-table-column
                                                prop="apply.name" align="center" label="实验名称" min-width="100">
                                        </el-table-column>
                                        <el-table-column :formatter="formatterApplyType" align="center" label="实验类型"
                                                         min-width="100">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.applyUser.realName" label="主试"
                                                         min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" prop="signupUser.realName" label="被试"
                                                         min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" prop="lab.name" label="实验室" width="180">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.hours" label="设定实验时" min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" prop="realHour" label="获得实验时" min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="formatterApplyTime" label="实验时间"
                                                         width="180">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="formatterStatus" prop="status"
                                                         label="状态"
                                                         width="180">
                                        </el-table-column>
                                        <el-table-column align="center" width="250" label="操作">
                                            <template slot-scope="scope">
                                                <el-row type="flex" style="flex-wrap: wrap">
                                                    <el-col :span="12"
                                                            v-if="scope.row.status===6&&scope.row.confirmType===1">
                                                        <el-button style="width: 90%"
                                                                   @click="handleApproveBtn(scope.row)"
                                                                   type="primary"
                                                                   size="mini">
                                                            审核
                                                        </el-button>
                                                    </el-col>
                                                    <el-col :span="12">
                                                        <el-button style="width: 90%"
                                                                   @click="showApplyDetail(scope.row)"
                                                                   size="mini">
                                                            查看实验详情
                                                        </el-button>
                                                    </el-col>
                                                </el-row>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding: 10px 0;">
                                <el-pagination
                                        @current-change="handleCurrentChange"
                                        layout="prev, pager, next"
                                        :total="total"
                                        :page-size="limit">
                                </el-pagination>
                            </el-row>
                            <el-dialog
                                    title="实验结果审核"
                                    :visible.sync="dialogVisible"
                                    width="50%">
                                <span>
                                    <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="100px">
                                                <el-form-item label="审核结果:" prop="isApprove">
                                                    <el-radio-group v-model="ruleForm.isApprove">
                                                        <el-radio label="1">通过</el-radio>
                                                        <el-radio label="0">不通过</el-radio>
                                                    </el-radio-group>
                                                </el-form-item>
                <%--                                <el-row>--%>
                <%--                                    <el-col :span="20" prop="reason">--%>
                <%--                                        <el-form-item label="驳回理由:" v-if="ruleForm.isApprove==0">--%>
                <%--                                            <el-input type="textarea" v-model="ruleForm.reason"></el-input>--%>
                <%--                                        </el-form-item>--%>
                <%--                                    </el-col>--%>
                <%--                                </el-row>--%>
                                            </el-form>
                                </span>
                                <span slot="footer" class="dialog-footer">
                                    <el-button
                                            @click="dialogVisible = false">取 消</el-button>
                                    <el-button @click="submitApprove" type="primary">提 交</el-button>
                                </span>
                            </el-dialog>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
            <script>
                layui.use(['layer', 'index'], function () {
                    var c = layui.jquery;
                    var index = layui.index;
                    var statusList = JSON.parse(`${status}`)
                    var type = JSON.parse(`${type}`)
                    var showDetail = (data) => {
                        // // // console.log('showDetail,', data)
                        index.openTab({
                            title: '实验：' + data.apply.name + '详细情况',
                            url: '/experiment/show/' + data.apply.id,
                            end: function () {
                            }
                        });
                    }
                    var vue = new Vue({
                        el: '#app',
                        data() {
                            return {
                                loading: false,
                                show: false,
                                applyId: -1,
                                status: -1,
                                page: 1,
                                limit: 10,
                                total: 0,
                                applyList: [],
                                tableData: [],
                                type: type,
                                statusList: statusList,
                                multipleSelection: [],
                                dialogVisible: false,
                                ruleForm: {
                                    isApprove: '1',
                                },
                                rules: {
                                    isApprove: [
                                        {required: true}
                                    ],
                                },
                            }
                        },
                        created() {
                            this.getApproveApplyList()
                            this.getAdminApplySignUpList()
                        }, beforeMount() {
                            this.show = true
                        },
                        methods: {
                            handleApproveBtn(row) {
                                this.multipleSelection = []
                                this.multipleSelection.push(row)
                                this.ruleForm = {
                                    isApprove: '1'
                                }
                                this.dialogVisible = true
                            },
                            submitApprove() {
                                if (this.multipleSelection.length > 0) {
                                    let ids = []
                                    this.multipleSelection.forEach(item => {
                                        ids.push(item.id)
                                    })
                                    let data = {}
                                    data.ids = ids
                                    data.approve = this.ruleForm.isApprove
                                    // // // console.log('data:', JSON.stringify(data))
                                    this.submitAdminApprove(JSON.stringify(data))
                                }
                            },
                            handleAllApproveBtn() {
                                this.ruleForm = {
                                    isApprove: '1'
                                }
                                this.dialogVisible = true
                            },
                            submitAdminApprove(data) {
                                let url = '/experiment/result/approveSignUp'
                                let _that = this
                                c.ajax({
                                    url: url,
                                    type: 'post',
                                    dataType: 'json',
                                    data: data,
                                    cache: false,
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    success: res => {
                                        // // // console.log('res:', res)
                                        if (res.code === 0) {
                                            _that.$message({type: 'success', message: res.msg})
                                            _that.getAdminApplySignUpList()
                                            _that.dialogVisible = false
                                        } else {
                                            _that.$message.error(res.msg)
                                        }
                                    }
                                })
                                // c.post(url, ids, 'json', res => {
                                //     // // console.log('res:', res)
                                // })
                            },
                            rowSelectable(row) {
                                return row && row.status === 6
                            },
                            handleSelectionChange(val) {
                                this.multipleSelection = val
                            },
                            showApplyDetail(row) {
                                showDetail(row)
                            },
                            formatterStatus(row) {
                                // // console.log('formatterStatus:', row)
                                if (row.status === 2) {
                                    //主试审核通过，显示格式(审核通过，请于xx时间前往xx实验室完成实验)
                                    return '审核通过，请于' + row.expLabRecord.startTime + '前往' + row.lab.name + '完成实验'
                                }
                                if (row.status === 6) {
                                    if (row.confirmType === 1) {
                                        return '实验结果合格，获得' + row.realHour + '学时，待管理员审核后生效'
                                    } else if (row.confirmType === 2) {
                                        return '实验结果不合格，不能获得学时'
                                    }
                                }
                                if (row.status === 9) {
                                    return '爽约'
                                }
                                if (this.statusList.length > 0) {
                                    let res = ''
                                    this.statusList.forEach(item => {
                                        if (row.status === item.id) {
                                            res = item.desc
                                        }
                                    })
                                    return res
                                }
                                return ''
                            },
                            formatterApplyType(row) {
                                //   // console.log('formatterApplyType', row)
                                if (row.apply && row.apply.typeId) {
                                    let res = ''
                                    this.type.forEach(item => {
                                        if (item.id === row.apply.typeId) {
                                            res = item.name
                                        }
                                    })
                                    return res
                                }
                            },
                            formatterApplyTime(row) {
                                //格式化显示实验时间
                                //   // console.log('formatterApplyTime:,', row)
                                let res = ''
                                if (row && row.expLabRecord) {
                                    res = row.expLabRecord.startTime + ' - ' + row.expLabRecord.endTime
                                }
                                return res
                            },
                            formatterTime(row) {
                                // // console.log('formatterTime:', row)
                                if (row.expLabRecord) {
                                    return row.expLabRecord.startTime + ' - ' + row.expLabRecord.endTime
                                }
                                return ''
                            },
                            handleCurrentChange(val) {
                                this.page = val
                                this.getAdminApplySignUpList()
                            },
                            changeSelect() {
                                //修改实验名称选项
                                this.page = 1
                                this.getAdminApplySignUpList()
                            },
                            statusSelect() {
                                //修改状态
                                this.page = 1
                                this.getAdminApplySignUpList()
                            },
                            getAdminApplySignUpList() {
                                if (this.applyId) {
                                    this.loading = true
                                    let url = '/experiment/result/list/' + this.applyId + '/' + this.status
                                    c.get(url,
                                        {page: this.page, limit: this.limit},
                                        res => {
                                            this.loading = false
                                            if (res.code === 0) {
                                                this.tableData = res.data.records
                                                this.total = res.data.total
                                                if (this.tableData.length === 0 && this.page > 1) {
                                                    this.page = this.page - 1
                                                    this.getAdminApplySignUpList()
                                                }
                                            } else {
                                                this.$message.error(res.msg)
                                            }
                                        })
                                }
                            },
                            getApproveApplyList() {
                                let url = '/experiment/result/getApproveApplyList'
                                c.get(url, res => {
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.applyList = res.data
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                })
                            }
                        }
                    })
                })
            </script>
        </div>
        <!-- js部分 -->
    </body>
</html>
