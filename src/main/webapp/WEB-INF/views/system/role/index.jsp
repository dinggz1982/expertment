
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>角色管理</title>
    <%@include file="../../include/include.jsp"%>
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
        <div class="layui-card-body">
            <div class="layui-form toolbar">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label w-auto">搜索：</label>
                        <div class="layui-input-inline mr0">
                            <input name="name" class="layui-input" type="text" placeholder="输入关键字"/>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchRole" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddRole" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加</button>
                    </div>
                </div>
            </div>

            <table id="tableRole" lay-filter="tableRole"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarRole">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="auth">权限分配</a>
</script>
<!-- 表单弹窗 -->
<script type="text/html" id="modelRole">
    <form id="modelRoleForm" lay-filter="modelRoleForm" class="layui-form model-form">
        <input name="id" type="hidden" value="0"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">角色名</label>
            <div class="layui-input-block">
                <input name="name" placeholder="请输入角色名" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">备注</label>
            <div class="layui-input-block">
                <textarea name="description" placeholder="请输入内容" class="layui-textarea" maxlength="200"></textarea>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitRole" lay-submit>保存</button>
        </div>
    </form>
</script>
<!-- js部分 -->
<script>
    layui.use(['layer', 'form', 'table', 'util', 'admin', 'zTree'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var util = layui.util;
        var admin = layui.admin;

        // 渲染表格
        var insTb = table.render({
            elem: '#tableRole',
            url: '/system/role/list.json',//分页url
            page: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {field: 'name', sort: true, title: '角色名'},
                {field: 'description', sort: true, title: '备注'},
                {align: 'center', toolbar: '#tableBarRole', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddRole').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchRole)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableRole)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(obj);
            } else if (layEvent === 'auth') {  // 权限管理
                showPermModel(data.id);
            }
        });

        // 删除
        function doDel(obj) {
            layer.confirm('确定要删除“' + obj.data.name + '”角色吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('/system/role/delete', {
                    id: obj.data.id
                }, function (res) {
                    layer.closeAll('loading');
                    if (res.code == 200) {
                        layer.msg(res.msg, {icon: 1});
                        obj.del();
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }, 'json');
            });
        }

        // 显示编辑弹窗
        function showEditModel(mRole) {
            admin.open({
                type: 1,
                title: (mRole ? '修改' : '添加') + '角色',
                content: $('#modelRole').html(),
                success: function (layero, dIndex) {
                    var url = '/system/role/saveOrUpdate';
                    form.val('modelRoleForm', mRole);  // 回显数据
                    // 表单提交事件
                    form.on('submit(modelSubmitRole)', function (data) {
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

        // 权限管理
        function showPermModel(roleId) {
            admin.open({
                title: '角色权限分配',
                btn: ['保存', '取消'],
                content: '<ul id="treeAuth" class="ztree"></ul>',
                success: function (layero, index) {
                    $(layero).children('.layui-layer-content').css({'max-height': '300px', 'overflow': 'auto'});
                    layer.load(2);
                    var setting = {check: {enable: true}, data: {simpleData: {enable: true}}};
                    $.get('/system/menu/authTree', {
                        roleId: roleId
                    }, function (res) {
                        $.fn.zTree.init($('#treeAuth'), setting, res);
                        layer.closeAll('loading');
                    }, 'json');
                },
                yes: function (index) {
                    layer.load(2);
                    var treeObj = $.fn.zTree.getZTreeObj('treeAuth');
                    var nodes = treeObj.getCheckedNodes(true);
                    var ids = new Array();
                    for (var i = 0; i < nodes.length; i++) {
                        ids[i] = nodes[i].id;
                    }
                    $.post('/system/menu/saveAuth', {
                        roleId: roleId,
                        authIds: JSON.stringify(ids)
                    }, function (res) {
                        layer.closeAll('loading');
                        if (200 == res.code) {
                            layer.msg(res.msg, {icon: 1});
                            layer.close(index);
                        } else {
                            layer.msg(res.msg, {icon: 2});
                        }
                    }, 'json');
                }
            });
        }

    });
</script>
</body>
</html>