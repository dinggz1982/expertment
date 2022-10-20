<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>查询实验</title>
        <%@include file="/WEB-INF/views/include/include.jsp" %>
    </head>
    <body>
        <!-- 页面加载loading -->
        <div class="page-loading">
            <div class="ball-loader">
                <span></span><span></span><span></span><span></span>
            </div>
        </div>

        <!-- 正文开始 -->
        <div class="layui-fluid">
            <div class="layui-card">
                <div class="layui-card-body table-tool-mini full-table">
                    <div class="layui-form toolbar">
                        <div class="layui-form-item">
                            <div class="layui-row">
                                <div class="layui-col-lg4">
                                    <form>
                                        <div class="layui-row">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label layui-form-required">学期:</label>
                                                <div class="layui-input-block">
                                                    <div id="teamList"></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="layui-row" style="margin-top: 20px">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label layui-form-required">主试:</label>
                                                <div class="layui-input-block">
                                                    <div id="userList"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id="tableLab" style="margin-top: 20px" lay-filter="tableLab"></table>
                </div>
            </div>
        </div>


        <script>
            layui.use(['layer', 'form', 'admin', 'table', 'laydate', 'layedit', 'util', 'xmSelect', 'admin'], function () {
                var $ = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                var table = layui.table;
                var util = layui.util;
                var layedit = layui.layedit;
                var admin = layui.admin;
                var laydate = layui.laydate;
                var xmSelect = layui.xmSelect;
                let insTb
                let signUpType = null

                let team = [${team}]
                team = team[0]
                let teamName = null
                let userList = [${user}]
                userList = userList[0]


                let insRoleSel = xmSelect.render({
                    el: '#teamList',
                    name: 'teamList',
                    on: data => {
                        let arr = data.arr
                        if (arr.length === 0) {
                            teamName = null
                        } else {
                            teamName = arr[0].value
                        }
                        changeTable()
                    },
                    radio: true,
                    layVerify: 'required',
                    layVerType: 'tips',
                    data: team
                });

                var userId = new Set()

                xmSelect.render({
                    el: '#userList',
                    name: 'userList',
                    layVerify: 'required',
                    layVerType: 'tips',
                    data: userList,
                    on: data => {
                        if (data.arr.length === 0) {
                            userId = new Set()
                        } else {
                            userId = new Set()
                            data.arr.forEach(item => {
                                console.log('item', item)
                                userId.add(item.value)
                            })
                        }
                        console.log('userid', userId)
                        console.log('userid', JSON.stringify([...userId]))
                        changeTable()
                    }
                });


                function changeTable() {
                    insTb = table.render({
                        elem: '#tableLab',//要渲染的表格id
                        url: '${ctx}/experiment/query/list',
                        page: true,
                        toolbar: true,
                        where: {team: teamName, userId: JSON.stringify([...userId])},
                        cellMinWidth: 100,
                        cols: [[
                            {type: 'numbers'},
                            {
                                field: 'name', templet: function (d) {
                                    return d.name
                                }, title: '实验名称'
                            }, {
                                field: 'main_name', templet: function (d) {
                                    return d.applyUser.realName
                                }, title: '主试人'
                            }, {
                                field: 'hours', templet: function (d) {
                                    return d.hours
                                }, title: '学时'
                            }, {
                                field: 'team', templet: function (d) {
                                    return d.team
                                }, title: '学期'
                            }
                        ]]
                    });
                }

                changeTable()
            })
        </script>
        <!-- js部分 -->

    </body>
</html>
