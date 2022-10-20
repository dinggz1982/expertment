<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>用户管理</title>
        <%@include file="../../include/include.jsp" %>
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
                                <label class="layui-form-label w-auto">学院名称：</label>
                                <div class="layui-input-inline mr0">
                                    <input name="name" class="layui-input" type="text" placeholder="输入学院名称"/>
                                </div>
                            </div>
                            <div class="layui-inline">
                                <label class="layui-form-label w-auto">学 校：</label>
                                <div class="layui-input-inline mr0">
                                    <select name="schoolId">
                                        <c:forEach items="${schools}" var="school">
                                            <option value="${school.id}">${school.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="layui-inline" style="padding-right: 110px;">
                                <button class="layui-btn icon-btn" lay-filter="formSubSearchCollege" lay-submit>
                                    <i class="layui-icon">&#xe615;</i>搜索
                                </button>
                                <button id="btnAddCollege" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                                </button>
                            </div>
                        </div>
                    </div>

                    <table id="tableCollege" lay-filter="tableCollege"></table>
                </div>
            </div>
        </div>

        <!-- 表格操作列 -->
        <script type="text/html" id="tableBarCollege">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            <%--    <a class="layui-btn layui-btn-xs" lay-event="reset">查看学院详细情况</a>--%>
        </script>
        <!-- 表格状态列 -->
        <script type="text/html" id="tableStateCollege">
            <input type="checkbox" lay-filter="ckStateCollege" value="{{d.userId}}" lay-skin="switch"
                   lay-text="正常|锁定" {{d.state==0?'checked':''}}/>
        </script>
        <!-- 表单弹窗 -->
        <script type="text/html" id="modelCollege">
            <form id="modelCollegeForm" lay-filter="modelCollegeForm" class="layui-form model-form">
                <input name="id" type="hidden" value="0"/>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">学校</label>
                    <div class="layui-input-block">
                        <select name="schoolId">
                            <c:forEach items="${schools}" var="school">
                                <option value="${school.id}">${school.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">学院名称</label>
                    <div class="layui-input-block">
                        <input name="name" id="name" placeholder="请输入学院名称" type="text" class="layui-input"
                               maxlength="20"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>

                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">简介</label>
                    <div class="layui-input-block">
                        <textarea name="description" style="margin: 0px; width: 220px; height: 67px;"></textarea>
                    </div>
                </div>
                <%--<div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">学号</label>
                    <div class="layui-input-block">
                        <input name="studentNo"  placeholder="请输入学号" type="text" class="layui-input" maxlength="20"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>--%>
                <div class="layui-form-item text-right">
                    <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
                    <button class="layui-btn" lay-filter="modelSubmitCollege" lay-submit>保存</button>
                </div>
            </form>
        </script>

        <script>
            layui.use(['layer', 'form', 'table', 'util', 'admin', 'xmSelect'], function () {
                var $ = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                var table = layui.table;
                var util = layui.util;
                var admin = layui.admin;
                var xmSelect = layui.xmSelect;
                // 渲染表格
                var insTb = table.render({
                    elem: '#tableCollege',
                    url: '/org/college/list.json',
                    page: true,
                    toolbar: true,
                    cellMinWidth: 100,
                    cols: [[
                        {type: 'numbers'},
                        {field: 'name', sort: true, title: '学院名称'},
                        {field: 'description', sort: true, title: '简介'},
                        {
                            field: 'school', sort: true, title: '学校',
                            templet: function (d) {
                                return d.school.name;
                            }
                        },

                        {align: 'center', toolbar: '#tableBarCollege', title: '操作', minWidth: 200}
                    ]]
                });

                // 添加
                $('#btnAddCollege').click(function () {
                    showEditModel();
                });

                // 搜索
                form.on('submit(formSubSearchCollege)', function (data) {
                    insTb.reload({where: data.field}, 'data');
                });

                // 工具条点击事件
                table.on('tool(tableCollege)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'edit') { // 修改
                        showEditModel(data);
                    } else if (layEvent === 'del') { // 删除
                        doDel(data.id, data.name);
                    } else if (layEvent === 'reset') { // 重置密码
                        resetPsw(data.id, data.realName);
                    }
                });

                // 显示表单弹窗
                function showEditModel(mCollege) {
                    admin.open({
                        type: 1,
                        title: (mCollege ? '修改' : '添加') + '学院',
                        content: $('#modelCollege').html(),
                        success: function (layero, dIndex) {
                            $(layero).children('.layui-layer-content').css('overflow', 'visible');
                            var url = "/org/college/saveOrUpdate";//新增或修改用户
                            form.val('modelCollegeForm', mCollege);
                            // 禁止弹窗出现滚动条
                            $(layero).children('.layui-layer-content').css('overflow', 'visible');
                            //mCollege.roleIds = insRoleSel.getValue();
                            // alert(insRoleSel.getValue());
                            // 表单提交事件
                            form.on('submit(modelSubmitCollege)', function (data) {
                                layer.load(2);
                                $.post(url, data.field, function (res) {
                                    layer.closeAll('loading');
                                    if (res.code == 200) {
                                        layer.close(dIndex);
                                        layer.msg(res.msg, {icon: 1});
                                        insTb.reload({}, 'data');
                                    } else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                }, 'json');
                                return false;
                            });
                        }
                    });
                }

                // 删除用户
                function doDel(id, realName) {
                    layer.confirm('确定要删除吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.post('/org/college/delete', {
                            id: id
                        }, function (res) {
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

                // 修改用户状态
                form.on('switch(ckStateCollege)', function (obj) {
                    layer.load(2);
                    $.get('../../json/ok.json', {
                        userId: obj.elem.value,
                        state: obj.elem.checked ? 0 : 1
                    }, function (res) {
                        layer.closeAll('loading');
                        if (res.code == 200) {
                            layer.msg(res.msg, {icon: 1});
                        } else {
                            layer.msg(res.msg, {icon: 2});
                            $(obj.elem).prop('checked', !obj.elem.checked);
                            form.render('checkbox');
                        }
                    }, 'json');
                });

                // 重置密码
                function resetPsw(id, realName) {
                    layer.confirm('确定要重置“' + realName + '”的登录密码吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.post('/system/user/resetPassword', {
                            id: id
                        }, function (res) {
                            layer.closeAll('loading');
                            if (res.code == 200) {
                                layer.msg(res.msg, {icon: 1});
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }, 'json');
                    });
                }

            });
        </script>

    </body>
</html>
