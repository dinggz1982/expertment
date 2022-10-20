<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>设置实验室介绍</title>
        <link rel="stylesheet" href="/element-ui/index.css">
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <script type="text/javascript" src="/vue/vue.js"></script>
        <script type="text/javascript" src="/element-ui/index.js"></script>
        <!-- 配置文件 -->
        <script type="text/javascript" src="/utf8-jsp/ueditor.config.js"></script>
        <!-- 编辑器源码文件 -->
        <script type="text/javascript" src="/utf8-jsp/ueditor.all.js"></script>
        <style>
            .app {
                background-color: none;
            }

            .main-row {
                border-radius: 2px;
                /*background-color: #fff;*/
                box-shadow: 0 1px 2px 0 rgb(0 0 0 / 5%);
                padding: 10px 15px;
            }
        </style>
    </head>
    <body>
        <div id="app" class="app">
            <el-container>
                <el-main>
                    <el-row>
                        <script style="width: 100%;height: 500px;" id="container" name="content"
                                type="text/plain"></script>
                    </el-row>
                    <el-row type="flex" justify="center" class="main-row">
                        <el-col>
                            <el-button type="primary" @click="save">保存</el-button>
                        </el-col>
                    </el-row>
                </el-main>
            </el-container>
        </div>
        <script>
            var ue = UE.getEditor('container');

            layui.use(['layer', 'index'], function () {
                var c = layui.jquery;
                var index = layui.index;
                var vue = new Vue({
                    el: '#app',
                    data() {
                        return {}
                    }, created() {
                        this.getDescription()
                    },
                    methods: {
                        getDescription() {
                            const url = '/experiment/setDescription/get-description'
                            c.ajax({
                                url: url,
                                type: 'get',
                                success: res => {
                                    console.log('res:', res)
                                    if (res.code === 0) {
                                        //对编辑器的操作最好在编辑器ready之后再做
                                        // init(res.data.description + '')
                                        // ue.ready(() => {
                                        //     //设置编辑器的内容
                                        //     ue.setContent(res.data.description + '');
                                        //     //获取html内容，返回: <p>hello</p>
                                        // });
                                        setTimeout(() => {
                                            ue.setContent(res.data.description);
                                        }, 3000)
                                    }
                                }
                            })
                        },
                        save() {
                            var html = ue.getContent();
                            console.log('save:', html)
                            const url = '/experiment/setDescription/save'
                            c.ajax({
                                url: url,
                                type: 'post',
                                headers: {
                                    'Content-Type': 'application/json'
                                },
                                data: JSON.stringify({id: 1, description: html}),
                                success: res => {
                                    console.log('save res:', res)
                                    if (res.code === 0) {
                                        //对编辑器的操作最好在编辑器ready之后再做
                                        this.$message.success('保存成功')
                                    }
                                    this.getDescription()
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
