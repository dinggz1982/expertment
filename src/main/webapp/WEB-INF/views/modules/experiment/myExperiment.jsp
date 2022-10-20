<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>我的实验</title>
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <style>
            #cancelSign {
                display: flex;
                align-content: center;
                justify-content: center;
            }
        </style>
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
                                        <%--                                        <div class="layui-row" style="margin-top: 20px">--%>
                                        <%--                                            <div class="layui-form-item">--%>
                                        <%--                                                <label class="layui-form-label layui-form-required">主试:</label>--%>
                                        <%--                                                <div class="layui-input-block">--%>
                                        <%--                                                    <div id="userList"></div>--%>
                                        <%--                                                </div>--%>
                                        <%--                                            </div>--%>
                                        <%--                                        </div>--%>
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
                // console.log('team', team)
                let statusList = JSON.parse(`${status}`)
                // console.log('status', typeof statusList)

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

                // xmSelect.render({
                //     el: '#userList',
                //     name: 'userList',
                //     layVerify: 'required',
                //     layVerType: 'tips',
                //     data: userList,
                //     on: data => {
                //         if (data.arr.length === 0) {
                //             userId = new Set()
                //         } else {
                //             userId = new Set()
                //             data.arr.forEach(item => {
                //                 console.log('item', item)
                //                 userId.add(item.value)
                //             })
                //         }
                //         console.log('userid', userId)
                //         console.log('userid', JSON.stringify([...userId]))
                //         changeTable()
                //     }
                // });

                table.on('tool(tableLab)', function (obj) {
                    // console.log('table.on,obj:', obj)
                    let data = obj.data;
                    if (obj.event === 'cancelSign') {
                        // showApprove(data);
                        // console.log('data:', data)
                        let url = '${ctx}/experiment/my/cancel/' + data.id
                        $.get(url, res => {
                            // console.log('fjeowjq:', res)
                            layer.msg(res.msg)
                            if (res.code === 200) {
                                changeTable()
                            }
                        })
                    } else if (obj.event === 're') {
                        // todo:重新报名
                    }
                })


                function changeTable() {
                    insTb = table.render({
                        elem: '#tableLab',//要渲染的表格id
                        url: '${ctx}/experiment/my/list',
                        page: true,
                        toolbar: true,
                        where: {team: teamName},
                        cellMinWidth: 100,
                        cols: [[
                            {type: 'numbers'},
                            {
                                field: 'name', templet: function (d) {
                                    if (d.apply !== null) {
                                        return d.apply.name
                                    }
                                    return "未知实验名"
                                }, title: '实验名称'
                            }, {
                                field: 'main_name', templet: function (d) {
                                    return d.signupUser.realName
                                }, title: '主试人'
                            }, {
                                field: 'hours', templet: function (d) {
                                    if (d.apply !== null) {
                                        return d.apply.hours
                                    }
                                    return "未知学时"
                                }, title: '实验时'
                            }, {
                                field: 'team', templet: function (d) {
                                    if (d.apply !== null) {
                                        return d.apply.team
                                    }
                                    return "未知学期"
                                }, title: '学期'
                            }, {
                                field: 'status', templet: function (d) {
                                    let str = "未知状态"
                                    statusList.forEach(item => {
                                        if (d.status === item.id) {
                                            str = item.desc;
                                        }
                                    })
                                    return str
                                }, title: '状态'
                            }, {
                                field: 'op', templet: function (d) {
                                    if (d.status === 1 || d.status === 2) {
                                        let str = '<button  type="button" class="layui-btn layui-btn-sm"  lay-event="cancelSign">取消报名</button>'
                                        return str
                                    } else if (d.status === 4) {
                                        let str = '<button  type="button" class="layui-btn layui-btn-sm"  lay-event="re">重新报名</button>'
                                        return str
                                    }
                                    return ''
                                }, title: '操作'
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
