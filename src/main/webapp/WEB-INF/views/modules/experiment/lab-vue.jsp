<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验室管理</title>
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
                        <el-col :span="23">
                            <el-row>
                                <el-form :inline="true" :model="formData">
                                    <el-form-item label="实验室名称：">
                                        <el-input v-model="formData.name" placeholder="输入实验室名称"></el-input>
                                    </el-form-item>
                                    <el-form-item>
                                        <el-button type="primary" @click="search">搜索</el-button>
                                        <el-button type="primary" @click="add">添加</el-button>
                                    </el-form-item>
                                </el-form>
                            </el-row>
                            <el-row>
                                <el-col>
                                    <el-table border :data="dataList" style="width: 100%">
                                        <el-table-column align="center" prop="name" label="实验室名称"
                                                         min-width="100"></el-table-column>
                                        <el-table-column align="center" prop="address" label="实验室地址"
                                                         min-width="100"></el-table-column>
                                        <el-table-column align="center" prop="description" label="描述信息"
                                                         min-width="100"></el-table-column>
                                        <el-table-column align="center" prop="createDate" label="创建时间"
                                                         min-width="100"></el-table-column>
                                        <el-table-column align="center" label="首页显示"
                                                         min-width="50">
                                            <template slot-scope="scope">
                                                <el-switch active-value="1" inactive-value="0"
                                                           v-model="scope.row.frontShow"
                                                           active-color="#13ce66"
                                                           @change="changeFrontShow(scope.row)"
                                                           inactive-color="#ff4949">
                                                </el-switch>
                                            </template>
                                        </el-table-column>
                                        <el-table-column align="center" label="首页排序" width="100">
                                            <templage slot-scope="scope">
                                                <el-input :disabled="scope.row.frontShow === '0'"
                                                          type="number" v-model="scope.row.sort"
                                                          @blur="sortBlur(scope.row)">
                                                </el-input>
                                            </templage>
                                        </el-table-column>
                                        <el-table-column align="center" label="操作" min-width="100">
                                            <template slot-scope="scope">
                                                <el-button type="primary" @click="updateLab(scope.row)">修改</el-button>
                                                <el-popconfirm title="确认删除该实验室吗?" @confirm="deleteLab(scope.row)">
                                                    <el-button slot="reference" type="danger">删除</el-button>
                                                </el-popconfirm>
                                                <el-button type="success" @click="showDetail(scope.row)">查看详情
                                                </el-button>
                                            </template>
                                        </el-table-column>
                                    </el-table>
                                </el-col>
                            </el-row>
                            <el-row style="margin-top: 10px">
                                <el-pagination
                                        background @current-change="currentChange"
                                        layout="prev, pager, next"
                                        :total="total">
                                </el-pagination>
                            </el-row>
                            <el-dialog :close-on-click-modal="false" :title="title" :visible.sync="dialogVisible"
                                       width="70%">
                                <el-form ref="form" :model="form" label-width="150px" v-if="dialogVisible">
                                    <el-form-item label="实验室名称">
                                        <el-input :disabled="onlyShow" v-model="form.name"
                                                  placeholder="请输入实验室名称"></el-input>
                                    </el-form-item>
                                    <el-form-item label="实验室地址">
                                        <el-input :disabled="onlyShow" v-model="form.address"
                                                  placeholder="请输入实验室地址"></el-input>
                                    </el-form-item>
                                    <el-form-item label="功能介绍">
                                        <el-input :disabled="onlyShow" type="textarea" :autosize="{ minRows: 4 }"
                                                  :maxlength="255" v-model="form.description"></el-input>
                                    </el-form-item>
                                    <el-form-item label="图片">
                                        <el-upload accept=".png, .jpg, .jpeg" :disabled="onlyShow" :file-list="fileList"
                                                   :on-success="handleSuccess" :on-exceed="handleOnExceed"
                                                   action="/experiment/lab/saveLabPicture" multiple :limit="fileLimit"
                                                   list-type="picture-card" :before-upload="beforeUpload"
                                                   :on-remove="handleRemove">
                                            <i class="el-icon-plus"></i>
                                        </el-upload>
                                    </el-form-item>
                                </el-form>
                                <div slot="footer" class="dialog-footer">
                                    <el-button v-if="!onlyShow" type="primary" @click="submit">确定</el-button>
                                    <el-button @click="dialogVisible = false">取消</el-button>
                                </div>
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
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {
                            formData: {
                                name: ''
                            },
                            form: {},
                            title: '新增实验室',
                            dialogVisible: false,
                            onlyShow: false,
                            page: 1,
                            limit: 10,
                            total: 0,
                            dataList: [],
                            fileList: [],
                            fileLimit: 9,//上传数量限制
                        }
                    },
                    created() {
                        this.getDataList()
                    },
                    methods: {
                        sortBlur(row) {
                            //排序输入框失去焦点
                            let url = '/experiment/lab/updateLabSort'
                            let postData = {id: row.id, sort: row.sort}
                            c.ajax({
                                type: 'POST',
                                url: url,
                                dataType: 'json',
                                contentType: 'application/json;charset=UTF-8',
                                data: JSON.stringify(postData),
                                success: res => {
                                    if (res.code === 0) {
                                        this.$message.success('保存成功')
                                        this.getDataList()
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                },
                            });
                        },
                        changeFrontShow(item) {
                            console.log('changeFrontShow ', item)
                            const url = '/experiment/lab/updateFrontShow/' + item.id + '/' + item.frontShow
                            c.get(url).then(res => {
                                if (res.code === 0) {
                                    this.$message.success('更新成功')
                                    this.getDataList()
                                } else {
                                    this.$message.error(res.msg);
                                }
                            })
                        },
                        beforeUpload(file) {
                            console.log('before, file type', file.type)
                            const isJPG = file.type === 'image/jpeg' || file.type === 'image/png';
                            const isLt2M = file.size / 1024 / 1024 < 2;
                            const isLimit = this.fileList.length < this.fileLimit
                            if (!isJPG) {
                                this.$message.error('上传头像图片只能是JPG或PNG格式!');
                            }
                            if (!isLt2M) {
                                this.$message.error('上传头像图片大小不能超过2MB!');
                            }
                            return isJPG && isLt2M;
                        },
                        handleOnExceed() {
                            let str = '上传图片数量超出限制,上限为' + this.fileLimit + '张'
                            this.$message.error(str)
                        },
                        handleSuccess(res, file, fileList) {
                            if (res.code === 0) {
                                //图片上传成功
                                file.url = res.data
                                this.fileList = fileList
                                this.$message.success('图片上传成功')
                            } else {
                                this.$message.error(res.msg)
                            }
                        },
                        handleRemove(file, fileList) {
                            console.log('handleRemove file list', fileList)
                            this.fileList = fileList
                        },
                        showDetail(item) {
                            //查看详情
                            this.title = '实验详情'
                            this.form = {...item}
                            this.dialogVisible = true
                            this.onlyShow = true
                        },
                        updateLab(item) {
                            //更新实验室数据
                            this.title = '更新实验室'
                            this.form = {...item}
                            console.log('update lab item,', item)
                            let imgList = []
                            this.fileList = []
                            let list = JSON.parse(item.imgList)
                            console.log('update lab ', list)
                            if (list && list.length > 0) {
                                list.forEach(item => {
                                    imgList.push({url: item})
                                })
                                this.fileList = imgList
                            }
                            this.dialogVisible = true
                            this.onlyShow = false
                        },
                        deleteLab(item) {
                            const url = '/experiment/lab/deleteAdmin/' + item.id
                            c.get(url)
                                .then(res => {
                                    console.log('del res:', res)
                                    if (res.code === 0) {
                                        this.$message.success('删除成功')
                                        this.getDataList()
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                })
                        },
                        submit() {
                            //提交
                            const url = '/experiment/lab/saveOrUpdateAdmin'
                            if (this.fileList.length > 0) {
                                let imgList = []
                                this.fileList.forEach(item => {
                                    console.log('item:', item)
                                    imgList.push(item.url)
                                })
                                this.form.imgList = JSON.stringify(imgList)
                            }
                            c.ajax({
                                type: 'POST',
                                url: url, dataType: 'json',
                                contentType: 'application/json;charset=UTF-8',
                                data: JSON.stringify(this.form),
                                success: res => {
                                    if (res.code === 0) {
                                        this.$message.success('添加成功')
                                        this.dialogVisible = false
                                        this.getDataList()
                                    } else {
                                        this.$message.error(res.msg)
                                    }
                                },
                            });
                        },
                        add() {
                            //新增实验室
                            this.title = '新增实验室'
                            this.form = {}
                            this.fileList = []
                            this.onlyShow = false
                            this.dialogVisible = true
                        },
                        currentChange(val) {
                            this.page = val
                            this.getDataList()
                        },
                        search() {
                            this.page = 1
                            this.getDataList()
                        },
                        getDataList() {
                            const url = '/experiment/lab/list'
                            let postData = {page: this.page, limit: this.limit, name: this.formData.name}
                            c.ajax({
                                type: 'POST',
                                url: url, dataType: 'json',
                                contentType: 'application/json;charset=UTF-8',
                                data: JSON.stringify(postData),
                                success: res => {
                                    if (res.code === 0) {
                                        this.dataList = res.data.records
                                        this.total = res.data.total
                                    }
                                },
                            });
                        }
                    }
                })
            })
        </script>
        <!-- js部分 -->
    </body>
</html>
