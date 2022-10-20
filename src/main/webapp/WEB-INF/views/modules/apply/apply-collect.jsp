<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验报名汇总数据</title>
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
                            <el-row style="margin-top: 20px">
                                <el-table highlight-current-row border :data="dataList" style="width: 100%">
                                    <el-table-column type="expand">
                                        <template slot-scope="props">
                                            <el-row style="margin-top: 20px;margin-bottom: 20px" type="flex"
                                                    justify="center"
                                                    v-if="props.row.recordList.length>0">
                                                <el-col :span="20">
                                                    <el-table highlight-current-row border :data="props.row.recordList"
                                                              style="width: 100%">
                                                        <el-table-column align="center" prop="time" label="时间段"
                                                                         min-width="250">
                                                        </el-table-column>
                                                        <el-table-column align="center" prop="name" label="实验室名称"
                                                                         min-width="180">
                                                        </el-table-column>
                                                        <el-table-column align="center" prop="num" label="可报名人数"
                                                                         width="100">
                                                        </el-table-column>
                                                        <el-table-column align="center" prop="alreadyNum" label="已报名人数"
                                                                         width="100">
                                                        </el-table-column>
                                                        <el-table-column align="center" prop="finishNum"
                                                                         label="已完成人数" width="100">
                                                        </el-table-column>
                                                    </el-table>
                                                </el-col>
                                            </el-row>
                                        </template>
                                    </el-table-column>
                                    <el-table-column align="center" prop="name" label="实验名称"
                                                     min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="hours" label="学时"
                                                     min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="number" label="所需被试数"
                                                     min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="applyNumber" label="已报名被试数"
                                                     min-width="180">
                                    </el-table-column>
                                    <el-table-column align="center" prop="finishNumber" label="已完成被试数"
                                                     min-width="180">
                                    </el-table-column>
                                </el-table>
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
                var c = layui.jquery;
                var index = layui.index;
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            page: 1,
                            limit: 10,
                            total: 0,
                            dataList: []
                        }
                    }, created() {
                        this.getList()
                    },
                    methods: {
                        currentChange(val) {
                            this.page = val
                            this.getList()
                        },
                        getList() {
                            let url = '/apply/collect/list'
                            c.get(url, {page: this.page, limit: this.limit}, res => {
                                console.log('res:', res)
                                if (res.code === 0) {
                                    this.dataList = res.data.records
                                    this.total = res.data.total
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
