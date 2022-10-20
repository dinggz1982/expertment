<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>用户管理</title>
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
                            <el-row>
                                <el-form :inline="true">
                                    <el-form-item label="学号/工号：">
                                        <el-input placeholder="输入账号" clearable v-model="username"></el-input>
                                    </el-form-item>
                                    <el-form-item label="真实姓名：">
                                        <el-input placeholder="输入真实姓名" clearable v-model="realname"></el-input>
                                    </el-form-item>
                                    <el-form-item label="班级信息:">
                                        <el-cascader :props="props" style="width: 350px"
                                                     v-model="cascaderValue"
                                                     :options="schoolTree" clearable
                                                     @change="schoolChange">
                                        </el-cascader>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button type="primary" @click="search" icon="el-icon-search">搜索
                                        </el-button>
                                        <el-button @click="addUser" type="primary" icon="el-icon-plus">添加</el-button>
                                        <el-button type="danger" @click="delSelectUser"
                                                   v-if="multipleSelection.length>0"
                                                   icon="el-icon-delete">删除选中用户
                                        </el-button>
                                        <el-button type="primary" @click="addUserRole"
                                                   v-if="multipleSelection.length>0">批量添加用户角色
                                        </el-button>
                                        <el-button type="danger" @click="deleteUserRole"
                                                   v-if="multipleSelection.length>0">批量删除用户角色
                                        </el-button>
                                    </el-form-item>
                                </el-form>
                            </el-row>
                            <el-row type="flex" style="margin-top: 10px" :gutter="8" align="middle" justify="start">
                                <el-col :span="12">
                                    <el-row type="flex" align="middle">
                                        <span>批量上传用户：</span>
                                        <el-button style="margin-left: 10px" @click="getDemo">模板下载</el-button>
                                        <el-upload style="margin-left: 10px" :show-file-list="false"
                                                   action="/index/user/importUserFromExcel"
                                                   :on-success="uploadFileSuccess" :before-upload="beforeUpload"
                                                   accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
                                            <el-button type="primary">上传文件</el-button>
                                        </el-upload>
                                        <el-button style="margin-left: 10px" @click="exportToExcel"
                                                   type="primary">导出文件
                                        </el-button>
                                    </el-row>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="margin-top: 20px">
                                <el-col>
                                    <el-table ref="table" border :data="tableData" :select-on-indeterminate="false"
                                              style="width: 100%" @selection-change="handleSelectionChange">
                                        <el-table-column
                                                type="selection"
                                                width="55">
                                        </el-table-column>
                                        <el-table-column align="center" prop="username" label="学号/工号"
                                                         min-width="80"></el-table-column>
                                        <el-table-column align="center" prop="realName" label="真实姓名"
                                                         min-width="80"></el-table-column>
                                        <el-table-column align="center" prop="birth" label="出生年月"
                                                         min-width="50"></el-table-column>
                                        <el-table-column align="center" prop="gender" label="性别"
                                                         min-width="80"></el-table-column>
                                        <el-table-column align="center" prop="identity" label="身份"
                                                         min-width="40">
                                        </el-table-column>
                                        <el-table-column align="center" label="角色" width="220">
                                            <template slot-scope="scope">
                                                <el-row type="flex" style="flex-wrap: wrap">
                                                    <el-col :span="12" :key="index"
                                                            v-for="(item,index) in scope.row.roles">
                                                        <el-tag style="width:95%;margin-left: 5px;margin-top: 5px"
                                                                type="success">
                                                            {{item.name}}
                                                        </el-tag>
                                                    </el-col>
                                                </el-row>
                                            </template>
                                        </el-table-column>
                                        <el-table-column
                                                label="操作" align="center" min-width="150" show-overflow-tooltip>
                                            <template slot-scope="scope">
                                                <el-popconfirm @confirm="confirmDelUser(scope.row)"
                                                               v-if="scope.row.id != 1"
                                                               :title="'确认要删除“' + scope.row.realName + '”吗?'">
                                                    <el-button slot="reference" size="mini" type="danger">删除</el-button>
                                                </el-popconfirm>
                                                <el-button @click="updateUser(scope.row)" size="mini">修改</el-button>
                                                <el-popconfirm @confirm="resetUserPassword(scope.row)"
                                                               :title="'确定要重置“' + scope.row.realName + '”的登录密码吗?'">
                                                    <el-button slot="reference" size="mini" type="primary">重置密码
                                                    </el-button>
                                                </el-popconfirm>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row type="flex" justify="center" style="margin-top: 20px">
                                <el-pagination
                                        @current-change="handleCurrentChange"
                                        @size-change="handleSizeChange"
                                        layout="sizes, prev, pager, next"
                                        :total="total" :current-page="page"
                                        :page-sizes="[10, 20, 50, 100]"
                                        :page-size="limit">
                                </el-pagination>
                            </el-row>
                        </el-col>
                    </el-row>

                    <el-dialog :title="title" :visible.sync="dialogVisible" width="70%" center>
                        <template>
                            <el-row type="flex" justify="center">
                                <el-col :span="22">
                                    <el-tabs v-model="activeName" type="card" @tab-click="handleClick">
                                        <el-tab-pane label="基础信息" name="base">
                                            <el-row type="flex" justify="center" style="padding-top: 10px">
                                                <el-col :span="22">
                                                    <el-form ref="form" :rules="rules" :model="form"
                                                             label-width="150px">
                                                        <el-form-item label="学号/工号" prop="username">
                                                            <el-input :disabled="isAdd==0" placeholder="请输入学号/工号"
                                                                      v-model="form.username"></el-input>
                                                        </el-form-item>
                                                        <el-form-item v-if="isAdd==1" label="密码" prop="password">
                                                            <el-input placeholder="请输入密码" type="password"
                                                                      v-model="form.password"></el-input>
                                                        </el-form-item>
                                                        <el-form-item label="真实姓名" prop="realName">
                                                            <el-input placeholder="请输入真实姓名"
                                                                      v-model="form.realName"></el-input>
                                                        </el-form-item>
                                                        <el-form-item label="邮箱">
                                                            <el-input placeholder="请输入邮箱"
                                                                      v-model="form.email"></el-input>
                                                        </el-form-item>
                                                        <el-form-item label="电话">
                                                            <el-input :maxlength="11" placeholder=" 请输入电话"
                                                                      v-model="form.tel"></el-input>
                                                        </el-form-item>
                                                        <el-form-item label="微信号">
                                                            <el-input placeholder="请输入微信号"
                                                                      v-model="form.weichat"></el-input>
                                                        </el-form-item>
                                                        <el-form-item label="出生年月">
                                                            <el-date-picker
                                                                    style="width: 100%"
                                                                    v-model="form.birth"
                                                                    type="month"
                                                                    placeholder="选择出生年月">
                                                            </el-date-picker>
                                                        </el-form-item>
                                                        <el-form-item label="身份" prop="identity">
                                                            <el-select style="width: 100%" v-model="form.identity"
                                                                       placeholder="请选择身份">
                                                                <el-option v-for="(item,index) in identities"
                                                                           :key="index"
                                                                           :label="item.name" :value="item.id">
                                                                </el-option>
                                                            </el-select>
                                                        </el-form-item>
                                                        <div v-if="form.identity=='研究生' || form.identity=='本科生'">
                                                            <el-form-item label="学校">
                                                                <el-select style="width: 100%"
                                                                           :disabled="schoolList.length==0"
                                                                           v-model="form.schoolId"
                                                                           @change="changeSchool"
                                                                           :placeholder="schoolList.length>0?'请选择学校':'暂无可选学校'">
                                                                    <el-option v-for="(item,index) in schoolList"
                                                                               :key="index"
                                                                               :label="item.name" :value="item.id">
                                                                    </el-option>
                                                                </el-select>
                                                            </el-form-item>
                                                            <el-form-item label="学院"
                                                                          v-if="form.schoolId&&form.schoolId!=''">
                                                                <el-select style="width: 100%"
                                                                           :disabled="collegeList.length==0"
                                                                           v-model="form.collegeId"
                                                                           @change="changeCollege"
                                                                           :placeholder="collegeList.length>0?'请选择学院':'暂无可选学院'">
                                                                    <el-option v-for="(item,index) in collegeList"
                                                                               :key="index"
                                                                               :label="item.name" :value="item.id">
                                                                    </el-option>
                                                                </el-select>
                                                            </el-form-item>
                                                            <el-form-item label="专业"
                                                                          v-if="form.schoolId&&form.schoolId!=''&&form.collegeId&&form.collegeId!=''">
                                                                <el-select style="width: 100%"
                                                                           :disabled="majorList.length==0"
                                                                           v-model="form.majorId" @change="changeMajor"
                                                                           :placeholder="majorList.length>0?'请选择专业':'暂无可选专业'">
                                                                    <el-option v-for="(item,index) in majorList"
                                                                               :key="index"
                                                                               :label="item.name" :value="item.id">
                                                                    </el-option>
                                                                </el-select>
                                                            </el-form-item>
                                                            <el-form-item label="班级"
                                                                          v-if="form.schoolId&&form.schoolId!=''&&form.collegeId&&form.collegeId!=''&&form.majorId&&form.majorId!=''">
                                                                <el-select style="width: 100%"
                                                                           :disabled="classList.length==0"
                                                                           v-model="form.classId"
                                                                           :placeholder="classList.length>0?'请选择班级':'暂无可选班级'">
                                                                    <el-option v-for="(item,index) in classList"
                                                                               :key="index"
                                                                               :label="item.name" :value="item.id">
                                                                    </el-option>
                                                                </el-select>
                                                            </el-form-item>
                                                            <el-form-item label="导师工号">
                                                                <el-input placeholder="请输入导师工号"
                                                                          v-model="form.teacherNo"></el-input>
                                                                <span style="color: orangered">若无导师，则填入0000，导师工号错误，无法正常申请实验</span>
                                                            </el-form-item>
                                                        </div>
                                                        <el-form-item label="性别">
                                                            <el-radio-group v-model="form.gender">
                                                                <el-radio label="男"></el-radio>
                                                                <el-radio label="女"></el-radio>
                                                            </el-radio-group>
                                                        </el-form-item>
                                                        <el-form-item label="角色" prop="roleIds">
                                                            <el-select style="width: 100%" v-model="form.roleIds"
                                                                       multiple placeholder="请选择角色">
                                                                <el-option v-for="(item,index) in roles" :key="index"
                                                                           :label="item.name" :value="item.id">
                                                                </el-option>
                                                            </el-select>
                                                        </el-form-item>
                                                    </el-form>
                                                </el-col>
                                            </el-row>
                                        </el-tab-pane>
                                        <el-tab-pane label="实验学时" name="expand">
                                            <el-row type="flex" justify="center" style="padding-top: 10px">
                                                <el-col :span="22">
                                                    <el-form label-width="150px">
                                                        <el-form-item v-for="(item,index) in expTypeList" :key="item.id"
                                                                      :label="item.name">
                                                            <el-input v-model="form.hour[item.id]"></el-input>
                                                        </el-form-item>
                                                    </el-form>
                                                </el-col>
                                            </el-row>
                                        </el-tab-pane>
                                    </el-tabs>
                                </el-col>
                            </el-row>
                        </template>
                        <span slot="footer" class="dialog-footer">
                            <el-button @click="handleCancel">取消</el-button>
                            <el-button type="primary" @click="submit">{{isAdd==1?'保存':'修改'}}</el-button>
                        </span>
                    </el-dialog>

                    <el-dialog :close-on-click-modal="false" title="以下用户名已存在" :visible.sync="existDialogVisible"
                               width="30%">
                        <span>
                            <el-row type="flex" style="flex-wrap: wrap">
                                <el-tag style="margin-top: 4px;margin-left: 4px" type="danger"
                                        v-for="(item,index) in existList"
                                        :key="index">{{item}}</el-tag>
                            </el-row>
                        </span>
                        <span slot="footer" class="dialog-footer">
                            <el-button type="primary" @click="existDialogVisibleBtn">确 定</el-button>
                        </span>
                    </el-dialog>

                    <el-dialog :close-on-click-modal="false" :visible.sync="roleUpdateShow">
                        <el-form label-width="80px">
                            <el-form-item label="角色:" prop="">
                                <el-select style="width: 100%" v-model="updateRoleIds"
                                           multiple placeholder="请选择角色">
                                    <el-option v-for="(item,index) in roles" :key="index"
                                               :label="item.name" :value="item.id">
                                    </el-option>
                                </el-select>
                            </el-form-item>
                        </el-form>
                        <div slot="footer" class="dialog-footer">
                            <el-button @click="roleUpdateShow = false">取消</el-button>
                            <el-button v-if="updateRoleIds&&updateRoleIds.length>0" type="primary"
                                       @click="submitUpdateUserRole">确认
                            </el-button>
                        </div>
                    </el-dialog>
                </el-main>
            </el-container>
        </div>
        <!-- js部分 -->
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var roles = JSON.parse(`${roles}`)

                let vue = new Vue({
                    el: '#app',
                    data() {
                        var checkEmail = (rule, value, callback) => {
                            const mailReg = /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/
                            if (!value) {
                                return callback(new Error('邮箱不能为空'))
                            }
                            setTimeout(() => {
                                if (mailReg.test(value)) {
                                    callback()
                                } else {
                                    callback(new Error('请输入正确的邮箱格式'))
                                }
                            }, 100)
                        }
                        var checkTeacherNo = (rule, value, callback) => {
                            if (!value) {
                                return callback(new Error('请输入导师工号'))
                            }
                            if (this.checkUserNameExist(value)) {
                                callback()
                            } else {
                                return callback(new Error('该导师工号不存在'))
                            }
                        }
                        return {
                            isAdd: 1,
                            title: '添加用户',
                            username: '',
                            realname: '',
                            page: 1,
                            limit: 10,
                            loading: false,
                            total: 0,
                            tableData: [],
                            activeName: 'base',
                            multipleSelection: [],
                            dialogVisible: false,
                            existDialogVisible: false,
                            schoolList: [],
                            collegeList: [],
                            majorList: [],
                            classList: [],
                            identities: [{id: '教师', name: '教师'}, {id: '研究生', name: '研究生'}, {id: '本科生', name: '本科生'}],
                            form: {
                                username: '',
                                password: '',
                                realName: '',
                                email: '',
                                tel: '',
                                weichat: '',
                                identity: '',
                                schoolId: '',
                                collegeId: '',
                                majorId: '',
                                classId: '',
                                teacherNo: '',
                                gender: '',
                                birth: '',
                                roleIds: [],
                                hour: {}
                            },
                            // form2: {
                            //     hour: {},
                            //     test: '11'
                            // },
                            rules: {
                                username: [
                                    {required: true, message: '请输入用户名', trigger: 'blur'}
                                ],
                                password: [
                                    {required: true, message: '请输入密码', trigger: 'blur'}
                                ],
                                realName: [
                                    {required: true, message: '请输入真实姓名', trigger: 'blur'}
                                ],
                                email: [
                                    {required: true, validator: checkEmail, trigger: 'blur'}
                                ],
                                tel: [
                                    {required: true, message: '请输入电话', trigger: 'blur'}
                                ],
                                birth: [
                                    {required: true, message: '请选择出生年月', trigger: 'change'}
                                ],
                                weichat: [
                                    {required: true, message: '请输入微信号', trigger: 'blur'}
                                ],
                                identity: [
                                    {required: true, message: '请选择身份', trigger: 'change'}
                                ],
                                schoolId: [
                                    {required: true, message: '请选择学校', trigger: 'change'}
                                ],
                                collegeId: [
                                    {required: true, message: '请选择学院', trigger: 'change'}
                                ],
                                majorId: [
                                    {required: true, message: '请选择专业', trigger: 'change'}
                                ],
                                classId: [
                                    {required: true, message: '请选择班级', trigger: 'change'}
                                ],
                                teacherNo: [
                                    {required: true, validator: checkTeacherNo, trigger: 'blur'}
                                ],
                                gender: [
                                    {required: true, message: '请选择性别', trigger: 'change'}
                                ],
                                roleIds: [
                                    {required: true, message: '请选择角色', trigger: 'change'}
                                ]
                            },
                            roles: roles,
                            expTypeList: [],
                            existList: [],
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
                            },
                            //批量修改用户角色
                            roleUpdateShow: false,
                            updateRoleIds: null,
                            roleUpdateType: ''
                        }
                    },
                    created() {
                        this.getData()
                        this.getSchoolList()
                        this.getExpTypeList()
                        this.getSchoolTree()
                    },
                    methods: {
                        deleteUserRole() {
                            //批量删除角色
                            this.roleUpdateType = 'delete'
                            this.updateRoleIds = null
                            this.roleUpdateShow = true
                        },
                        addUserRole() {
                            //批量添加角色
                            this.roleUpdateType = 'add'
                            this.updateRoleIds = null
                            this.roleUpdateShow = true
                        },
                        submitUpdateUserRole() {
                            this.loading = true
                            const url = '/system/user/updateUserRole'
                            if (!(this.updateRoleIds && this.updateRoleIds.length > 0)) {
                                return
                            }
                            if (!(this.multipleSelection && this.multipleSelection.length > 0)) {
                                return
                            }
                            let userIds = []
                            this.multipleSelection.forEach(item => {
                                userIds.push(item.id)
                            })
                            let data = {
                                type: this.roleUpdateType,
                                userIds: userIds,
                                roleIds: this.updateRoleIds
                            }
                            c.ajax({
                                url: url,
                                type: 'post',
                                dataType: 'json',
                                data: JSON.stringify(data),
                                cache: false,
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                success: res => {
                                    this.loading = false
                                    if (res.code === 0) {
                                        this.$message({type: 'success', message: res.msg});
                                        this.getData()
                                        this.roleUpdateShow = false
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                }
                            })
                        },
                        schoolChange(val) {
                            // console.log('schoolChange,val', val)
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
                        exportToExcel() {
                            let url = '/index/user/exportToExcel'
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click();
                        },
                        existDialogVisibleBtn() {
                            this.existDialogVisible = false
                            this.existList = []
                        },
                        dialogOpened() {
                            // console.log('dialogOpened')
                            this.$refs.expandForm.resetFields()
                        },
                        hourInputChange() {
                            // console.log('jfeiwjqiofjweoij')
                            // console.log('this.form:', this.form)
                        },
                        getExpTypeList() {
                            let url = '/experiment/type/getExpTypeList'
                            c.get(url, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    this.expTypeList = res.data
                                }
                            })
                        },
                        handleClick() {
                        },
                        getDemo() {
                            //点击导出到excel表格
                            this.loading = true
                            let url = '/index/user/getDemo'
                            let link = document.createElement('a')
                            link.style.display = 'none'
                            link.href = url
                            link.click()
                            this.loading = false
                        },
                        changeMajor(val) {
                            this.form.classId = ''
                            let url = '/org/classInfo/getByMajorId/' + val
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.classList = res.data
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        changeCollege(val) {
                            this.form.majorId = ''
                            this.form.classId = ''
                            let url = '/org/major/getByCollegeId/' + val
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.majorList = res.data
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        setFormHour() {
                            let hour = {}
                            if (this.expTypeList.length > 0) {
                                this.expTypeList.forEach((item, index) => {
                                    hour[item.id] = 0
                                })
                                this.$set(this.form, "hour", hour)
                            }
                            // this.$ref/s.expandForm.resetFields()
                            // console.log('this.form:', this.form)
                        },
                        changeSchool(val) {
                            //学校修改
                            // this.form.schoolId = val
                            this.form.collegeId = ''
                            this.form.majorId = ''
                            this.form.classId = ''
                            let url = '/org/college/getBySchoolId/' + val
                            c.get(url, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.collegeList = res.data
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        getSchoolList() {
                            let url = '/org/school/getSchoolList'
                            c.get(url, res => {
                                // // console.log('res:', res)
                                if (res.code === 0) {
                                    this.schoolList = res.data
                                }
                            })
                        },
                        handleSizeChange(val) {
                            console.log('handleSizeChange,val:', val)
                            this.limit = val
                            this.page = 1
                            console.log('page:', this.page)
                            this.getData()
                        },
                        beforeUpload(file) {
                            // // console.log('file:', file)
                            if (file.type !== 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' && file.type !== 'application/vnd.ms-excel') {
                                this.$message.error('上传的文件格式不正确')
                                return false
                            }
                            this.loading = true
                        },
                        uploadFileSuccess(res) {
                            this.loading = false
                            if (res.code === 0) {
                                this.$message({type: 'success', message: res.msg})
                            } else {
                                this.$message.error(res.msg)
                                this.existList = res.data
                                if (res.data.length > 0) {
                                    this.existDialogVisible = true
                                }
                            }
                            this.getData()
                        },
                        getUserApplyHourStatistics(id) {


                        },
                        updateUser(row) {
                            // // console.log('update user row:', row)
                            //更新用户
                            this.isAdd = 0
                            this.form.id = row.id
                            this.form.realName = row.realName
                            this.form.username = row.username
                            this.form.gender = row.gender
                            this.form.email = row.email
                            this.form.tel = row.tel
                            this.form.teacherNo = row.teacherNo
                            this.form.weichat = row.weichat
                            if (row.birth) {
                                this.form.birth = new Date(row.birth)
                            }
                            this.form.roleIds = []
                            this.form.identity = row.identity
                            this.form.schoolId = row.schoolId
                            if (row.schoolId) {
                                this.changeSchool(row.schoolId)
                            }

                            this.form.collegeId = row.collegeId
                            if (row.collegeId) {
                                this.changeCollege(row.collegeId)
                            }
                            this.form.majorId = row.majorId
                            if (row.majorId) {
                                this.changeMajor(row.majorId)
                            }
                            this.form.classId = row.classId
                            if (row.roles && row.roles.length > 0) {
                                row.roles.forEach(item => {
                                    this.form.roleIds.push(item.id)
                                })
                            }
                            // this.setFormHour()
                            let hour = {}
                            if (this.expTypeList.length > 0) {
                                // console.log('row.hourStatistics:', row.hourStatistics)
                                let hourStatistics = row.hourStatistics
                                this.expTypeList.forEach((item, index) => {
                                    if (hourStatistics.length > 0) {
                                        hourStatistics.forEach(i => {
                                            if (i.applyTypeId === item.id) {
                                                hour[item.id] = i.totalHour
                                            }
                                        })
                                    } else {
                                        hour[item.id] = 0
                                    }
                                })
                                this.$set(this.form, "hour", hour)
                            }

                            this.title = '修改用户'
                            this.activeName = 'base'
                            this.dialogVisible = true
                        },
                        handleCancel() {
                            this.dialogVisible = false
                            this.form = {
                                username: '',
                                password: '',
                                realName: '',
                                email: '',
                                tel: '',
                                weichat: '',
                                identity: '',
                                schoolId: '',
                                collegeId: '',
                                majorId: '',
                                classId: '',
                                teacherNo: '',
                                gender: '',
                                birth: '',
                                roleIds: [],
                                hour: {}
                            }
                            this.setFormHour()
                            this.activeName = 'base'
                        },
                        checkUserNameExist(username) {
                            // // console.log('checkUserNameExist')
                            let url = '/system/user/checkUsername/' + username
                            let ret = false
                            c.ajaxSettings.async = false
                            c.get(url, res => {
                                if (res.code === 0) {
                                    ret = true
                                } else {
                                    ret = false
                                }
                            })
                            c.ajaxSettings.async = true
                            // // console.log('ret:', ret)
                            return ret
                        },
                        submitUpdateUser(data) {
                            let url = '/system/user/saveOrUpdate'
                            c.post(url, data, res => {
                                // // console.log('res:', res)
                                if (res.code === 200) {
                                    this.$message({type: 'success', message: res.msg})
                                    this.dialogVisible = false
                                    //清空数据
                                    this.form = {
                                        username: '',
                                        password: '',
                                        realName: '',
                                        email: '',
                                        tel: '',
                                        weichat: '',
                                        identity: '',
                                        schoolId: '',
                                        collegeId: '',
                                        majorId: '',
                                        classId: '',
                                        teacherNo: '',
                                        gender: '',
                                        birth: '',
                                        roleIds: [],
                                        hour: {}
                                    }
                                    this.activeName = 'base'
                                    this.getData()
                                } else {
                                    this.$message.error(res.msg)
                                }
                            }, 'json')
                        },
                        submitAddUser(data) {
                            let url = "/system/user/saveOrUpdate"
                            c.post(url, data, res => {
                                // // console.log('res:', res)
                                if (res.code === 200) {
                                    this.$message({type: 'success', message: res.msg})
                                    this.dialogVisible = false
                                    //清空数据
                                    this.form = {
                                        username: '',
                                        password: '',
                                        realName: '',
                                        email: '',
                                        tel: '',
                                        weichat: '',
                                        identity: '',
                                        schoolId: '',
                                        collegeId: '',
                                        majorId: '',
                                        classId: '',
                                        teacherNo: '',
                                        gender: '',
                                        birth: '',
                                        roleIds: [],
                                        hour: {}
                                    }
                                    this.activeName = 'base'
                                    this.getData()
                                } else {
                                    this.$message.error(res.msg)
                                }
                            }, 'json')
                        },
                        submit() {
                            //保存用户
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    // alert('submit!')
                                    let userEditRoleSel = ''
                                    if (this.form.roleIds && this.form.roleIds.length > 0) {
                                        this.form.roleIds.forEach(item => {
                                            userEditRoleSel = userEditRoleSel + (item + ',')
                                        })
                                    }
                                    if (this.form.birth) {
                                        this.form.birth = this.form.birth.Format('yyyy-MM')
                                    }
                                    this.form.userEditRoleSel = userEditRoleSel.substring(0, userEditRoleSel.length - 1)
                                    if (this.isAdd) {
                                        this.submitAddUser(this.form)
                                    } else {
                                        this.submitUpdateUser(this.form)
                                    }
                                } else {
                                    return false
                                }
                            })
                        },
                        addUser() {
                            //添加用户
                            if (this.isAdd !== 1) {
                                this.form = {
                                    username: '',
                                    password: '',
                                    realName: '',
                                    email: '',
                                    tel: '',
                                    weichat: '',
                                    identity: '',
                                    schoolId: '',
                                    collegeId: '',
                                    majorId: '',
                                    classId: '',
                                    teacherNo: '',
                                    gender: '',
                                    birth: '',
                                    roleIds: []
                                }
                                this.activeName = 'base'
                                this.isAdd = 1
                            }
                            this.title = '添加用户'
                            this.setFormHour()
                            this.dialogVisible = true
                        },
                        resetUserPassword(row) {
                            let url = '/system/user/resetPassword'
                            c.post(url, {
                                id: row.id
                            }, res => {
                                if (res.code === 200) {
                                    this.$message({type: 'success', message: res.msg})
                                } else {
                                    this.$message.error(res.msg)
                                }
                            }, 'json');
                        },
                        confirmDelUser(row) {
                            //确认删除该用户
                            // // console.log('confirmDelUser,user:', row)
                            let url = '/system/user/delUser/' + row.id
                            // // console.log('url：', url)
                            c.get(url, res => {
                                if (res.code === 0) {
                                    this.$message({type: 'success', message: res.msg})
                                    this.getData()
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        delSelectUser() {
                            //删除选中用户
                            // // console.log('delSelectUser:', this.multipleSelection)
                            let ids = []
                            if (this.multipleSelection.length > 0) {
                                this.multipleSelection.forEach(item => {
                                    ids.push(item.id)
                                })
                                let url = '/system/user/delUserList'
                                let data = {ids: ids}
                                c.ajax({
                                    url: url,
                                    type: 'post',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    cache: false,
                                    headers: {
                                        'Content-Type': 'application/json'
                                    },
                                    success: res => {
                                        // // console.log('res', res)
                                        if (res.code === 0) {
                                            this.$message({type: 'success', message: res.msg});
                                            this.getData()
                                        } else {
                                            this.$message.error(res.msg)
                                        }
                                    }
                                })


                            }
                        },
                        handleSelectionChange(val) {
                            let adminRow = null
                            this.multipleSelection = val
                            if (val && val.length > 0) {
                                val.forEach(item => {
                                    if (item.id === 1) {
                                        adminRow = item
                                    }
                                })
                                // // console.log('this.multipleSelection', this.multipleSelection)
                                if (adminRow) {
                                    this.$refs.table.toggleRowSelection(adminRow, false);
                                }
                            }
                        },
                        search() {
                            //搜索按钮
                            this.page = 1
                            this.getData()
                        },
                        handleCurrentChange(val) {
                            this.page = val
                            this.getData()
                        },
                        getData() {
                            this.loading = true
                            let url = '/system/user/list.json'
                            c.get(url,
                                {
                                    page: this.page,
                                    limit: this.limit,
                                    username: this.username,
                                    realName: this.realname,
                                    ...this.classForm
                                }, res => {
                                    this.loading = false
                                    if (res.code === 0) {
                                        this.tableData = res.data
                                        this.total = res.count
                                        if (this.tableData.length === 0 && this.page > 1) {
                                            this.page = this.page - 1
                                            this.getData()
                                        }
                                    }
                                })
                        }
                    }
                })
            })
        </script>

    </body>
</html>
