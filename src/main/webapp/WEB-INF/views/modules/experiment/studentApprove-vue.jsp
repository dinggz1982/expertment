<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>被试审批</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <style>
            /*在Chrome下移除input[number]的上下箭头*/
            .no-number::-webkit-outer-spin-button,
            .no-number::-webkit-inner-spin-button {
                margin: 0;
                -webkit-appearance: none !important;
            }

            .no-number input[type="number"]::-webkit-outer-spin-button,
            .no-number input[type="number"]::-webkit-inner-spin-button {
                margin: 0;
                -webkit-appearance: none !important;
            }

            /*在firefox下移除input[number]的上下箭头*/
            .no-number {
                -moz-appearance: textfield;
            }

            .no-number input[type="number"] {
                -moz-appearance: textfield;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-row style="padding-top: 10px" type="flex" align="middle">
                                <el-col :offset="1">
                                    <span>实验名称：</span>
                                    <el-select @change="changeSelect" v-model="applyId" filterable placeholder="请选择实验">
                                        <el-option label="全部实验" value="-1"></el-option>
                                        <el-option v-for="(item,index) in applyList" :key="index"
                                                   :label="item.name" :value="item.id+''">
                                        </el-option>
                                    </el-select>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center"
                                    style="margin-top: 20px;padding-left: 30px;padding-right: 30px">
                                <el-table border
                                          @filter-change="filterChange"
                                          @sort-change="sortChange"
                                          :data="signUpList"
                                          style="width: 100%">
                                    <el-table-column align="center" prop="createTime" sortable="custom" label="申请时间"
                                                     :formatter="formatterCreateTime"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" prop="apply.name" label="实验名称" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" prop="lab.name" label="实验室名称" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" prop="apply.applyUser.realName"
                                                     label="主试名称"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" prop="labTime" sortable="custom"
                                                     :formatter="formatterTime"
                                                     min-width="200"
                                                     label="实验时间">
                                    </el-table-column>
                                    <el-table-column align="center" prop="signupUser.realName" label="申请人"
                                                     min-width="80">
                                        <template slot-scope="scope">
                                            <el-popover
                                                    placement="bottom" title="被试的个人信息" width="900" trigger="hover">
                                                <el-row>
                                                    <el-descriptions border :column="3">
                                                        <el-descriptions-item label="性别:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.gender?scope.row.signupUser.gender:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="微信:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.weichat!=null?scope.row.signupUser.weichat:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="电话:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.tel!=null?scope.row.signupUser.tel:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="年龄:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.age!=null?scope.row.signupUser.age:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="生日:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.birth!=null?scope.row.signupUser.birth:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="身份:">
                                                            {{scope.row.signupUser&&scope.row.signupUser.identity?scope.row.signupUser.identity:''}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="合格:">
                                                            {{scope.row.statistics.upToStandrad!=null?scope.row.statistics.upToStandrad:'0'}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="不合格:">
                                                            {{scope.row.statistics.belowGrade!=null?scope.row.statistics.belowGrade:'0'}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item label="爽约:">
                                                            {{scope.row.statistics.noShow!=null?scope.row.statistics.noShow:'0'}}
                                                        </el-descriptions-item>
                                                    </el-descriptions>
                                                </el-row>
                                                <span size="mini" slot="reference">
                                                    {{scope.row.signupUser.realName}}
                                                </span>
                                            </el-popover>
                                        </template>
                                    </el-table-column>
                                    <el-table-column align="center" label="状态"
                                                     column-key="status" :filters="statusFilters"
                                                     :formatter="formatterStatus"
                                                     width="200">
                                    </el-table-column>
                                    <el-table-column fixed="right" width="250" label="操作">
                                        <template slot-scope="scope">
                                            <el-row type="flex" style="flex-wrap: wrap">
                                                <el-col :span="12" v-if="showApproveBtn(scope.row)">
                                                    <el-button style="width: 90%"
                                                               @click="approveBtn(scope.row)"
                                                               type="primary" size="mini">审核
                                                    </el-button>
                                                </el-col>
                                                <el-col :span="12" v-if="scope.row.status==5">
                                                    <el-popover placement="top-start"
                                                                title="驳回理由:"
                                                                width="200" trigger="hover">
                                                        <%--                                        :content="scope.row.reason">--%>
                                                        <p style="color: #f78989">{{scope.row.reason}}</p>
                                                        <el-button
                                                                style="width: 90%;cursor: not-allowed;background-image: none;color: #FFF;background-color: #fab6b6; border-color: #fab6b6;"
                                                                type="danger" size="mini" slot="reference">已驳回
                                                        </el-button>
                                                    </el-popover>
                                                </el-col>
                                                <el-col :span="12" v-if="scope.row.status===2">
                                                    <el-button style="width: 90%"
                                                               @click.stop="showApplyConfirm(scope.row)"
                                                               size="mini" type="primary">实验确认
                                                    </el-button>
                                                </el-col>
                                                <el-col :span="12" v-if="scope.row.status===8">
                                                    <el-button style="width: 90%"
                                                               @click.stop="showApplyConfirm(scope.row)"
                                                               size="mini" type="primary">重新确认
                                                    </el-button>
                                                </el-col>
                                                <el-col :span="12">
                                                    <el-button style="width: 90%" @click="showApplyDetail(scope.row)"
                                                               size="mini">
                                                        查看实验详情
                                                    </el-button>
                                                </el-col>
                                            </el-row>
                                        </template>
                                    </el-table-column>
                                </el-table>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding: 20px 0;">
                                <el-pagination
                                <%--                                hide-on-single-page--%>
                                        @current-change="handleCurrentChange"
                                        layout="prev, pager, next"
                                        :total="total"
                                        :page-size="limit">
                                </el-pagination>
                            </el-row>

                            <el-dialog
                                    title="被试审核"
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
                                    <el-button
                                            @click="dialogVisible = false">取 消</el-button>
                                    <el-button type="primary" @click="handleSubmit">提 交</el-button>
                                </span>
                            </el-dialog>

                            <el-dialog
                                    title="实验确认"
                                    :visible.sync="dialogVisibleApplyConfirm"
                                    width="50%">
                                <span>
                                   <el-form :model="confirmForm" :rules="confirmFormRules" ref="confirmForm"
                                            label-width="100px">
                                        <el-form-item label="结果:" prop="confirm">
                                            <el-radio-group v-model="confirmForm.confirm">
                                                <el-radio v-for="(item,index) in applyConfirmTypeList" :key="index"
                                                          :label="item.id">{{item.desc}}</el-radio>
        <%--                                        <el-radio label="2">驳回</el-radio>--%>
        <%--                                        <el-radio label="3">驳回</el-radio>--%>
                                            </el-radio-group>
                                        </el-form-item>
                                        <el-row>
                                            <el-col :span="20">
                                                <el-form-item label="获得学时:" v-if="confirmForm.confirm==1" prop="hour">
                                                    <el-input placeholder="请输入获得的学时" class="no-number" type="number"
                                                              v-model="confirmForm.hour">
                                                    </el-input>
                                                </el-form-item>
                                            </el-col>
                                        </el-row>
                                    </el-form>
                                </span>
                                <span slot="footer" class="dialog-footer">
                                    <el-button
                                            @click="dialogVisibleApplyConfirm = false">取 消</el-button>
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
                var apply = JSON.parse(`${apply}`)


                var showDetail = (data) => {
                    // console.log('showDetail,', data)
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
                        var validateHour = (rule, value, callback) => {
                            // value = Number(value)
                            // console.log('validateHour', value)
                            // console.log('this.selectSignUpItem', this.selectSignUpItem)
                            // console.log('validateHour', typeof value)
                            //验证学时是否超出范围
                            // console.log('this.confirmForm.confirm', this.confirmForm.confirm)
                            if (this.confirmForm.confirm === 1) {
                                // console.log('this.confirmForm.confirm')
                                //合格
                                if (value === null || value === undefined || value === '') {
                                    callback(new Error("请输入学时"))
                                } else {
                                    value = Number(value)
                                    let total = Number(this.selectSignUpItem.apply.hours)
                                    // console.log('jfoeiwjq:total', total)
                                    // console.log('value', value)
                                    if (value < 0) {
                                        callback(new Error("输入的学时为负数"))
                                    } else if (total < value) {
                                        callback(new Error("输入的学时超过最大学时"))
                                    }
                                }
                            }
                            callback()
                        }
                        return {
                            dialogVisible: false,//实验审核弹框显示标识
                            dialogVisibleApplyConfirm: false,//实验确认弹框显示标识
                            applyId: '-1',
                            // applyId: '57',
                            page: 1,
                            limit: 10,
                            total: 0,
                            applyList: apply,
                            signUpList: [],
                            selectSignUpItem: null,
                            ruleForm: {
                                isApprove: '1',
                                reason: ''
                            },
                            confirmForm: {
                                confirm: null, //实验确认结果，
                                hour: null//获得实验学时
                            },
                            rules: {
                                isApprove: [
                                    {required: true}
                                ],
                                reason: []
                            },
                            confirmFormRules: {
                                confirm: [{required: true, message: '请选择实验结果', trigger: 'change'}],
                                hour: [{required: true, message: '请输入获得的学时', trigger: 'blur'}]
                            },
                            signUpTypeList: null,
                            applyConfirmTypeList: [],
                            sort: {
                                order: '',
                                prop: ''
                            },
                            statusFilters: [],
                            filterStatus: '',
                        }
                    }, created() {
                        this.getSignUpType()
                        this.getApplyConfirmType()
                        this.getData()
                    },
                    methods: {
                        filterChange(e) {
                            // console.log('e:', e)
                            this.filterStatus = e.status
                            console.log('JSON.stringify(this.filterStatus):', JSON.stringify(this.filterStatus))
                            this.getData()
                        },
                        sortChange(e) {
                            console.log('e:', e)
                            this.sort.prop = e.prop
                            if (e.order === 'ascending') {
                                this.sort.order = 'ASC'
                            } else {
                                this.sort.order = 'DESC'
                            }
                            this.getData()
                            // sort.console.log('column:', column)
                            // console.log('prop:', prop)
                            // console.log('order:', order)
                        },
                        submitConfirm() {
                            //提交实验确认
                            // console.log('fjoewjq:', this.$refs)
                            this.$refs.confirmForm.validate((valid) => {
                                if (valid) {
                                    //验证通过
                                    let url = '/experiment/studentApprove/confirmApply/' + this.selectSignUpItem.id
                                    // console.log('this.selectSignUpItem', this.selectSignUpItem)
                                    // console.log('url :', url)
                                    let _that = this
                                    c.get(url, {
                                        confirm: this.confirmForm.confirm,
                                        hour: this.confirmForm.hour
                                    }, res => {
                                        // console.log('res:', res)
                                        if (res.code === 0) {
                                            _that.$message({
                                                message: res.msg,
                                                type: 'success',
                                                onClose: () => {
                                                    _that.dialogVisibleApplyConfirm = false
                                                    this.getData()
                                                }
                                            })

                                        }
                                    })
                                    // alert('submit!')
                                    // console.log('jfeoiwqj:', this.confirmForm)
                                } else {
                                    // console.log('error submit!!')
                                    return false
                                }
                            });
                        },
                        showApplyConfirm(row) {
                            this.selectSignUpItem = row
                            this.confirmForm = {
                                confirm: null, //实验确认结果，
                                hour: null //获得实验学时
                            }
                            this.dialogVisible = false //关掉审核窗口
                            this.dialogVisibleApplyConfirm = true //打开确定实验窗口
                        },
                        formatterTime(row) {
                            // console.log('formatterTime:', row)
                            if (row.expLabRecord) {
                                return row.expLabRecord.startTime + ' - ' + row.expLabRecord.endTime
                            }
                            return ''
                        },
                        handleSubmit() {
                            // console.log('this.selectSignUpItem', this.selectSignUpItem)
                            //审核提交
                            let url = '/experiment/studentApprove/approve/' + this.selectSignUpItem.applyId + '/' + this.selectSignUpItem.signupUserId + '/' + this.selectSignUpItem.id + '/' + this.ruleForm.isApprove
                            // console.log('url:', url)
                            let _that = this
                            c.get(url, {reason: this.ruleForm.reason}, res => {
                                // console.log('jfoewjqf:res:,', res)
                                if (res.code === 0) {
                                    _that.$message({
                                        type: 'success',
                                        message: res.msg
                                    })
                                    //重新加载数据
                                    _that.getData()
                                    this.dialogVisible = false
                                }
                            })
                        },
                        showApproveBtn(row) {
                            //是否显示审核按钮
                            if (row.status === 1) {
                                return true
                            }
                            return false
                        },
                        approveBtn(row) {
                            //审核按钮
                            this.ruleForm = {
                                isApprove: '1',
                                reason: ''
                            }
                            this.selectSignUpItem = row
                            this.dialogVisibleApplyConfirm = false
                            this.dialogVisible = true
                        },
                        handleCurrentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        showApplyDetail(row) {
                            //查看实验情况
                            showDetail(row)
                        },
                        formatterStatus(row) {
                            //格式化状态
                            let res = ''
                            if (this.signUpTypeList.length > 0) {
                                this.signUpTypeList.forEach(item => {
                                    if (item.id === row.status) {
                                        res = item.desc
                                    }
                                })
                            }
                            return res
                        },
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
                        formatterCreateTime(row) {
                            // console.log('格式化申请时间：', row)
                            if (row.createTime) {
                                return this.formatDate(new Date(row.createTime))
                            }
                            return ''
                        },
                        changeSelect() {
                            // console.log('changeSelect', this.applyId)
                            this.getData()
                        },
                        getSignUpType() {
                            let url = '/experiment/signup/type/'
                            c.get(url, res => {
                                if (res.code === 0) {
                                    // console.log('getSignUpType,res:', res)
                                    this.signUpTypeList = res.data
                                    let statusFilters = []
                                    this.signUpTypeList.forEach(item => {
                                        statusFilters.push({text: item.desc, value: item.id})
                                    })
                                    this.statusFilters = statusFilters
                                }
                            })
                        },
                        getApplyConfirmType() {
                            let url = '/experiment/studentApprove/getApplyConfirmType'
                            let _that = this
                            c.get(url, res => {
                                if (res.code === 0) {
                                    _that.applyConfirmTypeList = res.data
                                }
                            })
                        },
                        getData() {
                            if (this.applyId && this.applyId !== '') {
                                let url = '/experiment/studentApprove/list'
                                c.get(url, {
                                    page: this.page,
                                    limit: this.limit,
                                    applyId: this.applyId,
                                    sortProp: this.sort.prop,
                                    sortOrder: this.sort.order,
                                    filterStatus: JSON.stringify(this.filterStatus),
                                }, res => {
                                    // console.log('getData,res:', res)
                                    if (res.code === 0) {
                                        this.signUpList = res.data.records
                                        this.total = res.data.total
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                })
                            }
                        },
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
