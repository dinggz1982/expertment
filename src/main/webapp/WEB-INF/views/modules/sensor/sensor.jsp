<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>传感器管理</title>
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
                        <label class="layui-form-label w-auto">传感器名称：</label>
                        <div class="layui-input-inline mr0">
                            <input name="username" class="layui-input" type="text" placeholder="输入账号"/>
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label w-auto">传感器类型：</label>
                        <div class="layui-input-inline mr0">
                            <select name="typeId">
                            </select>
                        </div>
                    </div>

                    <div class="layui-inline">
                        <label class="layui-form-label w-auto">学 校：</label>
                        <div class="layui-input-inline mr0">
                            <select name="schoolId">
                            </select>
                        </div>
                    </div>
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchSensor" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddSensor" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                        </button>
                    </div>
                </div>
            </div>

            <table id="tableSensor" lay-filter="tableSensor"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarSensor">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="reset">操作</a>
</script>
<!-- 表格状态列 -->
<script type="text/html" id="tableStateSensor">
    <input type="checkbox" lay-filter="ckStateSensor" value="{{d.userId}}" lay-skin="switch"
           lay-text="正常|锁定" {{d.state==0?'checked':''}}/>
</script>
<!-- 表单弹窗 -->
<script type="text/html" id="modelSensor">
    <form id="modelSensorForm" lay-filter="modelSensorForm" class="layui-form model-form">
        <input name="id" type="hidden" value="0"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">传感器名称</label>
            <div class="layui-input-block">
                <input name="name" id="name" placeholder="请输入传感器名称" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">类型</label>
            <div class="layui-input-block">
                <select name="typeId">
                    <c:forEach items="${types}" var="type">
                        <option value="${type.id}">${type.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
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
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitSensor" lay-submit>保存</button>
        </div>
    </form>
</script>

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
            elem: '#tableSensor',
            url: '/sensor/sensor/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {field: 'name', sort: true, title: '传感器名称'},
                {
                    field: 'school', sort: true, title: '学校', templet: function (d) {
                        console.log(d);
                        return d.school.name;
                    }
                },
                {
                    field: 'sensorType', sort: true, title: '类型', templet: function (d) {
                        return d.sensorType.name
                    }
                },
                {
                    field: 'online', sort: true, title: '是否在线', templet: function (d) {
                        if (d.isOnline) {
                            return "在线";
                        } else {
                            return "下线";
                        }
                    }
                },
                {align: 'center', toolbar: '#tableBarSensor', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddSensor').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchSensor)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableSensor)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.name);
            } else if (layEvent === 'reset') { //
                resetPsw(data.id, data.name);
            }
        });

        // 显示表单弹窗
        function showEditModel(mSensor) {
            admin.open({
                type: 1,
                title: (mSensor ? '修改' : '添加') + '传感器',
                content: $('#modelSensor').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = "/sensor/sensor/saveOrUpdate";//新增或修改传感器
                    form.val('modelSensorForm', mSensor);
                    // 表单提交事件
                    form.on('submit(modelSubmitSensor)', function (data) {
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

        // 删除传感器
        function doDel(id, name) {
            layer.confirm('确定要删除“' + name + '”吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('/system/user/delete', {
                    id: id
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

        // 修改传感器状态
        form.on('switch(ckStateSensor)', function (obj) {
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
                $.post('/user/resetPassword', {
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
