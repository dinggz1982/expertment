<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>完善个人信息</title>
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
        <div id="app" v-loading="loading">
            <el-container>
                <el-main>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col :span="22" style="padding-top: 20px">
                            <el-form ref="form" :rules="rules" :model="form" label-width="150px">
                                <el-form-item v-if="false" label="密码" prop="password">
                                    <el-input placeholder="请输入密码" type="password"
                                              v-model="form.password"></el-input>
                                </el-form-item>
                                <el-form-item label="性别" prop="gender">
                                    <el-radio-group v-model="form.gender">
                                        <el-radio label="男"></el-radio>
                                        <el-radio label="女"></el-radio>
                                    </el-radio-group>
                                </el-form-item>
                                <el-form-item label="年龄" prop="age">
                                    <el-input placeholder="请输入年龄" v-model="form.age"></el-input>
                                </el-form-item>
                                <el-form-item
                                        label="邮箱" prop="email">
                                    <el-input placeholder="请输入邮箱" v-model="form.email"></el-input>
                                </el-form-item>
                                <el-form-item
                                        label="电话" prop="tel">
                                    <el-input :maxlength="11" placeholder=" 请输入电话"
                                              v-model="form.tel"></el-input>
                                </el-form-item>
                                <el-form-item
                                        label="微信号" prop="weichat">
                                    <el-input placeholder="请输入微信号" v-model="form.weichat"></el-input>
                                </el-form-item>
                                <el-form-item label="班级" v-if="user.identity==='研究生'||user.identity==='本科生'">
                                    <el-cascader :props="props" style="width: 100%"
                                                 v-model="cascaderValue"
                                                 :options="schoolTree" clearable
                                                 @change="schoolChange">
                                    </el-cascader>
                                </el-form-item>
                                <el-form-item v-if="checkRoleteacherNo()" label="导师工号" prop="teacherNo">
                                    <el-input placeholder="请输入导师工号" v-model="form.teacherNo"></el-input>
                                    <span style="color: orangered">若无导师，则填入0000，导师工号错误，无法正常申请实验</span>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="submit">保存个人信息</el-button>
                                </el-form-item>
                            </el-form>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var user = JSON.parse(`${user}`)
                console.log('user:', user)
                var vue = new Vue({
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
                            user: user,
                            props: {
                                label: "name",
                                value: "id"
                            },
                            loading: false,
                            schoolTree: null,
                            cascaderValue: null,
                            form: {
                                email: user.email,
                                tel: user.tel,
                                weichat: user.weichat,
                                teacherNo: user.teacherNo,
                                password: '',
                                gender: user.gender,
                                age: user.age,
                                schoolId: user.schoolId,
                                majorId: user.majorId,
                                collegeId: user.collegeId,
                                classId: user.classId
                            },
                            rules: {
                                password: [],
                                email: [{required: true, validator: checkEmail, trigger: 'blur'}],
                                tel: [{required: true, message: '请输入电话', trigger: 'blur'}],
                                weichat: [{required: true, message: '请输入微信号', trigger: 'blur'}],
                                teacherNo: [{required: true, validator: checkTeacherNo, trigger: 'blur'}],
                                age: [{required: true, message: '请输入年龄', trigger: 'blur'}],
                                gender: [{required: true, message: '请选择性别', trigger: 'change'}]
                            }
                        }
                    },
                    async created() {
                        console.log('this.user', this.user)
                        this.loading = true
                        await this.getSchoolTree()
                        if (this.user) {
                            // if(this.user)
                            let val = []
                            if (this.user.schoolId) {
                                val.push(this.user.schoolId + '')
                                if (this.user.collegeId) {
                                    val.push(this.user.collegeId + '')
                                    if (this.user.majorId) {
                                        val.push(this.user.majorId + '')
                                        if (this.user.classId) {
                                            val.push(this.user.classId + '')
                                        }
                                    }
                                }
                                this.cascaderValue = val
                            }
                        }
                        this.loading = false
                    },
                    methods: {
                        schoolChange(val) {
                            console.log('schoolChange:', val)
                            if (val && val.length > 0) {
                                if (val[0]) {
                                    this.form.schoolId = val[0]
                                }
                                if (val[1]) {
                                    this.form.collegeId = val[1]
                                }
                                if (val[2]) {
                                    this.form.majorId = val[2]
                                }
                                if (val[3]) {
                                    this.form.classId = val[3]
                                }
                            } else {
                                console.log('else')
                                this.form = {}
                            }
                            console.log('change ,form:', this.form)
                        },
                        async getSchoolTree() {
                            let url = '/org/school/getSchoolTree'
                            await c.get(url, res => {
                                console.log('getSchoolTree:', res)
                                if (res.code === 0) {
                                    this.schoolTree = res.data
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        checkRoleteacherNo() {
                            // console.log('checkrole')
                            if (this.user.identity === '本科生' || this.user.identity === '研究生') {
                                return true
                            }
                            let roles = this.user.roles
                            let isShow = false
                            if (roles && roles.length > 0) {
                                roles.forEach(item => {
                                    if (item.id === 4 || item.id === 5) {
                                        //主试和被试有显示
                                        isShow = true
                                    }
                                })
                            }
                            return isShow
                        },
                        submit() {
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    let url = "/system/user/saveUserInfo"
                                    c.post(url, this.form, res => {
                                        // // console.log('res:', res)
                                        if (res.code === 0) {
                                            this.$message.success('保存成功')
                                            setTimeout(() => {
                                                top.layui.index.loadHome({
                                                    menuPath: '/experiment/my/index',
                                                    menuName: '<i class="layui-icon layui-icon-home"></i>'
                                                });
                                                index.closeTab('/system/user/updateUserInfoPage')
                                            }, 2000)

                                            // top.layui.index.closeTab('/system/user/updateUserInfoPage')
                                        } else {
                                            this.$message.error(res.msg)
                                        }
                                    })
                                } else {
                                    return false
                                }
                            })
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
                        }
                        ,
                    }
                })
            })
        </script>
    </body>
</html>
