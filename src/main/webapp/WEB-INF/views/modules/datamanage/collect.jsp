<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>汇总数据</title>
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
                <el-main v-loading="loading">
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22">
                            <el-row type="flex" align="middle" style="padding-top: 20px">
                                <el-col>
                                    <el-form :inline="true">
                                        <el-form-item label="班级信息:">
                                            <el-cascader :props="props" style="width: 350px"
                                                         v-model="cascaderValue"
                                                         :options="schoolTree" clearable
                                                         @change="schoolChange">
                                            </el-cascader>
                                        </el-form-item>
                                        <el-form-item label="附加条件:">
                                            <el-input @blur="find" v-model="searchContent" clearable
                                                      @keyup.enter.native="find" placeholder="请输入姓名或学号">
                                            </el-input>
                                        </el-form-item>
                                        <el-form-item>
                                            <el-button type="primary" @click="find">查询</el-button>
                                        </el-form-item>
                                        <el-form-item>
                                            <el-button @click="exportToExcel" type="success">导出excel</el-button>
                                        </el-form-item>
                                    </el-form>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="margin-top: 20px;">
                                <el-table border :data="tableList" style="width: 100%">
                                    <el-table-column align="center" label="姓名" prop="realName" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="学号" prop="username" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="年级" prop="majorName" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="班级" prop="className" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" v-for="(item,index) in cols"
                                                     :label="item.label" :prop="item.prop" :key="index" min-width="100">
                                    </el-table-column>
                                </el-table>
                            </el-row>
                            <el-row type="flex" justify="center" style="padding-top: 20px">
                                <el-pagination
                                        @current-change="handleCurrentChange"
                                        layout="prev, pager, next"
                                        :total="total"
                                        :page-size="limit">
                                </el-pagination>
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
                            loading: false,
                            searchContent: '',
                            page: 1,
                            limit: 10,
                            total: 0,
                            tableList: [],
                            cols: [],
                            schoolTree: null,
                            cascaderValue: null,
                            props: {
                                label: "name",
                                value: "id"
                            },
                            classForm: {
                                schoolId: '',
                                collegeId: '',
                                majorId: '',
                                classId: ''
                            }
                        }
                    }, created() {
                        this.getData()
                        this.getSchoolTree()
                    },
                    methods: {
                        schoolChange(val) {
                            console.log('schoolChange,val', val)
                            if (val && val.length > 0) {
                                if (val[0]) {
                                    this.classForm.schoolId = val[0]
                                }
                                if (val[1]) {
                                    this.classForm.collegeId = val[1]
                                }
                                if (val[2]) {
                                    this.classForm.majorId = val[2]
                                }
                                if (val[3]) {
                                    this.classForm.classId = val[3]
                                }
                            } else {
                                this.classForm = {}
                            }
                            this.page = 1
                        },
                        getSchoolTree() {
                            let url = '/org/school/getSchoolTree'
                            c.get(url, res => {
                                console.log('getSchoolTree:', res)
                                if (res.code === 0) {
                                    this.schoolTree = res.data
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        find() {
                            this.page = 1
                            this.getData()
                        },
                        exportToExcel() {
                            this.loading = true
                            let url = '/datamanage/collect/exportToExcel'
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click()
                            this.loading = false
                        },
                        // formatterClass(row) {
                        //     // console.log('formatterGrade:', row)
                        //     var ret = ''
                        //     if (row.classId) {
                        //         // console.log('row.signupUser.majorId:', row.signupUser.majorId)
                        //         // console.log('row.signupuser', this.majorMap)
                        //         let name = this.classMap.get(row.classId)
                        //         // console.log('name:', name)
                        //         if (name === undefined || name === null) {
                        //             let url = '/org/classInfo/getById/' + row.classId
                        //             c.ajaxSettings.async = false
                        //             c.get(url, res => {
                        //                 // console.log('org/major/getbyid :', res)
                        //                 if (res.code === 0 && res.data.name) {
                        //                     this.classMap.set(row.classId, res.data.name)
                        //                     ret = res.data.name
                        //                     // console.log('jfejwojf:', this.majorMap)
                        //                     // console.log('ret:', ret)
                        //                 }
                        //             })
                        //             c.ajaxSettings.async = true
                        //         } else {
                        //             ret = name
                        //         }
                        //     }
                        //     // console.log('jfiewjqi<, ret ', ret)
                        //     return ret
                        // },
                        // formatterGrade(row) {
                        //     // console.log('formatterGrade:', row)
                        //     var ret = ''
                        //     if (row.majorId) {
                        //         // console.log('row.signupUser.majorId:', row.signupUser.majorId)
                        //         // console.log('row.signupuser', this.majorMap)
                        //         let name = this.majorMap.get(row.majorId)
                        //         // console.log('name:', name)
                        //         if (name === undefined || name === null) {
                        //             let url = '/org/major/getById/' + row.majorId
                        //             c.ajaxSettings.async = false
                        //             c.get(url, res => {
                        //                 // console.log('org/major/getbyid :', res)
                        //                 if (res.code === 0 && res.data.name) {
                        //                     this.majorMap.set(row.majorId, res.data.name)
                        //                     ret = res.data.name
                        //                     // console.log('jfejwojf:', this.majorMap)
                        //                     // console.log('ret:', ret)
                        //                 }
                        //             })
                        //             c.ajaxSettings.async = true
                        //         } else {
                        //             ret = name
                        //         }
                        //     }
                        //     return ret
                        // },
                        handleCurrentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        getData() {
                            this.loading = true
                            let url = '/datamanage/collect/getData'
                            c.get(url, {
                                ...this.classForm,
                                page: this.page,
                                limit: this.limit,
                                content: this.searchContent
                            }, res => {
                                // console.log('res:', res)
                                this.loading = false
                                if (res.code === 0) {
                                    this.tableList = res.data.records
                                    this.total = res.data.total
                                    if (this.tableList.length > 0) {
                                        // console.log('this.tableList[0].groupByHour', this.tableList[0].groupByHour)
                                        this.cols = []
                                        this.tableList[0].groupByHour.forEach(item => {
                                            this.cols.push({prop: "hour-" + item.name, label: item.name})
                                        })
                                        this.tableList.forEach(item => {
                                            item.groupByHour.forEach(i => {
                                                let name = 'hour-' + i.name
                                                item[name] = i.realHour
                                            })
                                        })
                                        // console.log('jfeoiwjqijf:', this.tableList)
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
