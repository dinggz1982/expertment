<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>新增试题基本信息</title>
    <%@include file="/WEB-INF/views/include/include.jsp" %>
    <style>
        [lay-filter="formStepsStep"] .layui-form-item {
            margin-bottom: 25px;
        }
    </style>
</head>
<!-- 正文开始 -->
<div class="layui-fluid">
    <div style="text-align: center"><h1>第一步：录入试题基本信息</h1></div>
    <div class="layui-card">
        <div class="layui-card-body">
            <!-- 表单开始 -->
            <form class="layui-form" id="formBasForm" lay-filter="formBasForm">
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">标题:</label>
                    <div class="layui-input-block">
                        <input name="title" placeholder="标题" class="layui-input"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">分数:</label>
                    <div class="layui-input-block">
                        <input name="score" placeholder="分数" class="layui-input"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">难度系数:</label>
                    <div class="layui-input-block">
                        <input type="radio" name="difficult" value="1" title="1" checked="">
                        <input type="radio" name="difficult" value="2" title="2">
                        <input type="radio" name="difficult" value="3" title="3">
                        <input type="radio" name="difficult" value="4" title="4">
                        <input type="radio" name="difficult" value="5" title="5">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label layui-form-required">试题类型:</label>
                    <div class="layui-input-block">
                        <input type="radio" name="type" value="1" title="单选题" checked="">
                        <input type="radio" name="type" value="2" title="多选题">
                        <input type="radio" name="type" value="3" title="判断题">
                        <input type="radio" name="type" value="4" title="简答题">
                        <input type="radio" name="type" value="5" title="论述题">
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label layui-form-required">课程目录:</label>
                    <div class="layui-input-block">
                        <input name="outlineId" placeholder="课程目录" class="layui-input"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label layui-form-required">知识点:</label>
                    <div class="layui-input-block">
                        <div id="knowledge" class="ew-xmselect-tree"></div>
                        <%--  <input name="knowledge" placeholder="知识点" class="layui-input"
                                     lay-verType="tips" lay-verify="required" required/>--%>
                    </div>
                </div>
                <div class="layui-form-item">
                    <div class="layui-input-block">
                        <button class="layui-btn" lay-filter="formBasSubmit" lay-submit>&emsp;提交&emsp;</button>
                        <button type="reset" class="layui-btn layui-btn-primary">&emsp;重置&emsp;</button>
                    </div>
                </div>
            </form>
            <!-- //表单结束 -->
        </div>
    </div>
</div>

<!-- js部分 -->
<script>
    layui.use(['layer', 'treeTable', 'xmSelect', 'form', 'laydate', 'tree'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var laydate = layui.laydate;
        var tree = layui.tree;
        var xmSelect = layui.xmSelect;
        var treeData;

        var insXmSel = xmSelect.render({
            el: '#knowledge',
            height: '250px',
            data: layui.treeTable.pidToChildren(JSON.parse('${knowledges}'), 'id', 'parentId'),
            initValue: null,
            model: {label: {type: 'text'}},
            prop: {
                name: 'name',
                value: 'id'
            },
            radio: true,
            clickClose: true,
            tree: {
                show: true,
                indent: 15,
                strict: false,
                expandedKeys: true
            }
        });

        /* 渲染laydate */
        laydate.render({
            elem: '#formBasDateSel',
            trigger: 'click',
            range: true
        });

        /* 渲染知识树 */
        function renderTree(subjectId) {
//alert(subjectId);
            $.post('${ctx}/knowledge/knowledge/tree/' + subjectId, function (res) {
                console.log(res);
                for (var i = 0; i < res.data.length; i++) {
                    res.data[i].title = res.data[i].name;
                    res.data[i].id = res.data[i].id;
                    res.data[i].spread = true;
                }
                treeData = layui.treeTable.pidToChildren(res.data, 'id', 'parentId');
            });
        }

// 渲染下拉树


        /* 监听表单提交 */
        form.on('submit(formBasSubmit)', function (data) {
            var url = "/course/baseQuestion/saveOrUpdate";
            $.post(url, data.field, function (res) {
                if (200 === res.code) {
                    layer.msg(res.msg, {icon: 1});
                    if (data.field.type == 1) {
                        window.location.href = "/course/singleChoice/edit/" + res.id;
                    }
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            }, 'json');
            return false;
        });

    });
</script>
</body>
</html>
