<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>教材管理</title>
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
                        <label class="layui-form-label w-auto">教材名称：</label>
                        <div class="layui-input-inline mr0">
                            <input name="name" class="layui-input" type="text" placeholder="输入教材名称"/>
                        </div>
                    </div>
                    <!-- <div class="layui-inline">
                        <label class="layui-form-label w-auto">教材地址：</label>
                        <div class="layui-input-inline mr0">
                            <input name="address" class="layui-input" type="text" placeholder="教材地址"/>
                        </div>
                    </div> -->
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchTextbook" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddTextbook" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                        </button>
                    </div>
                </div>
            </div>
            <table id="tableTextbook" lay-filter="tableTextbook"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarTextbook">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <a class="layui-btn layui-btn-xs" lay-event="outline">查看大纲</a>
</script>

<!-- 表单弹窗 -->
<script type="text/html" id="modelTextbook">
    <form id="modelTextbookForm" lay-filter="modelTextbookForm" class="layui-form model-form">
        <input name="id" type="hidden"/>
        <div class="layui-inline">
            <div class="layui-form-item">
                <label class="layui-form-label layui-form-required">学科</label>
                <div class="layui-input-block">
                <select name="subjectId">
                        <c:forEach items="${subjects}" var="subject">
                            <option value="${subject.id}">${subject.name}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label layui-form-required">教材名称</label>
                <div class="layui-input-block">
                    <input name="name" placeholder="请输入教材名称" type="text" class="layui-input" maxlength="20"
                           lay-verType="tips" lay-verify="required" required/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label layui-form-required">出版社</label>
                <div class="layui-input-block">
                    <input name="press" placeholder="请输入出版社信息" type="text" class="layui-input" maxlength="20"
                           lay-verType="tips" lay-verify="required" required/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label layui-form-required">年级</label>
                <div class="layui-input-block">
                    <input name="grade" placeholder="请输入年级" type="text" class="layui-input" maxlength="20"
                           lay-verType="tips" lay-verify="required" required/>
                </div>
            </div>
            <div class="layui-form-item">
                <label class="layui-form-label layui-form-required">学期</label>
                <div class="layui-input-block">
                    <input name="studyTeam" placeholder="请输入学期" type="text" class="layui-input" maxlength="20"
                           lay-verType="tips" lay-verify="required" required/>
                </div>
            </div>
            <div class="layui-form-item text-right">
                <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
                <button class="layui-btn" lay-filter="modelSubmitTextbook" lay-submit>保存</button>
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
            elem: '#tableTextbook',//要渲染的表格id
            url: '${ctx}/course/textbook/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 80,
            cols: [[
                {type: 'numbers'},
                {field: 'name', sort: true, title: '教材名称'},
                {field: 'press', sort: true, title: '出版社'},
                {field: 'grade', sort: true, title: '年级'},
                {field: 'studyTeam', sort: true, title: '学期'},
                {
                    field: 'subject', sort: true, templet: function (d) {
                        return d.subject.name;
                    }, title: '学科'
                },
                {align: 'center', toolbar: '#tableBarTextbook', title: '操作', minWidth: 250}
            ]]
        });

        // 添加
        $('#btnAddTextbook').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchTextbook)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableTextbook)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.name);
            } else if (layEvent === 'outline') { // 查看大纲
                //新开一个页面
                layui.use(['index'], function () {
                    var index = layui.index;
                    index.openTab({
                        title: data.name + '教学大纲',
                        url: '/course/outline/'+data.id,
                        end: function() {
                        }
                    });
                });
            }
        });

        // 显示表单弹窗
        function showEditModel(mTextbook) {
            admin.open({
                type: 1,
                title: (mTextbook ? '修改' : '添加') + '教材',
                content: $('#modelTextbook').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = '${ctx}/course/textbook/saveOrUpdate';
                    // 回显数据
                    form.val('modelTextbookForm', mTextbook);
                    // 表单提交事件
                    form.on('submit(modelSubmitTextbook)', function (data) {
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
        function doDel(textbookId, textbookname) {
            layer.confirm('确定要删除“' + textbookname + '”吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('${ctx}/course/textbook/delete', {
                    id: textbookId
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