<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>知识关联</title>
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
                        <label class="layui-form-label w-auto">知识点：</label>
                        <div class="layui-input-inline mr0">
                            <input name="name" class="layui-input" type="text" placeholder="请输入知识点"/>
                        </div>
                    </div>
                    <!-- <div class="layui-inline">
                        <label class="layui-form-label w-auto">学科地址：</label>
                        <div class="layui-input-inline mr0">
                            <input name="address" class="layui-input" type="text" placeholder="学科地址"/>
                        </div>
                    </div> -->
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchRelation" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddRelation" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                        </button>
                    </div>
                </div>
            </div>
            <table id="tableRelation" lay-filter="tableRelation"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarRelation">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
    <%-- <a class="layui-btn layui-btn-xs" lay-event="detail">查看学科知识点</a>--%>
</script>

<!-- 表单弹窗 -->
<script type="text/html" id="modelRelation">
    <form id="modelRelationForm" lay-filter="modelRelationForm" class="layui-form model-form">
        <input name="id" type="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">知识点</label>
            <div class="layui-input-block">
                <select name="koAId" lay-verify="required" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${kos}" var="ko">
                        <option value="${ko.id}">${ko.name}</option>
                    </c:forEach>
                </select>
                <%--<input name="koA" placeholder="请输入知识点" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>--%>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">关系</label>
            <div class="layui-input-block">
                <input name="relation" placeholder="请输入关系" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">关联知识点</label>
            <div class="layui-input-block">
                <select name="koBId" lay-verify="required" lay-search="">
                    <option value="">直接选择或搜索选择</option>
                    <c:forEach items="${kos}" var="ko">
                        <option value="${ko.id}">${ko.name}</option>
                    </c:forEach>
                </select>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitRelation" lay-submit>保存</button>
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
            elem: '#tableRelation',//要渲染的表格id
            url: '${ctx}/knowledge/relation/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {
                    field: 'koA', sort: true, title: '知识点', templet: function (d) {
                        return d.koA.name
                    }
                },
                {field: 'relation', sort: true, title: '关系'},
                {
                    field: 'koB', sort: true, title: '关联知识点', templet: function (d) {
                        return d.koB.name
                    }
                },
                {align: 'center', toolbar: '#tableBarRelation', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddRelation').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchRelation)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableRelation)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id);
            } else if (layEvent === 'detail') { // 查看学科详细情况
                // //打开学科知识点模块
                // layui.use(['index'], function () {
                //     var index = layui.index;
                //     index.openTab({
                //         title: data.name + '知识点',
                //         url: '/knowledge/knowledge?subjectId='+data.id,
                //         end: function () {
                //         }
                //     });
                // });
            }
        });

        // 显示表单弹窗
        function showEditModel(mRelation) {
            admin.open({
                type: 1,
                title: (mRelation ? '修改' : '添加') + '知识关联',
                content: $('#modelRelation').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = '${ctx}/knowledge/relation/saveOrUpdate';
                    // 回显数据
                    form.val('modelRelationForm', mRelation);
                    // 表单提交事件
                    form.on('submit(modelSubmitRelation)', function (data) {
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
        function doDel(id) {
            layer.confirm('确定要删除吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                layer.load(2);
                $.post('${ctx}/knowledge/relation/delete', {
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

    });
</script>

</body>
</html>