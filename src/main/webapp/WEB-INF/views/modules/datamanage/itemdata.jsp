<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>分项数据</title>
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
                            <el-form :inline="true">
                                <el-row>
                                    <el-form-item label="实验名称:">
                                        <el-select @change="changeSelect" v-model="applyId" filterable
                                                   clearable placeholder="请选择实验名称">
                                            <el-option label="全部实验" value="-1"></el-option>
                                            <el-option v-for="(item,index) in applyList" :key="index"
                                                       :label="item.name" :value="item.id+''">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                    <el-form-item label="实验类型:">
                                        <el-select @change="changeSelectExpType" v-model="expTypeId" filterable
                                                   clearable placeholder="请选择实验类型">
                                            <el-option label="全部实验类型" value="-1"></el-option>
                                            <el-option v-for="(item,index) in expTypeList" :key="index"
                                                       :label="item.name" :value="item.id+''">
                                            </el-option>
                                        </el-select>
                                    </el-form-item>
                                    <el-form-item label="班级信息:">
                                        <el-cascader :props="props" style="width: 350px"
                                                     v-model="cascaderValue"
                                                     :options="schoolTree" clearable
                                                     @change="schoolChange">
                                        </el-cascader>
                                    </el-form-item>
                                </el-row>
                                <el-row>
                                    <el-form-item label="附加条件:">
                                        <el-input @blur="find" v-model="searchContent" clearable
                                                  @keyup.enter.native="find" placeholder="请输入学号或主试姓名">
                                        </el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button type="primary" @click="find">查询</el-button>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button @click="exportToExcel" type="success">导出excel</el-button>
                                    </el-form-item>
                                </el-row>
                            </el-form>
                            <el-row type="flex" justify="center" style="margin-top: 20px;">
                                <el-table max-height="500" height="500" border :data="dataList"
                                          style="width: 100%">
                                    <el-table-column align="center" label="实验名称" prop="apply.name" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" :formatter="formatterExpType" label="实验类型"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="设定实验时" prop="apply.hours" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="主试姓名" prop="apply.applyUser.realName"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="被试姓名" prop="signupUser.realName"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="学号" prop="signupUser.username"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="年级" :formatter="formatterGrade"
                                                     min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="班级" :formatter="formatterClass"
                                                     min-width="200">
                                    </el-table-column>
                                    <el-table-column align="center" label="参加实验时间" prop="expLabRecord.startTime"
                                                     min-width="200">
                                    </el-table-column>
                                    <el-table-column align="center" label="获得实验时" prop="realHour" min-width="100">
                                    </el-table-column>
                                    <el-table-column align="center" label="状态" :formatter="formatterStatus"
                                                     min-width="200">
                                    </el-table-column>
                                    <el-table-column align="center" min-width="150" label="操作">
                                        <template slot-scope="scope">
                                            <el-button @click="showApplyDetail(scope.row)" size="mini">查看实验详细情况
                                            </el-button>
                                        </template>
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
                var c = layui.jquery
                var index = layui.index
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
                        return {
                            loading: false,
                            searchContent: '',
                            applyId: '-1',
                            expTypeId: '-1',
                            applyList: [],
                            dataList: [],
                            page: 1,
                            limit: 10,
                            total: 0,
                            signupTypeList: [],
                            expTypeList: [],
                            classMap: new Map(),
                            majorMap: new Map(),
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
                    },
                    created() {
                        this.getApplyList()
                        this.getDataListByApplyId()
                        this.getSignUpTypeList()
                        this.getExpType()
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
                            this.getDataListByApplyId()
                        },
                        exportToExcel() {
                            //点击导出到excel表格
                            this.loading = true
                            let url = '/datamanage/itemdata/exportToExcel?applyId=' + this.applyId + '&expTypeId=' + this.expTypeId
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click()
                            this.loading = false
                        },
                        changeSelectExpType(val) {
                            this.expTypeId = val
                            this.page = 1
                            this.dataList = []
                            this.getDataListByApplyId()
                        },
                        formatterGrade(row) {
                            // console.log('formatterGrade:', row)
                            var ret = ''
                            if (row.signupUser) {
                                if (row.signupUser.majorId) {
                                    // console.log('row.signupUser.majorId:', row.signupUser.majorId)
                                    // console.log('row.signupuser', this.majorMap)
                                    let name = this.majorMap.get(row.signupUser.majorId)
                                    // console.log('name:', name)
                                    if (name === undefined || name === null) {
                                        let url = '/org/major/getById/' + row.signupUser.majorId
                                        c.ajaxSettings.async = false
                                        c.get(url, res => {
                                            // console.log('org/major/getbyid :', res)
                                            if (res.code === 0 && res.data.name) {
                                                this.majorMap.set(row.signupUser.majorId, res.data.name)
                                                ret = res.data.name
                                                // console.log('jfejwojf:', this.majorMap)
                                                // console.log('ret:', ret)
                                            }
                                        })
                                        c.ajaxSettings.async = true
                                    } else {
                                        ret = name
                                    }
                                }
                            }
                            // console.log('jfiewjqi<, ret ', ret)
                            return ret
                        },
                        formatterClass(row) {
                            // console.log('formatterGrade:', row)
                            var ret = ''
                            if (row.signupUser) {
                                if (row.signupUser.classId) {
                                    // console.log('row.signupUser.majorId:', row.signupUser.majorId)
                                    // console.log('row.signupuser', this.majorMap)
                                    let name = this.classMap.get(row.signupUser.classId)
                                    // console.log('name:', name)
                                    if (name === undefined || name === null) {
                                        let url = '/org/classInfo/getById/' + row.signupUser.classId
                                        c.ajaxSettings.async = false
                                        c.get(url, res => {
                                            // console.log('org/major/getbyid :', res)
                                            if (res.code === 0 && res.data.name) {
                                                this.classMap.set(row.signupUser.classId, res.data.name)
                                                ret = res.data.name
                                                // console.log('jfejwojf:', this.majorMap)
                                                // console.log('ret:', ret)
                                            }
                                        })
                                        c.ajaxSettings.async = true
                                    } else {
                                        ret = name
                                    }
                                }
                            }
                            // console.log('jfiewjqi<, ret ', ret)
                            return ret
                        },
                        formatterStatus(row) {
                            // console.log('formatterStatus:', row)
                            let str = ''
                            if (row.status) {
                                this.signupTypeList.forEach(item => {
                                    // console.log('item:', item)
                                    if (item.id === row.status) {
                                        str = item.desc
                                    }
                                })
                            }
                            return str
                        },
                        showApplyDetail(row) {
                            //查看实验情况
                            showDetail(row)
                        },
                        handleCurrentChange(val) {
                            this.page = val
                            this.getDataListByApplyId()
                        },
                        formatterExpType(row) {
                            // console.log('formatterExpType:', row)
                            let res = ''
                            if (row.apply && row.apply.typeId) {
                                this.expTypeList.forEach(item => {
                                    // if(item.)
                                    // console.log('item:', item)
                                    if (item.id === row.apply.typeId) {
                                        res = item.name
                                    }
                                })
                            }
                            return res
                        },
                        getApplyList() {
                            let url = '/datamanage/itemdata/getApplyList'
                            c.get(url, res => {
                                // console.log(res)
                                if (res.code === 0) {
                                    this.applyList = res.data
                                }
                            })
                        },
                        changeSelect(val) {
                            console.log('changeSelect,val', val)
                            if (val) {
                                this.applyId = val + ''
                            } else {
                                this.applyId = '-1'
                            }
                            this.dataList = []
                            this.page = 1
                            this.getDataListByApplyId()
                        },
                        getExpType() {
                            let url = '/datamanage/itemdata/getExpType'
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.expTypeList = res.data
                                }
                            })
                        },
                        getSignUpTypeList() {
                            let url = '/experiment/signup/type'
                            c.get(url, res => {
                                // console.log('getSignUpTypeList res:', res)
                                if (res.code === 0) {
                                    this.signupTypeList = res.data
                                }
                            })
                        },
                        getDataListByApplyId() {
                            this.loading = true
                            if (this.applyId !== '') {
                                let url = '/datamanage/itemdata/getDataListByApplyId/' + this.applyId
                                c.get(url, {
                                    page: this.page,
                                    limit: this.limit,
                                    search: this.searchContent,
                                    expTypeId: this.expTypeId,
                                    ...this.classForm
                                }, res => {
                                    this.loading = false
                                    // console.log('res:', res)
                                    if (res.code === 0) {
                                        this.total = res.data.total
                                        this.dataList = res.data.records
                                        // if (this.dataList.length > 0) {
                                        //     this.dataList.forEach(item => {
                                        //         item.applyUserForm = res.applyUser
                                        //     })
                                        // }
                                    }
                                })
                            }
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
