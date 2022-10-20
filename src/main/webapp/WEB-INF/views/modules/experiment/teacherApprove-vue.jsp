<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%--导师审批--%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>导师审批</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
    </head>
    <body>
        <%--        style="background-color: #ffffff;margin: 30px"--%>
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-row type="flex" style="margin-bottom: 20px" align="middle">
                                <el-col :offset="2" :span="10">
                                    <span style="padding-right: 10px">实验状态：</span>
                                    <el-select clearable @change="changeSelectApplyType"
                                               v-model="selectApplyType"
                                               placeholder="请选择实验状态">
                                        <el-option v-for="(item,index) in applyTypeList" v-if="item.desc!='未提交'"
                                                   :key="index" :label="item.desc"
                                                   :value="item.id">
                                        </el-option>
                                    </el-select>
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
                                                align="center" prop="name" align="center" label="申请名称" min-width="180">
                                        </el-table-column>
                                        <el-table-column
                                                align="center" prop="applyUser.realName" label="申请人">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="formatterStatus" label="状态">
                                            <template slot-scope="scope">
                                                <div v-if="scope.row.status===4">
                                                    <%-- 导师已拒绝--%>
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
                                                    <%-- 管理员已拒绝--%>
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
                                                    <el-col :span="12" v-if="scope.row.status==1">
                                                        <el-button style="width: 90%"
                                                                   @click="teacherApprove(scope.row)"
                                                                   size="mini" type="primary">审核
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
                                    title="导师审核"
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
                    // console.log('showDetail,', data)
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
                            page: 1,
                            limit: 10,
                            total: 0,
                            selectApplyType: null, //筛选的实验状态
                            tableData: [],
                            applyTypeList: [],
                            dialogVisible: false,
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
                        }
                    },
                    filters: {
                        formatterStatus2: function (row, typeList) {
                            //格式化状态显示
                            console.log('formatterStatus,row', row)
                            console.log('this.applyTypeList', typeList)
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
                    created() {
                        this.getData()
                        this.getApplyType()
                    },
                    methods: {
                        changeSelectApplyType(val) {
                            this.selectApplyType = val
                            this.getData()
                        },
                        getApplyType() {
                            let url = '/experiment/apply/getApplyType'
                            c.get(url, res => {
                                // console.log('res:', res)
                                this.applyTypeList = res.data
                            })
                        },
                        formatterStatus(row) {
                            //格式化状态显示
                            console.log('formatterStatus,row', row)
                            let str = ''
                            if (this.applyTypeList.length > 0) {
                                this.applyTypeList.forEach(item => {
                                    if (item.id === row.status) {
                                        str = item.desc
                                    }
                                })
                            }
                            return str;
                        },
                        submitConfirm() {
                            // console.log('submitConfirm:', this.selectItem)
                            //提交审核结果
                            let url = '/experiment/teacherApprove/approve/' + this.selectItem.id
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
                        teacherApprove(row) {
                            //教师审核窗口
                            this.selectItem = row
                            this.ruleForm = {
                                isApprove: '1',
                                reason: ''
                            }
                            this.dialogVisible = true
                        },
                        showApplyDetail(row) {
                            //查看实验情况
                            showDetail(row)
                        },
                        formatterApplyTime(row) {
                            // console.log('formatterApplyTime:', row)
                            if (row.applyTime) {
                                let date = new Date(row.applyTime)
                                return formatDate2(date)
                            }
                            return ''
                        },
                        currentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        getData() {
                            let url = '/experiment/teacherApprove/getApproveList'
                            c.get(url, {page: this.page, limit: this.limit, applyType: this.selectApplyType}, res => {
                                // console.log('getData:res:', res)
                                if (res.code === 0) {
                                    this.tableData = res.data.records
                                    // console.log('this.tableData:', this.tableData)
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
