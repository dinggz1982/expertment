<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%--我发布的实验--%>
<html>
    <head>
        <meta charset="UTF-8">
        <title>我发布的实验</title>
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
                            <el-row type="flex" justify="center" style="margin-bottom: 20px">
                                <el-col :span="20">
                                    <el-row type="flex" align="middle">
                                        <span>实验名称：</span>
                                        <el-col :span="5" style="margin-right: 20px">
                                            <el-input @blur="blur" v-model="applyName" placeholder="请输入实验名称"></el-input>
                                        </el-col>
                                        <el-button type="primary" @click="search">搜索</el-button>
                                        <el-button type="primary" @click="add">添加</el-button>
                                    </el-row>

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
                                                align="center" prop="name" align="center" label="申请名称" min-width="100">
                                        </el-table-column>
                                        <el-table-column
                                                align="center" prop="applyUser.realName" label="申请人" min-width="100">
                                        </el-table-column>
                                        <el-table-column align="center" label="状态" min-width="180">
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
                                        <el-table-column
                                                align="center" prop="applyNumber" label="已报名被试数" min-width="80">
                                        </el-table-column>
                                        <el-table-column
                                                align="center" prop="finishNumber" label="已完成被试数" min-width="80">
                                        </el-table-column>
                                        <el-table-column fixed="right" label="操作" align="center" min-width="200">
                                            <template slot-scope="scope">
                                                <el-row type="flex" justify="start"
                                                        style="flex-wrap: wrap;align-content: flex-start;">
                                                    <el-col :span="12" style="padding-bottom: 5px"
                                                            v-if="scope.row.status==0||scope.row.status==4||scope.row.status==5||scope.row.status==8">
                                                        <el-popconfirm
                                                                :title="'确定要提交名称为:'+scope.row.name+' 的申请吗？'"
                                                                @confirm="submitApprove(scope.row)">
                                                            <el-button style="width: 90%" slot="reference"
                                                                       type="primary" size="mini">提交审核
                                                            </el-button>
                                                        </el-popconfirm>
                                                    </el-col>
                                                    <el-col :span="12" style="padding-bottom: 5px"
                                                            v-if="scope.row.status==1||scope.row.status==2">
                                                        <el-popconfirm
                                                                :title="'确定要撤回名称为:'+scope.row.name+' 的申请吗？'"
                                                                @confirm="recall(scope.row)">
                                                            <el-button style="width: 90%" slot="reference"
                                                                       type="danger" size="mini">撤回
                                                            </el-button>
                                                        </el-popconfirm>
                                                    </el-col>
                                                    <el-col :span="12" style="padding-bottom: 5px"
                                                            v-if="scope.row.status==0||scope.row.status==4||scope.row.status==5||scope.row.status==8">
                                                        <el-button style="width: 90%" @click="updateApply(scope.row)"
                                                                   type="primary"
                                                                   size="mini">
                                                            修改实验
                                                        </el-button>
                                                    </el-col>
                                                    <el-col :span="12"
                                                            style="display:flex;padding-bottom: 5px;justify-content:center;align-items:center;">
                                                        <el-button
                                                                style="width: 90%;display:flex;justify-content:center;align-items:center;"
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
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery
                var index = layui.index
                var showDetail = (data) => {
                    // console.log('showDetail,', data)
                    index.openTab({
                        title: '实验：' + data.name + '详细情况',
                        url: '/experiment/show/' + data.id,
                        end: function () {
                        }
                    })
                }
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            page: 1,
                            applyName: '',
                            limit: 10,
                            total: 0,
                            applyTypeList: [],
                            tableData: [],
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
                        updateApply(row) {
                            var index = layui.index;
                            index.openTab({
                                title: '修改实验：' + row.name,
                                url: '/experiment/updateApply/' + row.id,
                                end: function () {
                                }
                            });
                        },
                        blur() {
                            //搜索框失去焦点
                            this.search()
                        },
                        search() {
                            this.page = 1
                            this.getData()
                        },
                        add() {
                            //添加实验
                            let v = '/experiment/add'
                            index.openTab({
                                title: '添加新实验',
                                url: v,
                                end: function () {
                                }
                            });
                        },
                        recall(row) {
                            //撤回实验
                            let url = '/experiment/apply/recall/' + row.id
                            let _that = this
                            c.get(url, res => {
                                if (res.code === 200) {
                                    _that.$message({type: 'success', message: res.msg})
                                    this.getData()
                                } else {
                                    _that.$message.error(res.msg)
                                }
                            })
                        },
                        submitApprove(row) {
                            //提交实验审核
                            // console.log('提交实验审核')
                            let url = '/experiment/apply/approve'
                            let _that = this
                            c.post(url, {id: row.id}, res => {
                                // console.log('res:', res)
                                if (res.code === 200) {
                                    _that.$message({type: 'success', message: res.msg})
                                    this.getData()
                                }
                            })

                        },
                        formatterApplyTime(row) {
                            // console.log('formatterApplyTime:', row)
                            if (row.applyTime) {
                                let date = new Date(row.applyTime)
                                return formatDate2(date)
                            }
                            return ''
                        },
                        showApplyDetail(row) {
                            //查看实验情况
                            showDetail(row)
                        },
                        currentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        getApplyType() {
                            let url = '/experiment/apply/getApplyType'
                            c.get(url, res => {
                                // console.log('res:', res)
                                this.applyTypeList = res.data
                            })
                        },
                        getData() {
                            let url = '/experiment/release/list'
                            c.get(url,
                                {page: this.page, limit: this.limit, name: this.applyName},
                                res => {
                                    // console.log('jfioejwq:', res)
                                    if (res.code === 0) {
                                        this.tableData = res.data.records
                                        this.total = res.data.total
                                        if (this.tableData.length === 0) {
                                            if (this.page > 0) {
                                                this.page -= 1
                                                this.getData()
                                            }
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
