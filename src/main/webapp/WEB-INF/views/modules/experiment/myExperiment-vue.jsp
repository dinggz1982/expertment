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
        <div id="app" style="background-color: #ffffff;height: 100%">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22">
                            <el-row>
                                <el-col>
                                    <el-form label-width="80px">
                                        <el-form-item label="实验状态:">
                                            <el-select v-model="selectStatus" @change="statusSelectChange"
                                                       placeholder="请选择实验状态">
                                                <el-option v-for="(item,index) in statusList"
                                                           :key="index"
                                                           :label="item.desc" :value="item.id"></el-option>
                                            </el-select>
                                        </el-form-item>
                                    </el-form>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center">
                                <el-col style="margin: 10px 0">
                                    <el-table
                                            border
                                            :data="tableData"
                                            style="width: 100%">
                                        <el-table-column
                                                prop="apply.name" align="center" label="实验名称" width="180">
                                        </el-table-column>
                                        <el-table-column align="center" label="主试人" width="180">
                                            <template slot-scope="scope">
                                                <el-popover border
                                                            placement="top-start"
                                                            width="800"
                                                            trigger="hover">
                                                    <el-descriptions title="主试信息">
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser.email && scope.row.apply.applyUser.email!=''"
                                                                label="邮箱">{{scope.row.apply.applyUser.email}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser.tel && scope.row.apply.applyUser.tel!=''"
                                                                label="手机号">{{scope.row.apply.applyUser.tel}}
                                                        </el-descriptions-item>
                                                        <el-descriptions-item
                                                                v-if="scope.row.apply.applyUser.weichat && scope.row.apply.applyUser.weichat!=''"
                                                                label="微信">{{scope.row.apply.applyUser.weichat}}
                                                        </el-descriptions-item>
                                                    </el-descriptions>
                                                    <span slot="reference">{{scope.row.apply.applyUser.realName}}</span>
                                                </el-popover>
                                            </template>
                                        </el-table-column>
                                        <el-table-column align="center" prop="lab.name" label="实验室" width="180">
                                        </el-table-column>
                                        <el-table-column align="center" prop="apply.hours" label="实验时" width="180">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="formatterApplyTime" label="实验时间"
                                                         width="180">
                                        </el-table-column>
                                        <el-table-column align="center" :formatter="formatterStatus" prop="status"
                                                         label="状态"
                                                         width="180">
                                        </el-table-column>
                                        <el-table-column align="center" min-width="250" label="操作">
                                            <template slot-scope="scope">
                                                <el-button v-if="showReSignUpBtn(scope.row)" type="primary"
                                                           @click="reSignUp(scope.row)"
                                                           size="mini">
                                                    重新报名
                                                </el-button>
                                                <el-popconfirm v-if="showCancel(scope.row)"
                                                               @confirm="confirmCancel(scope.row)" title="确定取消报名该实验吗？">
                                                    <el-button size="mini" type="danger" slot="reference">取消报名
                                                    </el-button>
                                                </el-popconfirm>
                                                <el-button @click="showApplyDetail(scope.row)" size="mini">查看实验详细情况
                                                </el-button>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding: 10px 0;">
                                <el-pagination
                                <%--                        hide-on-single-page--%>
                                        @current-change="handleCurrentChange"
                                        layout="prev, pager, next"
                                        :total="total"
                                        :page-size="limit">
                                </el-pagination>
                            </el-row>
                            <el-dialog
                                    title="请选择实验时间"
                                    :visible.sync="dialogVisible"
                                    width="50%">
                    <span v-if="labRecordList.length>0">
                        <el-row v-for="(item,index) in labRecordList" :key="index" style="padding: 10px 0">
                            <el-col :span="8" :offset="2">
                                      <el-radio v-model="labRecordId" :disabled="item.num-item.alreadyNum<=0"
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
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                let statusList = JSON.parse(`${status}`)
                var showDetail = (data) => {
                    console.log('showDetail,', data)
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
                            page: 1,
                            limit: 10,
                            selectStatus: null,
                            total: 0,
                            selectItem: null,
                            dialogVisible: false,
                            labRecordList: [],
                            labRecordId: null,
                            statusList: statusList,
                            tableData: [],
                        }
                    },
                    created() {
                        this.getTableList()
                    },
                    methods: {
                        statusSelectChange() {
                            console.log('statusSelectChange')
                            //实验状态选择改变
                            this.getTableList()
                        }, showApplyDetail(row) {
                            showDetail(row)
                        }, handleCurrentChange(val) {
                            this.page = val
                            this.getTableList()
                        }, confirmCancel(row) {
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
                        }, formatterApplyTime(row) {
                            //格式化显示实验时间
                            // console.log('formatterApplyTime:,', row)
                            let res = ''
                            if (row && row.expLabRecord) {
                                res = row.expLabRecord.startTime + ' - ' + row.expLabRecord.endTime
                            }
                            return res
                        }, showCancel(row) {
                            //显示取消申请按钮
                            // console.log('showCancelSignUp,', row)
                            //是否显示取消报名
                            if (row.status && (row.status === 1 || row.status === 2)) {
                                if (row.expLabRecord) {
                                    let now = (new Date()).getTime()
                                    let start = (new Date(row.expLabRecord.startTime)).getTime()
                                    // console.log('now:', now.getTime())
                                    // console.log('start:', start.getTime())
                                    if (now > start) {
                                        //实验已经开始
                                        return false
                                    } else {
                                        // now <= start  实验还没开始
                                        let m = (start - now) / (1000 * 60)
                                        // console.log('m:', m)
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
                        }, submitSignUp() {
                            //提交报名信息
                            let url = '/experiment/signup/save/' + this.selectItem.apply.id + '/' + this.labRecordId
                            c.get(url, res => {
                                // console.log('res:', res)
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
                        }, showReSignUpBtn(row) {
                            //是否显示重新报名按钮
                            if (row.status === 4) {
                                return true
                            }
                            return false
                        }, reSignUp(row) {
                            //重新报名逻辑
                            //点击报名按钮
                            // console.log('signUp,', row)
                            this.getLabRecordList(row.apply.id)
                            //保存选择的实验信息
                            this.selectItem = row
                            //取消选择
                            this.labRecordId = null
                            this.dialogVisible = true
                        }, getLabRecordList(id) {
                            let url = '/experiment/getLabRecordByApplyId/' + id
                            c.get(url, res => {
                                // console.log('getLabRecordList', res)
                                if (res.code === 0) {
                                    this.labRecordList = []
                                    res.data.forEach(item => {
                                        // console.log('item:', item)
                                        let now = (new Date()).getTime()
                                        let start = (new Date(item.startTime)).getTime()
                                        if (now < start) {
                                            this.labRecordList.push(item)
                                        }
                                    })
                                    // this.labRecordList = res.data
                                }
                            })
                        }, formatterStatus(row) {
                            // console.log('formatterStatus:', row)
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
                        getTableList() {
                            let url = '/experiment/my/list'
                            c.get(url, {page: this.page, limit: this.limit, status: this.selectStatus},
                                res => {
                                    // console.log('getTableList:', res)
                                    if (res.code === 0) {
                                        this.tableData = res.data
                                        this.total = res.count
                                    }
                                }
                            )
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
