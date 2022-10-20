<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>首页教师列表设置</title>
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

            .avatar-uploader .el-upload {
                border: 1px dashed #d9d9d9;
                border-radius: 6px;
                cursor: pointer;
                position: relative;
                overflow: hidden;
            }

            .avatar-uploader .el-upload:hover {
                border-color: #409EFF;
            }

            .avatar-uploader-icon {
                font-size: 28px;
                color: #8c939d;
                width: 178px;
                height: 178px;
                line-height: 178px;
                text-align: center;
            }

            .avatar {
                width: 178px;
                height: 178px;
                display: block;
            }
        </style>
    </head>
    <body>
        <div id="app" v-loading="loading">
            <el-container>
                <el-main>
                    <el-row>
                        <el-col>
                            <el-button type="primary" @click="showAddDialog">添加</el-button>
                        </el-col>
                    </el-row>
                    <el-row style="margin-top: 10px">
                        <el-col>
                            <el-table border :data="teacherList" style="width: 100%">
                                <el-table-column align="center" prop="realName" label="教师名"
                                                 min-width="180"></el-table-column>
                                <el-table-column align="center" prop="email" label="邮箱"
                                                 min-width="180"></el-table-column>
                                <el-table-column align="center" prop="tel" label="电话" min-width="180"></el-table-column>
                                <el-table-column align="center" prop="frontSort" label="排序"
                                                 min-width="50"></el-table-column>
                                <el-table-column align="center" label="操作" min-width="200">
                                    <template slot-scope="scope">
                                        <el-button type="primary" @click="editTeacher(scope.row)">编辑</el-button>
                                        <el-popconfirm title="确认删除吗？" @confirm="delById(scope.row)">
                                            <el-button slot="reference" type="danger">删除</el-button>
                                        </el-popconfirm>
                                    </template>
                                </el-table-column>
                            </el-table>
                        </el-col>
                    </el-row>
                    <el-dialog title="添加首页教师" :visible.sync="addDialog.show"
                               width="50%">
                        <div v-loading="addDialog.loading">
                            <el-form ref="form" inline :model="form" label-width="150px">
                                <el-form-item label="教师名/工号">
                                    <el-input v-model="form.name"></el-input>
                                </el-form-item>
                                <el-form-item>
                                    <el-button type="primary" @click="search">搜索</el-button>
                                </el-form-item>
                            </el-form>
                            <el-row>
                                <el-empty v-if="addDialog.empty" description="暂无搜索结果"></el-empty>
                                <div v-else>
                                    <el-tag type="success" @click="tagClick(item)"
                                            v-for="(item,index) in addDialog.teacherList"
                                            :key="index">
                                        {{item.realName}}
                                    </el-tag>
                                </div>
                            </el-row>
                        </div>
                    </el-dialog>
                    <el-dialog title="编辑教师信息" :visible.sync="editDialog.show" width="50%">
                        <el-form :model="editDialog.data" label-width="150px">
                            <el-form-item label="教师名">
                                <el-input disabled v-model="editDialog.data.realName"></el-input>
                            </el-form-item>
                            <el-form-item label="职务">
                                <el-input v-model="editDialog.data.positionName"></el-input>
                            </el-form-item>
                            <el-form-item label="排序">
                                <el-input v-model="editDialog.data.frontSort"></el-input>
                            </el-form-item>
                            <el-form-item label="头像">
                                <el-upload
                                        class="avatar-uploader"
                                        accept=".png, .jpg, .jpeg"
                                        action="/system/front/teacherList/saveTeacherAvatar"
                                        :show-file-list="false"
                                        :on-success="handleAvatarSuccess"
                                        :before-upload="beforeAvatarUpload">
                                    <img v-if="imgUrl" :src="imgUrl" class="avatar">
                                    <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                                </el-upload>
                            </el-form-item>
                            <el-form-item>
                                <el-button type="success" @click="submitTeacherInfo">提交</el-button>
                            </el-form-item>
                        </el-form>
                    </el-dialog>
                </el-main>
            </el-container>

        </div>
        <!-- js部分 -->
        <script>
            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            loading: false,
                            addDialog: {
                                show: false,
                                loading: false,
                                empty: false,
                                teacherList: []
                            },
                            imgUrl: '',
                            editDialog: {
                                show: false,
                                data: {}
                            },
                            form: {
                                name: ''
                            },
                            teacherList: []
                        }
                    },
                    created() {
                        this.getFrontTeacherList()
                    },
                    methods: {
                        submitTeacherInfo() {
                            const url = '/system/front/teacherList/updateFrontTeacherInfo'
                            c.ajax({
                                url: url,
                                type: 'POST',
                                contentType: 'application/json',
                                data: JSON.stringify(this.editDialog.data),
                                success: (res) => {
                                    if (res.code === 0) {
                                        this.$message.success('更新成功')
                                        this.getFrontTeacherList()
                                        this.editDialog.show = false
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                }
                            })
                        },
                        handleAvatarSuccess(res, file) {
                            console.log('handleAvatarSuccess:', res)
                            // this.imageUrl = URL.createObjectURL(file.raw);
                            if (res.code === 0) {
                                this.$message.success('上传成功')
                                this.editDialog.data.avatarPath = res.data
                                this.imgUrl = res.data
                            } else {
                                this.$message.error(res.msg)
                            }
                        },
                        beforeAvatarUpload(file) {
                            console.log('before, file type', file.type)
                            const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
                            const isLt2M = file.size / 1024 / 1024 < 2;
                            if (!isJPG) {
                                this.$message.error('上传头像图片只能是JPG或PNG格式!');
                            }
                            if (!isLt2M) {
                                this.$message.error('上传头像图片大小不能超过2MB!');
                            }
                            return isJPG && isLt2M;
                        },
                        editTeacher(item) {
                            //编辑教师信息
                            this.imgUrl = ''
                            this.editDialog.show = true
                            this.editDialog.data = {...item}
                            this.imgUrl = item.avatarPath
                            // console.log('this.editDialog.data', this.editDialog.data)
                        },
                        delById(row) {
                            const url = '/system/front/teacherList/delById/' + row.id
                            c.post(url, res => {
                                if (res.code === 0) {
                                    this.$message.success('删除成功')
                                } else {
                                    this.$message.error(res.msg)
                                }
                                this.getFrontTeacherList()
                            })

                        },
                        getFrontTeacherList() {
                            this.loading = true
                            const url = '/system/front/teacherList/getFrontTeacherList'
                            c.post(url, res => {
                                this.loading = false
                                console.log('res:', res)
                                if (res.code === 0) {
                                    this.teacherList = res.data
                                }
                            })
                        },
                        tagClick(item) {
                            console.log('tagClick:')
                            this.addDialog.loading = true
                            const url = '/system/front/teacherList/addFrontTeacher/' + item.id
                            c.post(url, res => {
                                console.log('res:', res)
                                this.addDialog.loading = false
                                if (res.code === 0) {
                                    this.$message.success('添加成功')
                                    this.getFrontTeacherList()
                                } else {
                                    this.$message.error(res.msg)
                                }
                            })
                        },
                        search() {
                            //搜索
                            this.addDialog.empty = false
                            this.addDialog.loading = true
                            const url = '/system/front/teacherList/searchTeacher'
                            c.ajax({
                                url: url,
                                type: 'POST',
                                contentType: 'application/json',
                                data: JSON.stringify(this.form),
                                success: (res) => {
                                    // console.log('res:', res)
                                    this.addDialog.loading = false
                                    if (res.code === 0) {
                                        this.addDialog.teacherList = res.data
                                        if (this.addDialog.teacherList.length === 0) {
                                            this.addDialog.empty = true
                                        } else {
                                            this.addDialog.empty = false
                                        }
                                    }
                                }
                            })
                        },
                        showAddDialog() {
                            this.form.name = ''
                            this.addDialog.empty = false
                            this.addDialog.show = true
                            this.addDialog.teacherList = []
                        }
                    }
                })
            })
        </script>
    </body>
</html>
