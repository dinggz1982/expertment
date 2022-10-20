<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>添加新实验</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>

        <style>
            #app {
                margin: 20px 100px;
                background-color: #ffffff;
                padding: 20px 100px;
            }

            .sign-up-list {
                margin-top: 10px;
            }

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
        <div id="app" v-loading="loading">
            <el-form ref="form" :model="form" :rules="rules" label-width="200px">
                <el-form-item label="" v-show="false">
                    <el-input v-model="form.id" v-show="false"></el-input>
                </el-form-item>
                <el-form-item label="" v-show="false">
                    <el-input v-model="form.applyUserId" v-show="false"></el-input>
                </el-form-item>
                <el-form-item label="申请人" prop="applyUserName">
                    <el-input type="text" maxlength="50"
                              disabled placeholder="请输入申请人姓名" v-model="form.applyUserName">
                    </el-input>
                </el-form-item>
                <el-form-item>
                    <el-alert :closable="false" type="error">
                        <div slot="title">
                            请加入QQ群“11335398”，并填写研究信息评估表(
                            <el-link target="_blank" type="primary"
                                     href="https://docs.qq.com/form/page/DRElUUllpdGVkcUZL">
                                https://docs.qq.com/form/page/DRElUUllpdGVkcUZL
                            </el-link>
                            )
                        </div>
                    </el-alert>
                </el-form-item>
                <el-form-item label="实验名称" prop="name">
                    <el-input :disabled="onlyShow" type="text" maxlength="150" placeholder="实验名称需能表达实验的主要内容，不能输入一个泛泛的名称"
                              v-model="form.name">
                    </el-input>
                </el-form-item>
                <el-form-item label="实验室" prop="labId">
                    <el-col :span="24">
                        <el-select :disabled="onlyShow" style="width: 100%" v-model="form.labId" placeholder="请选择实验室">
                            <el-option v-for="(item,index) in labs" :key="index" :label="item.name"
                                       :value="item.id">
                            </el-option>
                        </el-select>
                    </el-col>
                </el-form-item>
                <el-form-item label="实验室名称" v-if="form.labId==4">
                    <el-input :disabled="onlyShow" type="text" maxlength="50" placeholder="请输入实验室名称"
                              v-model="form.customize">
                    </el-input>
                </el-form-item>
                <el-form-item label="实验类型" prop="typeId">
                    <el-col :span="24">
                        <el-select :disabled="onlyShow" style="width: 100%" v-model="form.typeId" placeholder="请选择实验类型">
                            <el-option v-for="(item,index) in expTypeList" :key="index" :label="item.name"
                                       :value="item.id">
                            </el-option>
                        </el-select>
                    </el-col>
                </el-form-item>

                <el-form-item label="实验时" prop="hours">
                    <el-input :disabled="onlyShow" class="no-number" type="number" maxlength="20"
                              placeholder="请根据实验所需时间如实填写，不足0.5小时计为0.5小时，多填写不批"
                              v-model="form.hours">
                    </el-input>
                </el-form-item>
                <el-form-item label="所需被试数" prop="number">
                    <el-input :disabled="onlyShow" class="no-number" type="number" maxlength="20" placeholder="请输入实验时"
                              v-model="form.number">
                    </el-input>
                </el-form-item>
                <el-form-item label="被试可实验时间段" prop="signUpList">
                    <el-row class="sign-up-list" v-for="(item,index) in signUpList" :key="index"
                            style="display: flex;align-content: center;">
                        <el-col :span="12">
                            <el-date-picker type="datetimerange" placeholder="请选择"
                                            :disabled="onlyShow&&notEdit" format="yyyy-MM-dd HH:mm"
                                            v-model="item.time"
                                            value-format="yyyy-MM-dd HH:mm"
                                            style="width: 100%;">
                            </el-date-picker>
                        </el-col>
                        <el-col :span="12">
                            <div style="display: flex;align-content: center;justify-content: flex-end">
                                <div style="padding-right: 30px">可报名人数：</div>
                                <el-col :span="8">
                                    <el-input class="no-number" @blur="inputBlur" type="number"
                                              :disabled="onlyShow&&notEdit"
                                              v-model="item.num" placeholder="">
                                    </el-input>
                                </el-col>
                                <div style="padding-left: 30px">
                                    <el-button v-if="!onlyShow||!notEdit" type="danger" @click="delList(index)"
                                               icon="el-icon-delete"
                                               circle>
                                    </el-button>
                                </div>
                            </div>
                        </el-col>
                    </el-row>
                    <el-row style="margin-top: 10px;display: flex;justify-content: center">
                        <el-col :span="24">
                            <el-button @click="addList" style="width: 100%" v-if="!onlyShow||!notEdit">+</el-button>
                        </el-col>
                    </el-row>
                </el-form-item>
                <el-form-item label="实验简介" prop="description">
                    <el-input :disabled="onlyShow" type="textarea" maxlength="255"
                              placeholder="此部分用于向被试介绍研究内容，需要明确描述实验对被试的要求，任务以及所需要的时间"
                              v-model="form.description">
                    </el-input>
                </el-form-item>
                <el-form-item v-if="!onlyShow">
                    <el-button type="primary" @click="onSubmit">提交</el-button>
                    <el-button @click="cancel">取消</el-button>
                </el-form-item>
                <el-form-item v-if="onlyShow&&form.applyUserId==currentUserId">
                    <el-button type="primary" v-if="notEdit" @click="editDateList">修改时间段</el-button>
                    <el-button type="primary" v-if="!notEdit" @click="subUpdateDateList">提交</el-button>
                </el-form-item>
            </el-form>
        </div>
        <script>
            layui.use(['layer', 'index', 'admin'], function () {
                var c = layui.jquery;
                var k = layui.admin;
                var index = layui.index;
                let currentUserId = `${currentUser.id}`
                // console.log('jfiejwq:', currentUserId)
                let applyId = `${applyId}`
                let onlyShow = `${onlyShow}`
                // console.log('applyId:', applyId)
                let realName = `${currentUser.realName}`
                var close = function (id) {
                    let v
                    if (id) {
                        v = '/experiment/updateApply/' + id
                    } else {
                        v = '/experiment/add'
                    }
                    index.closeTab(v);
                }
                var vue = new Vue({
                    el: '#app',
                    data() {
                        var validateSignUpList = (rule, value, callback) => {
                            if (this.signUpList.length !== 0) {
                                this.signUpList.forEach(item => {
                                    if (item.time == null && item.num == null) {
                                        callback(new Error("时间段不能为空"))
                                    }
                                    if (item.time == null || item.num == null) {
                                        callback(new Error("时间段设置不完整"))
                                    }
                                })
                                callback()
                            }
                        };
                        return {
                            loading: false,
                            applyId: applyId,
                            c: c,
                            onlyShow: false,
                            isUpdate: false,
                            labs: [],
                            notEdit: true,
                            currentUserId: currentUserId,
                            signUpList: [], //申请 实验室 时间、人数 列表
                            expTypeList: [],
                            teamTypeList: [],
                            form: {
                                id: null,
                                applyUserId: currentUserId,
                                applyUserName: realName,
                                name: null,
                                labId: null,
                                typeId: null,
                                hours: null,
                                onlyShow: false,
                                number: 0,
                                customize: '',
                                // teamId: null,
                                // dateTimes: null,
                                dateTime: null,
                                // teamYearStart: null,
                                // teamYearEnd: null,
                                description: '',
                                labSignUpList: []
                            },
                            rules: {
                                applyUserName: [
                                    {required: true, message: '请输入申请人', trigger: 'blur'}
                                ],
                                name: [
                                    {required: true, message: '请输入实验名称', trigger: 'blur'},
                                    {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
                                ],
                                labId: [
                                    {required: true, message: '请选择实验室', trigger: 'change'}
                                ],
                                typeId: [
                                    {required: true, message: '请选择实验类型', trigger: 'change'}
                                ],
                                hours: [
                                    {required: true, message: '请输入实验时', trigger: 'blur'},
                                    {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
                                ],
                                number: [
                                    {required: true, message: '请输入所需被试数', trigger: 'blur'},
                                    {min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur'}
                                ],
                                // teamId: [
                                //     {required: true, message: '请选择学期', trigger: 'change'}
                                // ],
                                // dateTimes: [
                                //     {required: true, message: '请选择有效期', trigger: 'change'}
                                // ],
                                description: [
                                    {required: true, message: '请输入实验简介', trigger: 'blur'}
                                ],
                                // teamYear: [
                                //     {required: true, validator: validateTeamYearStart, trigger: 'change'}
                                // ],
                                signUpList: [
                                    {required: true, validator: validateSignUpList, trigger: 'change'}
                                ]
                            }
                        }
                    },
                    created() {
                        this.getLabList()
                        this.getExpTypeList()
                        // this.getTeamTypeList()
                        if (onlyShow && onlyShow === '1') {
                            this.onlyShow = true
                        }
                        if (this.applyId != null && this.applyId !== '') {
                            //回显数据
                            this.reloadData()
                            this.isUpdate = true
                        } else {
                            this.initData()
                        }
                        // console.log('currentUserId:', this.currentUserId)
                    },
                    methods: {
                        subUpdateDateList() {
                            //提交时间段修改
                            let url = '/experiment/apply/updateLabRecordList/' + this.form.id + '/' + this.form.labId
                            let res = []
                            if (this.signUpList.length > 0) {
                                this.signUpList.forEach(item => {
                                    res.push({
                                        id: item.id,
                                        num: item.num,
                                        startTime: item.time[0],
                                        endTime: item.time[1],
                                    })
                                })
                            }
                            let _that = this
                            let data = JSON.stringify(res)
                            // c.post(url, data, res => {
                            //     console.log('res:', res)
                            // })
                            c.ajax({
                                url: url,
                                type: 'post',
                                dataType: 'json',
                                data: data,
                                cache: false,
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                success: function (res) {
                                    console.log(res)
                                    if (res.code === 0) {
                                        _that.$message({
                                            type: 'success',
                                            message: res.msg
                                        })
                                        //更新成功
                                        _that.notEdit = true
                                        _that.reloadData()
                                    } else {
                                        _that.$message.error(res.msg)
                                    }
                                },
                                error: function (e) {
                                    _that.$message.error(e)
                                }
                            })
                        },
                        editDateList() {
                            //修改时间段
                            this.notEdit = false
                        },
                        inputBlur() {
                            // //输入框失去焦点
                            // if (this.signUpList.length > 0) {
                            //     let sum = 0
                            //     this.signUpList.forEach(item => {
                            //         if (item.num) {
                            //             sum += parseInt(item.num)
                            //         }
                            //     })
                            //     this.form.number = sum + ''
                            // }
                        },
                        initData() {
                            // let date = new Date()
                            // // this.form.teamYearStart = date.getFullYear() + ''
                            // this.form.teamYearEnd = date.getFullYear() + 1 + ''
                            // console.log('fjeiowq:', this.form)
                        },
                        reloadData() {
                            let url = '/experiment/getById/' + this.applyId
                            c.get(url, res => {
                                // console.log('res:', res)
                                if (res.code === 0) {
                                    // let s = res.data.teamYear.split('-')
                                    // this.form.teamYearStart = s[0]
                                    // this.form.teamYearEnd = s[1]
                                    this.form.description = res.data.description
                                    // this.form.teamId = res.data.teamId
                                    this.form.number = res.data.number + ''
                                    this.form.hours = res.data.hours + ''
                                    this.form.typeId = res.data.typeId
                                    this.form.labId = res.data.labId
                                    this.form.id = res.data.id
                                    this.form.name = res.data.name
                                    this.form.customize = res.data.customize
                                    this.form.applyUserId = res.data.applyUserId
                                    // this.form.dateTimes = []
                                    // this.form.dateTimes[0] = this.formatDate2(new Date(res.data.startDate))
                                    // this.form.dateTimes[1] = this.formatDate2(new Date(res.data.endDate))
                                    this.form.applyUserName = res.data.applyUser.realName
                                    if (res.data.expLabRecordList && res.data.expLabRecordList.length > 0) {
                                        this.signUpList = []
                                        res.data.expLabRecordList.forEach(item => {
                                            // console.log('item,', item)
                                            let time = []
                                            time.push(item.startTime)
                                            time.push(item.endTime)
                                            this.signUpList.push({time: time, num: item.num, id: item.id})
                                        })
                                    }
                                }
                            })
                        },
                        delList(index) {
                            this.signUpList.splice(index, 1);
                            // console.log('del list:', this.signUpList)
                        },
                        addList() {
                            this.signUpList.push({time: null, num: null})
                        },
                        getTeamTypeList() {
                            c.get('/experiment/getTeamType', res => {
                                if (res.code === 0) {
                                    this.teamTypeList = res.data
                                }
                            })
                        },
                        cancel() {
                            if (this.isUpdate) {
                                close(this.applyId)
                            } else {
                                close()
                            }
                        },
                        getLabList() {
                            c.get('/experiment/getLabList', res => {
                                if (res.code === 0) {
                                    this.labs = res.data
                                }
                            })
                        },
                        getExpTypeList() {
                            c.get('/experiment/getExpTypeList', res => {
                                if (res.code === 0) {
                                    this.expTypeList = res.data
                                }
                            })
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
                            return y + '-' + m + '-' + d + ' ' + h + ':' + minute + ':' + second;
                        },
                        formatDate2(date) {
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
                        onSubmit() {
                            this.$refs.form.validate((valid) => {
                                if (valid) {
                                    // this.form.dateTime = this.formatDate(new Date(this.form.dateTimes[0])) + ' - ' + this.formatDate(new Date(this.form.dateTimes[1]))
                                    // this.form.teamYear = new Date(this.form.teamYearStart).getFullYear() + '-' + new Date(this.form.teamYearEnd).getFullYear()
                                    // this.form.teamYear = this.form.teamYearStart + '-' + this.form.teamYearEnd
                                    this.form.labSignUpList = []
                                    let _that = this
                                    if (this.signUpList.length !== 0) {
                                        this.signUpList.forEach(item => {
                                            this.form.labSignUpList.push({
                                                // startTime: _that.formatDate(new Date(item.time[0])),
                                                startTime: item.time[0],
                                                // endTime: _that.formatDate(new Date(item.time[1])),
                                                endTime: item.time[1],
                                                num: item.num
                                            })
                                        })
                                    }
                                    // console.log('data:', this.form)
                                    // c.post('/experiment/apply/saveOrUpdate', this.form, function (res) {
                                    //     // console.log('fjeowiqjf,res:', res)
                                    // }, 'json');
                                    this.loading = true
                                    c.ajax({
                                        type: 'POST',
                                        url: '/experiment/apply/saveOrUpdate',
                                        contentType: "application/json; charset=utf-8",
                                        data: JSON.stringify(this.form),
                                        dataType: "json",
                                        success: function (res) {
                                            // console.log('res:', res)
                                            this.loading = false
                                            if (res.code === 200) {
                                                _that.$message({
                                                    message: res.msg,
                                                    type: 'success',
                                                    onClose: () => {
                                                        let id = '/experiment/release/index'
                                                        // let i = '.layui-layout-admin>.layui-body>.layui-tab>.layui-tab-title>li[lay-id="' + id + '"]'
                                                        // let t = top.layui.jquery(i)
                                                        top.layui.admin.refresh(id)
                                                        // console.log('t:', t)
                                                        _that.cancel()
                                                        // top.k.refresh(id)
                                                        index.openTab({
                                                            title: '我发布的实验',
                                                            url: id
                                                        })
                                                    }
                                                })
                                            } else {
                                                _that.$message.error(res.msg)
                                            }
                                        }, error: (res) => {
                                            // console.log('res:', res)
                                        }
                                    })
                                } else {
                                    return false;
                                }
                            });
                        }
                    }
                })
            })
        </script>
    </body>
</html>
