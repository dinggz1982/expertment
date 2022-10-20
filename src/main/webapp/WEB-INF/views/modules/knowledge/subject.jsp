<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学科管理</title>
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
                        <label class="layui-form-label w-auto">学科名称：</label>
                        <div class="layui-input-inline mr0">
                            <input name="name" class="layui-input" type="text" placeholder="输入学科名称"/>
                        </div>
                    </div>
                    <!-- <div class="layui-inline">
                        <label class="layui-form-label w-auto">学科地址：</label>
                        <div class="layui-input-inline mr0">
                            <input name="address" class="layui-input" type="text" placeholder="学科地址"/>
                        </div>
                    </div> -->
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchSchool" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddSchool" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                        </button>
                    </div>
                </div>
            </div>
            <table id="tableSchool" lay-filter="tableSchool"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarSchool">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="detail">查看学科知识点</a>
</script>

<!-- 表单弹窗 -->
<script type="text/html" id="modelSchool">
    <form id="modelSchoolForm" lay-filter="modelSchoolForm" class="layui-form model-form">
        <input name="id" type="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">学科名称</label>
            <div class="layui-input-block">
                <input name="name" placeholder="请输入学科名称" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">学段</label>
            <div class="layui-input-block">
                <select name="studyPeriod" lay-search>
                    <option value="小学">小学</option>
                    <option value="初中">初中</option>
                    <option value="高中">高中</option>
                    <option value="本科">本科</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitSchool" lay-submit>保存</button>
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
            elem: '#tableSchool',//要渲染的表格id
            url: '${ctx}/knowledge/subject/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {field: 'name', sort: true, title: '学科名称'},
                {field: 'studyPeriod', sort: true, title: '学段'},
                {align: 'center', toolbar: '#tableBarSchool', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddSchool').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchSchool)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableSchool)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.name);
            } else if (layEvent === 'detail') { // 查看学科详细情况
                //打开学科知识点模块
                layui.use(['index'], function () {
                    var index = layui.index;
                    index.openTab({
                        title: data.name + '知识点',
                        url: '/knowledge/knowledge?subjectId='+data.id,
                        end: function () {
                        }
                    });
                });
            }
        });

        // 显示表单弹窗
        function showEditModel(mSchool) {
            admin.open({
                type: 1,
                title: (mSchool ? '修改' : '添加') + '学科',
                content: $('#modelSchool').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = '${ctx}/knowledge/subject/saveOrUpdate';
                    // 回显数据
                    form.val('modelSchoolForm', mSchool);
                    // 表单提交事件
                    form.on('submit(modelSubmitSchool)', function (data) {
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
        function doDel(subjectId, subjectname) {
            layer.confirm('确定要删除“' + subjectname + '”吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('${ctx}/knowledge/subject/delete', {
                    id: subjectId
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