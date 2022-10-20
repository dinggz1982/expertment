<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>被试报名</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <style>
            #app {
                background-color: #ffffff;
            }

            .u-label {
                float: left;
                display: block;
                padding: 9px 15px;
                width: auto;
                font-weight: 400;
                line-height: 20px;
                text-align: right;
            }
        </style>
    </head>
    <body>
        <div id="app">
            <el-container v-if="show">
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-row style="padding: 20px 0" type="flex" justify="center">
                                <el-col :span="22">
                                    <el-row type="flex" justify="center">
                                        <el-col :span="9">
                                            <el-col :span="6">
                                                <label class="el-form-item__label u-label">实验状态:</label>
                                            </el-col>
                                            <el-col :span="16">
                                                <el-select style="width: 100%" v-model="selectStatus"
                                                           @change="statusSelectChange"
                                                           placeholder="请选择实验状态">
                                                    <el-option label="未报名" value="未报名">
                                                    </el-option>
                                                    <el-option v-for="(item,index) in statusList"
                                                               :key="index"
                                                               :label="item.desc" :value="item.id+''">
                                                    </el-option>
                                                </el-select>
                                            </el-col>
                                        </el-col>
                                        <el-col :span="9">
                                            <label class="el-form-item__label u-label">实验申请：</label>
                                            <el-input style="width:60%"
                                                      placeholder="请输入实验申请"
                                                      v-model="name">
                                            </el-input>
                                        </el-col>
                                        <el-col :span="6">
                                            <el-button type="primary" @click="search" plain>搜索
                                            </el-button>
                                        </el-col>
                                    </el-row>
                                </el-col>
                            </el-row>
                            <el-row>
                                <el-col :span="22" :offset="1">
                                    <el-table
                                            border
                                            highlight-current-row
                                            :data="tableData"
                                            style="width: 100%">
                                        <el-table-column prop="apply.name" label="实验名称" align="center" min-width="100">
                                        </el-table-column>
                                        <el-table-column align="center" label="主试" min-width="80">
                                            <template slot-scope="scope">
                                                <el-popover border
                                                            placement="top-start"
                                                            width="800"
                                                            trigger="hover">
                                                    <el-descriptions title="主试信息">
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser && scope.row.apply.applyUser.email && scope.row.apply.applyUser.email!=''"
                                                                label="邮箱">{{scope.row.apply.applyUser.email}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser && scope.row.apply.applyUser.tel && scope.row.apply.applyUser.tel!=''"
                                                                label="手机号">{{scope.row.apply.applyUser.tel}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser && scope.row.apply.applyUser.weichat && scope.row.apply.applyUser.weichat!=''"
                                                                label="微信">{{scope.row.apply.applyUser.weichat}}
                                                        </el-descriptions-item>
                                                    </el-descriptions>
                                                    <span slot="reference">{{scope.row.apply.applyUser.realName}}</span>
                                                </el-popover>
                                            </template>
                                        </el-table-column>
                                        <el-table-column prop="apply.type.name" align="center" label="实验类型"
                                                         min-width="100">
                                        </el-table-column>
                                        <el-table-column prop="lab.name" label="实验室" align="center" min-width="100">
                                        </el-table-column>
                                        <el-table-column prop="apply.hours" label="实验时" align="center" min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="showNum" label="剩余人数"
                                                         min-width="80">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.applyNumber" min-width="80"
                                                         label="已报名被试数">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.finishNumber" min-width="80"
                                                         label="已完成被试数">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.status" min-width="150" label="状态"
                                                         :formatter="formatterStatus">
                                        </el-table-column>
                                        <el-table-column label="操作" align="center" min-width="250">
                                            <template slot-scope="scope">
                                                <el-button v-if="showSignUp(scope.row)" type="primary"
                                                           @click="signUp(scope.row)"
                                                           size="mini">报名
                                                </el-button>
                                                <el-popover
                                                        v-if="scope.row.status==5" placement="top-start" title="驳回理由:"
                                                        width="200"
                                                        trigger="hover">
                                                    <p style="color: #f78989">{{scope.row.reason}}</p>
                                                    <el-button
                                                            style="cursor: not-allowed;background-image: none;color: #FFF;background-color: #fab6b6; border-color: #fab6b6;"
                                                            type="danger" size="mini" slot="reference">已驳回
                                                    </el-button>
                                                </el-popover>
                                                <el-popconfirm v-if="showCancelSignUp(scope.row)"
                                                               @confirm="confirmCancel(scope.row)" title="确定取消报名该实验吗?">
                                                    <el-button size="mini" type="danger" slot="reference">取消报名
                                                    </el-button>
                                                </el-popconfirm>
                                                <el-popconfirm v-if="showCancelSignUp2(scope.row)"
                                                               @confirm="confirmCancel(scope.row)"
                                                               title="取消报名会被记录爽约次数,确定取消报名该实验吗?">
                                                    <el-button size="mini" type="danger" slot="reference">取消报名
                                                    </el-button>
                                                </el-popconfirm>
                                                <%--                                <el-button v-if="showCancelSignUp(scope.row)" size="mini">取消报名</el-button>--%>
                                                <el-button @click="showApplyDetail(scope.row)" size="mini">查看实验详细情况
                                                </el-button>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding: 20px 0px">
                                <div>
                                    <el-pagination
                                            hide-on-single-page
                                            @current-change="handleCurrentChange"
                                            layout="prev, pager, next"
                                            :total="total"
                                            :page-size="limit">
                                    </el-pagination>
                                </div>
                            </el-row>
                            <el-dialog
                                    title="请选择实验时间"
                                    :visible.sync="dialogVisible"
                                    width="50%">
                                <span v-if="labRecordList.length>0">
                                    <el-row v-for="(item,index) in labRecordList" :key="index" style="padding: 10px 0">
                                        <el-col :span="8" :offset="2">
                                                  <el-radio v-model="labRecordId"
                                                            :disabled="item.num-item.alreadyNum<=0"
                                                            :label="item.id">{{item.startTime}} - {{item.endTime}} (剩余可报名人数：{{item.num-item.alreadyNum}})
                                                  </el-radio>
                                        </el-col>
                                    </el-row>
                                </span>
                                <span v-else>
                                    <el-row type="flex" justify="center">
                                        <el-col :span="12">
                                               <el-tag style="width: 100%;display: flex;justify-content: center;align-content: center"
                                                       type="danger">暂无可选择的时间段</el-tag>
                                        </el-col>
                                    </el-row>
                                </span>
                                <span slot="footer" class="dialog-footer">
                                    <el-button :disabled="labRecordId==null"
                                               type="primary"
                                               @click="submitSignUp">报名
                                    </el-button>
                                </span>
                            </el-dialog>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
    </body>
    <script>
        layui.use(['layer', 'index'], function () {
            var c = layui.jquery
            var index = layui.index
            var showDetail = (data) => {
                // // console.log('showDetail,', data)
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
                        selectStatus: '',
                        statusList: [],
                        show: false,
                        name: '',
                        tableData: [],
                        page: 1,
                        limit: 10,
                        total: 0,
                        dialogVisible: false,
                        studentSignUpType: [],
                        labRecordList: [],
                        labRecordId: null, //已选择的实验记录id
                        selectItem: null,   //已选择的实验
                    }
                },
                created() {
                    this.getStatusList()
                    this.getStudentSignUpType()
                    this.getTableList()
                },
                methods: {
                    getStatusList() {
                        let url = '/signup/getStatusList'
                        c.get(url, res => {
                            // // console.log('res:', res)
                            if (res.code === 0) {
                                this.statusList = res.data
                            }
                        })
                    },
                    statusSelectChange() {
                        this.page = 1
                        this.getTableList()
                    },
                    search() {
                        //搜索按钮
                        this.page = 1
                        this.getTableList()
                    },
                    confirmCancel(row) {
                        //确认取消
                        let url = '/experiment/cancelSignUp/' + row.id
                        c.get(url, res => {
                            if (res.code === 0) {
                                this.$message({
                                    message: res.msg,
                                    type: 'success'
                                });
                            }
                            this.getTableList()
                        })
                    },
                    submitSignUp() {
                        //提交报名信息
                        let url = '/experiment/signup/save/' + this.selectItem.apply.id + '/' + this.labRecordId
                        c.get(url, res => {
                            // // console.log('res:', res)
                            if (res.code === 0) {
                                //报名成功
                                this.$message({
                                    message: res.msg,
                                    type: 'success'
                                });
                                this.labRecordList = []
                                this.labRecordId = null
                                this.getTableList()
                                this.dialogVisible = false
                            } else {
                                //报名失败
                                this.$message.error(res.msg);
                                //重新刷新数据
                                this.getLabRecordList(this.selectItem.apply.id)
                            }
                        })
                    },
                    getLabRecordList(id) {
                        let url = '/experiment/getLabRecordByApplyId/' + id
                        c.get(url, res => {
                            // // console.log('getLabRecordList', res)
                            if (res.code === 0) {
                                this.labRecordList = []
                                res.data.forEach(item => {
                                    // // console.log('item:', item)
                                    let now = (new Date()).getTime()
                                    let start = (new Date(item.startTime)).getTime()
                                    if (now < start) {
                                        this.labRecordList.push(item)
                                    }
                                })
                                // this.labRecordList = res.data
                            }
                        })
                    },
                    signUp(row) {
                        //点击报名按钮
                        // // console.log('signUp,', row)
                        this.getLabRecordList(row.apply.id)
                        //保存选择的实验信息
                        this.selectItem = row
                        //取消选择
                        this.labRecordId = null
                        this.dialogVisible = true
                    },
                    showCancelSignUp(row) {
                        // // console.log('showCancelSignUp,', row)
                        //是否显示取消报名(主试审核通过，未进行实验 状态)
                        if (row.status && row.status === 1) {
                            if (row.expLabRecord) {
                                let now = (new Date()).getTime()
                                let start = (new Date(row.expLabRecord.startTime)).getTime()
                                // // console.log('now:', now.getTime())
                                // // console.log('start:', start.getTime())
                                if (now > start) {
                                    //实验已经开始
                                    return false
                                } else {
                                    // now <= start  实验还没开始
                                    let m = (start - now) / (1000 * 60)
                                    // // console.log('m:', m)
                                    if (m > 30) {
                                        return true
                                    } else {
                                        return false
                                    }
                                }
                            }
                            return false
                        }
                        return false
                    },
                    showCancelSignUp2(row) {
                        // // console.log('showCancelSignUp,', row)
                        //是否显示取消报名(通过主试审核状态)
                        if (row.status && row.status === 2) {
                            return true
                        }
                        return false
                    },
                    getStudentSignUpType() {
                        let url = '/experiment/signup/type/'
                        c.get(url, res => {
                            // // console.log('getStudentSignUpType,', res)
                            if (res.code === 0) {
                                this.studentSignUpType = res.data
                            }
                        })
                    },
                    formatterStatus(row) {
                        //显示状态中文名称
                        // console.log('formatterStatus:row,', row)
                        if (row.status === null) {
                            return '未报名'
                        }
                        if (row.status === 2) {
                            //主试审核通过，显示格式(审核通过，请于xx时间前往xx实验室完成实验)
                            return '审核通过，请于' + row.expLabRecord.startTime + '前往' + row.lab.name + '实验室完成实验'
                        }
                        if (row.status === 6) {
                            //
                            if (row.confirmType === 1) {
                                return '实验结果合格，获得' + row.realHour + '学时，待管理员审核后生效'
                            } else if (row.confirmType === 2) {
                                return '实验结果不合格，不能获得学时'
                            }
                        }
                        if (row.status === 9) {
                            return '爽约'
                        }
                        let res = ''
                        this.studentSignUpType.forEach(item => {
                            // // console.log('item:', item)
                            if (row.status === item.id) {
                                res = item.desc
                            }
                        })
                        return res
                    },
                    showNum(row) {
                        //显示剩余人数
                        return row.apply.number - row.apply.applyNumber
                    },
                    showApplyDetail(row) {
                        showDetail(row)
                    },
                    handleCurrentChange(val) {
                        this.page = val
                        this.getTableList()
                    },
                    showSignUp(row) {
                        if (row.status === null || row.status === 4) {
                            if (row.availableNum > 0) {
                                return true
                            }
                        }
                        return false
                    },
                    getTableList() {
                        if (this.selectStatus === null || this.selectStatus === '') {
                            // console.log('getTableList ,null ')
                            let url = '/experiment/signup/list.json?page=' + this.page + '&limit=' + this.limit + '&name=' + this.name
                            c.get(url, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.tableData = res.data
                                    this.total = res.count
                                }
                                this.show = true
                            })
                        } else {
                            // console.log('get Table list, data :', this.selectStatus)
                            let url = '/signup/getSignUpListByStatus'
                            c.get(url, {page: this.page, limit: this.limit, status: this.selectStatus}, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    this.tableData = res.data.records
                                    this.total = res.data.total
                                }
                                this.show = true
                            })
                        }
                    }
                }
            })
        })
    </script>

</html>
