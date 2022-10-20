<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>传感器类型管理</title>
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
                        <label class="layui-form-label w-auto">传感器类型：</label>
                        <div class="layui-input-inline mr0">
                            <input name="name" class="layui-input" type="text" placeholder="传感器类型"/>
                        </div>
                    </div>
                    <!-- <div class="layui-inline">
                        <label class="layui-form-label w-auto">传感器类别地址：</label>
                        <div class="layui-input-inline mr0">
                            <input name="address" class="layui-input" type="text" placeholder="传感器类别地址"/>
                        </div>
                    </div> -->
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchSensorType" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddSensorType" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加</button>
                    </div>
                </div>
            </div>
            <table id="tableSensorType" lay-filter="tableSensorType"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarSensorType">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看传感器类别详细情况</a>
</script>

<!-- 表单弹窗 -->
<script type="text/html" id="modelSensorType">
    <form id="modelSensorTypeForm" lay-filter="modelSensorTypeForm" class="layui-form model-form">
        <input name="id" type="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">传感器类别</label>
            <div class="layui-input-block">
                <input name="name" placeholder="请输入传感器类别" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">本类型传感器描述</label>
            <div class="layui-input-block">
                <textarea name="description" lay-verType="tips" lay-verify="required" required >
                </textarea>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitSensorType" lay-submit>保存</button>
        </div>
    </form>
</script>
<!-- js部分 -->
<script>
    layui.use(['layer', 'form', 'table', 'util', 'admin'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var util = layui.util;
        var admin = layui.admin;

        // 渲染表格
        var insTb = table.render({
            elem: '#tableSensorType',//要渲染的表格id
            url: '${ctx}/sensor/type/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {field: 'name', sort: true, title: '传感器类别'},
                {field: 'description', sort: true, title: '传感器类别描述'},
                {align: 'center', toolbar: '#tableBarSensorType', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddSensorType').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchSensorType)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableSensorType)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.name);
            } else if (layEvent === 'detail') { // 查看传感器类别详细情况
                alert("稍后开发！");
                //resetPsw(data.id, data.nickName);新开一个页面查看传感器类别详细情况
            }
        });

        // 显示表单弹窗
        function showEditModel(mSensorType) {
            admin.open({
                type: 1,
                title: (mSensorType ? '修改' : '添加') + '传感器类别',
                content: $('#modelSensorType').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = '${ctx}/sensor/type/saveOrUpdate';
                    // 回显数据
                    form.val('modelSensorTypeForm', mSensorType);
                    // 表单提交事件
                    form.on('submit(modelSubmitSensorType)', function (data) {
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

        // 删除
        function doDel(schoolId, schoolname) {
            layer.confirm('确定要删除“' + schoolname + '”吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('${ctx}/sensor/type/delete', {
                    id: schoolId
                }, function (res) {
                    layer.closeAll('loading');
                    if (res.code == 200) {
                        layer.msg(res.msg, {icon: 1});
                        insTb.reload({}, 'data');
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