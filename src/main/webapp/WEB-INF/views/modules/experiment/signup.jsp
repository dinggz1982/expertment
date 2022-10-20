<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验报名</title>
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
                            <div class="layui-inline">
                                <label class="layui-form-label w-auto">实验申请：</label>
                                <div class="layui-input-inline mr0">
                                    <input name="name" class="layui-input" type="text" placeholder="输入实验申请"/>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id="tableLab" lay-filter="tableLab"></table>
                </div>
            </div>
        </div>

        <!-- 表格操作列 -->
        <script type="text/html" id="tableBarLab">
            <a class="layui-btn layui-btn-xs" lay-event="signup">报名</a>
        </script>
        <script>


            layui.use(['layer', 'form', 'admin', 'table', 'laydate', 'layedit', 'util', 'admin'], function () {
                var $ = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                var table = layui.table;
                var util = layui.util;
                var layedit = layui.layedit;
                var admin = layui.admin;
                var laydate = layui.laydate;
                // 渲染表格


                let signUpType = null


                $.get('${ctx}/experiment/signup/type/', res => {
                    signUpType = JSON.parse(res.msg)
                })

                var insTb = table.render({
                    elem: '#tableLab',//要渲染的表格id
                    url: '${ctx}/experiment/signup/list.json',
                    page: true,
                    toolbar: true,
                    cellMinWidth: 100,
                    cols: [[
                        {type: 'numbers'},
                        {
                            field: 'applyTime', sort: true, templet: function (d) {
                                return util.toDateString(d.startDate) + '-' + util.toDateString(d.endDate);
                            }, title: '实验时间', minWidth: 100
                        },
                        {
                            field: 'name', sort: true, title: '实验名称', templet: function (d) {
                                return d.apply.name
                            }
                        },
                        {
                            field: 'remains', sort: true, title: '剩余人数', templet: function (d) {
                                return d.apply.number - d.apply.applyNumber
                            },
                        },
                        {
                            field: 'finishNumber', sort: true, title: '已完成被试数', minWidth: 20, templet: function (d) {
                                return d.apply.finishNumber
                            }
                        },
                        {
                            field: 'applyNumber', sort: true, title: '已报名被试数', minWidth: 20, templet: function (d) {
                                return d.apply.applyNumber
                            }
                        },
                        {
                            align: 'center',
                            // toolbar: '#tableBarLab',
                            title: '操作',
                            minWidth: 250,
                            templet: function (e) {
                                if (e.status === null || e.status === undefined) {
                                    return "<a class='layui-btn layui-btn-xs' lay-event='signup'>报名</a>"
                                } else {
                                    let res = '未知操作'
                                    signUpType.forEach(item => {
                                        if (item.id === e.status) {
                                            res = item.desc
                                        }
                                    })
                                    return res
                                }
                            }
                        }
                    ]]
                });

                // 搜索
                form.on('submit(formSubSearchLab)', function (data) {
                    insTb.reload({where: data.field}, 'data');
                });

                // 工具条点击事件
                table.on('tool(tableLab)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'signup') { // 报名
                        doSignup(data.apply.id, data.apply.name);
                    }
                });

                // 报名
                function doSignup(id, name) {
                    layer.confirm('确定要报名“' + name + '”吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.post('${ctx}/experiment/signup/save/' + id, {}, function (res) {
                            layer.closeAll('loading');
                            if (res.code === 200) {
                                layer.msg(res.msg, {icon: 1});
                                insTb.reload({}, 'data');
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }, 'json');
                    });
                }
            })
        </script>
        <!-- js部分 -->

    </body>
</html>
