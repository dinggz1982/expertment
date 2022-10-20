<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <%--    管理员审批--%>
    <head>
        <meta charset="UTF-8">
        <title>管理员审批</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
    </head>
    <body>
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-row type="flex" style="margin-bottom: 20px;padding-top: 20px" align="middle">
                                <el-col :offset="2">
                                    <span style="padding-right: 10px">实验状态：</span>
                                    <el-select clearable @change="changeSelectApplyType" v-model="selectApplyType"
                                               placeholder="请选择实验状态">
                                        <el-option v-for="(item,index) in applyTypeList" v-if="item.desc!='未提交'"
                                                   :key="index" :label="item.desc"
                                                   :value="item.id">
                                        </el-option>
                                    </el-select>
                                </el-col>
                                <el-col>
                                    <span style="padding-right: 10px">附加条件：</span>
                                    <el-input style="width: 70%" v-model="searchContent"
                                              placeholder="请输入实验名称或申请人">
                                    </el-input>
                                </el-col>
                                <el-col>
                                    <el-button type="primary" @click="find">查询</el-button>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center">
                                <el-col :span="20">
                                    <el-table border :data="tableData" style="width: 100%">
                                        <el-table-column
                                                align="center" prop="applyTime" :formatter="formatterApplyTime"
                                                label="申请时间" min-width="180">
                                        </el-table-column>
                                        <el-table-column
                                                align="center" prop="name" align="center" label="实验名称" min-width="180">
                                        </el-table-column>
                                        <el-table-column
                                                align="center" prop="applyUser.realName" label="申请人">
                                        </el-table-column>
                                        <el-table-column align="center" label="状态" width="250">
                                            <template slot-scope="scope">
                                                <div v-if="scope.row.status===4">
                                                    <%--                                        管理员已拒绝--%>
                                                    <el-popover
                                                            placement="top-start"
                                                            title="驳回理由:"
                                                            width="200"
                                                            trigger="hover">
                                                        <div style="color: red">{{scope.row.teacherReason}}</div>
                                                        <span style="color: red" slot="reference">导师驳回</span>
                                                    </el-popover>
                                                </div>
                                                <div v-else-if="scope.row.status == 3 && scope.row.isLock == '1'">
                                                    <el-popover
                                                            placement="top-start"
                                                            title="锁定理由:"
                                                            width="200"
                                                            trigger="hover">
                                                        <div style="color: red">{{scope.row.lockReason}}</div>
                                                        <span style="color: red" slot="reference">管理员已锁定</span>
                                                    </el-popover>
                                                </div>
                                                <div v-else-if="scope.row.status===5">
                                                    <%--                                        管理员已拒绝--%>
                                                    <el-popover
                                                            placement="top-start"
                                                            title="驳回理由:"
                                                            width="200"
                                                            trigger="hover">
                                                        <div style="color: red">{{scope.row.adminReason}}</div>
                                                        <span style="color: red" slot="reference">管理员驳回</span>
                                                    </el-popover>
                                                </div>
                                                <div class="cell" v-else>
                                                    {{ scope.row | formatterStatus2(applyTypeList)}}
                                                </div>
                                            </template>
                                        </el-table-column>
                                        <el-table-column label="操作" align="center" min-width="200">
                                            <template slot-scope="scope">
                                                <el-row type="flex" style="flex-wrap: wrap">
                                                    <el-col :span="12" v-if="scope.row.status==2"
                                                            style="padding-bottom: 5px">
                                                        <el-button style="width: 90%"
                                                                   @click="adminApprove(scope.row)"
                                                                   size="mini" type="primary">审核
                                                        </el-button>
                                                    </el-col>
                                                    <el-col :span="12" v-if="scope.row.status==3&&scope.row.isLock=='0'"
                                                            style="padding-bottom: 5px">
                                                        <el-button style="width: 90%"
                                                                   size="mini" @click="showLockDialog(scope.row)"
                                                                   type="danger">
                                                            锁定实验
                                                        </el-button>
                                                    </el-col>
                                                    <el-col :span="12" v-if="scope.row.status==3&&scope.row.isLock=='1'"
                                                            style="padding-bottom: 5px">

                                                        <el-popconfirm
                                                                :title="'确定要解除锁定吗?'"
                                                                @confirm="unlockExperiment(scope.row)">
                                                            <el-button style="width: 90%" slot="reference"
                                                                       type="danger" size="mini">解除锁定
                                                            </el-button>
                                                        </el-popconfirm>
                                                    </el-col>
                                                    <el-col :span="12" style="padding-bottom: 5px">
                                                        <el-button style="width: 90%"
                                                                   @click="showApplyDetail(scope.row)" size="mini">
                                                            查看实验详情
                                                        </el-button>
                                                    </el-col>
                                                </el-row>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="margin-top: 20px">
                                <el-col :span="20">
                                    <el-row type="flex" justify="center" align="middle">
                                        <el-pagination
                                                @current-change="currentChange"
                                                layout="prev, pager, next"
                                                :page-size="limit"
                                                :total="total">
                                        </el-pagination>
                                    </el-row>
                                </el-col>
                            </el-row>
                            <el-dialog
                                    title="管理员审核"
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
                            <el-dialog
                                    title="锁定理由"
                                    :visible.sync="lock.lockReasonDialogVisible"
                                    width="50%">
                                <span>
                                      <el-form label-width="100px">
                                            <el-row>
                                                <el-col :span="23" prop="reason">
                                                    <el-form-item label="锁定理由:">
                                                        <el-input type="textarea" v-model="lock.lockReason"></el-input>
                                                    </el-form-item>
                                                </el-col>
                                            </el-row>
                                        </el-form>
                                </span>
                                <span slot="footer" class="dialog-footer">
                                    <el-button @click="lock.lockReasonDialogVisible = false">取消</el-button>
                                    <el-button @click="submitLockReason()" type="primary"
                                               style="padding-right: 20px">锁定实验</el-button>
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
                var showDetail = (data) => {
                    // // console.log('showDetail,', data)
                    index.openTab({
                        title: '实验：' + data.name + '详细情况',
                        url: '/experiment/show/' + data.id,
                        end: function () {
                        }
                    });
                }

                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            lock: {
                                lockReasonDialogVisible: false,
                                lockReason: '',
                                row: null
                            },
                            page: 1,
                            limit: 10,
                            total: 0,
                            selectApplyType: null,
                            dialogVisible: false,
                            tableData: [],
                            ruleForm: {
                                isApprove: '1',
                                reason: ''
                            },
                            rules: {
                                isApprove: [
                                    {required: true}
                                ],
                                reason: []
                            },
                            selectItem: null,
                            applyTypeList: [],
                            searchContent: ''
                        }
                    }, created() {
                        this.getApplyType()
                        this.getData()
                    },
                    filters: {
                        formatterStatus2: function (row, typeList) {
                            //格式化状态显示
                            // console.log('formatterStatus,row', row)
                            // console.log('this.applyTypeList', typeList)
                            let str = ''
                            if (typeList.length > 0) {
                                typeList.forEach(item => {
                                    if (item.id === row.status) {
                                        str = item.desc
                                    }
                                })
                            }
                            return str;
                        },
                    },
                    methods: {
                        find() {
                            this.page = 1
                            this.getData()
                        },
                        unlockExperiment(row) {
                            console.log('unlockExperiment:', row)
                            let url = '/experiment/adminApprove/unlockExperiment/' + row.id
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.$message({type: 'success', message: res.msg})
                                    this.getData()
                                }
                            })
                        },
                        showLockDialog(row) {
                            this.lock.lockReason = ''
                            this.lock.lockReasonDialogVisible = true
                            this.lock.row = row
                        },
                        submitLockReason() {
                            let url = '/experiment/adminApprove/lockExperiment'
                            let data = {id: this.lock.row.id, reason: this.lock.lockReason}
                            c.ajax({
                                url: url,
                                type: 'POST',
                                dataType: 'json',
                                contentType: 'application/json',
                                data: JSON.stringify(data),
                                success: res => {
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        this.$message({type: 'success', message: res.msg})
                                        this.lock.lockReasonDialogVisible = false
                                        this.lock.lockReason = ''
                                        this.lock.row = null
                                        this.getData()
                                    }
                                }
                            })
                        },
                        submitConfirm() {
                            let url = '/experiment/adminApprove/approve/' + this.selectItem.id
                            let _that = this
                            c.get(url, {
                                approve: this.ruleForm.isApprove,
                                reason: this.ruleForm.reason
                            }, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    _that.$message({type: 'success', message: res.msg})
                                    _that.getData()
                                    _that.dialogVisible = false
                                } else {
                                    _that.$message.error(res.msg)
                                    _that.getData()
                                    _that.dialogVisible = false
                                }
                            })

                        },
                        adminApprove(row) {
                            //管理员审核窗口
                            this.selectItem = row
                            this.ruleForm = {
                                isApprove: '1',
                                reason: ''
                            }
                            this.dialogVisible = true
                        },
                        currentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        formatterApplyTime(row) {
                            // // console.log('formatterApplyTime:', row)
                            if (row.applyTime) {
                                let date = new Date(row.applyTime)
                                return formatDate2(date)
                            }
                            return ''
                        },
                        changeSelectApplyType(val) {
                            this.selectApplyType = val
                            this.getData()
                        },
                        getApplyType() {
                            let url = '/experiment/apply/getApplyType'
                            c.get(url, res => {
                                // // console.log('res:', res)
                                this.applyTypeList = res.data
                            })
                        },
                        showApplyDetail(row) {
                            //查看实验情况
                            showDetail(row)
                        },
                        getData() {
                            let url = '/experiment/adminApprove/list'
                            c.get(url, {
                                page: this.page,
                                limit: this.limit,
                                type: this.selectApplyType,
                                search: this.searchContent
                            }, res => {
                                if (res.code === 0) {
                                    this.tableData = res.data.records
                                    this.total = res.data.total
                                    if (this.tableData.length === 0 && this.page > 1) {
                                        this.page -= 1
                                        this.getData()
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
