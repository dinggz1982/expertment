<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>知识点管理</title>
    <%@include file="/WEB-INF/views/include/include.jsp" %>
    <style>
        /* 左树 */
        #knowledgeTreeBar {
            padding: 10px 15px;
            border: 1px solid #e6e6e6;
            background-color: #f2f2f2;
        }

        #knowledgeTree {
            border: 1px solid #e6e6e6;
            border-top: none;
            padding: 10px 5px;
            overflow: auto;
            height: -webkit-calc(100vh - 125px);
            height: -moz-calc(100vh - 125px);
            height: calc(100vh - 125px);
        }

        .layui-tree-entry .layui-tree-txt {
            padding: 0 5px;
            border: 1px transparent solid;
            text-decoration: none !important;
        }

        .layui-tree-entry.ew-tree-click .layui-tree-txt {
            background-color: #fff3e0;
            border: 1px #FFE6B0 solid;
        }

        /* 右表搜索表单 */
        #knowledgeUserTbSearchForm .layui-form-label {
            box-sizing: border-box !important;
            width: 90px !important;
        }

        #knowledgeUserTbSearchForm .layui-input-block {
            margin-left: 90px !important;
        }
    </style>
</head>
<body>
<!-- 正文开始 -->
<div class="layui-fluid" style="padding-bottom: 0;">
    <div class="layui-form toolbar">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label w-auto">选择学科：</label>
                <div class="layui-input-inline mr0">
                   <select name="subject" id="subject" lay-filter="changeSubject">
                        <c:forEach items="${subjects}" var="subject">
                            <option value="${subject.id}">${subject.name}</option>
                        </c:forEach>
                   </select>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md3">
            <div class="layui-card">
                <div class="layui-card-body" style="padding: 10px;">
                    <!-- 树工具栏 -->
                    <div class="layui-form toolbar" id="knowledgeTreeBar">
                        <button id="knowledgeAddBtn" class="layui-btn layui-btn-sm icon-btn">
                            <i class="layui-icon">&#xe654;</i>添加
                        </button>&nbsp;
                        <button id="knowledgeEditBtn" class="layui-btn layui-btn-sm layui-btn-warm icon-btn">
                            <i class="layui-icon">&#xe642;</i>修改
                        </button>&nbsp;
                        <button id="knowledgeDelBtn"
                                class="layui-btn layui-btn-sm layui-btn-danger icon-btn">
                            <i class="layui-icon">&#xe640;</i>删除
                        </button>
                    </div>
                    <!-- 左树 -->
                    <div id="knowledgeTree"></div>
                </div>
            </div>
        </div>
        <div class="layui-col-md9">
            <div class="layui-card">
                <div class="layui-card-body" style="padding: 10px;">
                    <iframe id="graph" src="" width="100%" height="100%"></iframe>
                    <!-- 数据表格 -->
                   <%-- <table id="knowledgeUserTable" lay-filter="knowledgeUserTable"></table>--%>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 表单弹窗1 -->
<script type="text/html" id="knowledgeEditDialog">
    <form id="knowledgeEditForm" lay-filter="knowledgeEditForm" class="layui-form model-form"
          style="padding-right: 20px;">
        <input name="id" type="hidden"/>
        <div class="layui-row">
            <div class="layui-col-md12">
                <input type="hidden" id="subjectId"  name="subjectId" value="${subject.id}">
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">父知识点:</label>
                    <div class="layui-input-block">
                        <div id="knowledgeEditParentSel" class="ew-xmselect-tree"></div>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">知识点:</label>
                    <div class="layui-input-block">
                        <input name="name" placeholder="请输入知识点" class="layui-input"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">排序号:</label>
                    <div class="layui-input-block">
                        <input name="sortNumber" placeholder="请输入排序号" class="layui-input" type="number"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item text-right">
                    <button class="layui-btn" lay-filter="knowledgeEditSubmit" lay-submit>保存</button>
                    <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
                </div>
            </div>
        </div>
    </form>
</script>
<!-- 表格操作列 -->
<script type="text/html" id="knowledgeUserTbBar">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>


<!-- js部分 -->
<script>
    layui.use(['layer', 'form', 'table', 'util', 'admin', 'tree', 'dropdown', 'xmSelect', 'treeTable'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var util = layui.util;
        var admin = layui.admin;
        var tree = layui.tree;
        var xmSelect = layui.xmSelect;
        var selObj, treeData;  // 左树选中数据

        form.on('select(changeSubject)', function(data){
            //alert(data.value);
            $("#subjectId").val= data.value;
            renderTree(data.value);
            $('#graph').attr('src', '/knowledge/relation/graph/'+data.value);
            //console.log(data);
           // alert($(data.elem).find("option:selected").text());
            $("#subjectName").val($(data.elem).find("option:selected").text());

        });

        /* 渲染知识树 */
        function renderTree(subjectId) {
            //alert(subjectId);
            $.post('${ctx}/knowledge/knowledge/tree/'+subjectId, function (res) {
                console.log(res);
                for (var i = 0; i < res.data.length; i++) {
                    res.data[i].title = res.data[i].name;
                    res.data[i].id = res.data[i].id;
                    res.data[i].spread = true;
                }
                treeData = layui.treeTable.pidToChildren(res.data, 'id', 'parentId');
                tree.render({
                    elem: '#knowledgeTree',
                    onlyIconControl: true,
                    data: treeData,
                    click: function (obj) {
                        selObj = obj;
                        $('#knowledgeTree').find('.ew-tree-click').removeClass('ew-tree-click');
                        $(obj.elem).children('.layui-tree-entry').addClass('ew-tree-click');
                        /*insTb.reload({
                            where: {knowledgeId: obj.data.knowledgeId},
                            page: {curr: 1},
                            url: '../../json/user.json'
                        });*/
                    }
                });
                $('#knowledgeTree').find('.layui-tree-entry:first>.layui-tree-main>.layui-tree-txt').trigger('click');
            });
        }

        //renderTree(1);
        /* 添加 */
        $('#knowledgeAddBtn').click(function () {
            showEditModel(null, selObj ? selObj.data.parentId : null);
        });

        /* 修改 */
        $('#knowledgeEditBtn').click(function () {
            if (!selObj) return layer.msg('未选择知识点', {icon: 2});
            showEditModel(selObj.data);
        });

        /* 删除 */
        $('#knowledgeDelBtn').click(function () {
            if (!selObj) return layer.msg('未选择知识点', {icon: 2});
            doDel(selObj);
        });

        /* 显示表单弹窗 */
        function showEditModel(mData, pid) {
            admin.open({
                type: 1,
                area: '600px',
                title: (mData ? '修改' : '添加') + '知识点',
                content: $('#knowledgeEditDialog').html(),
                success: function (layero, dIndex) {
                    // 回显表单数据
                    // v1 =  $("#subjectName").val();
                    // mData = new Object[20];
                    form.val('knowledgeEditForm', mData);
                    // 表单提交事件
                    form.on('submit(knowledgeEditSubmit)', function (data) {
                        data.field.parentId = insXmSel.getValue('valueStr');
                        //alert($("#subjectId").val());
                       //alert($("#subjectId").val());
                        data.field.subjectId = $("#subject").val();
                        //console.log(data.field);
                        var url = "/knowledge/knowledge/saveOrUpdate";
                        var loadIndex = layer.load(2);
                        $.post(url, data.field, function (res) {
                            layer.close(loadIndex);
                            if (200 === res.code) {
                                layer.close(dIndex);
                                layer.msg(res.msg, {icon: 1});
                                renderTree(data.field.subjectId);
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }, 'json');
                        return false;
                    });
                    // 渲染下拉树
                    var insXmSel = xmSelect.render({
                        el: '#knowledgeEditParentSel',
                        height: '250px',
                        data: treeData,
                        initValue: mData ? [mData.parentId] : (pid ? [pid] : []),
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
                    // 禁止弹窗出现滚动条
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                }
            });
        }

        /* 删除 */
        function doDel(obj) {
           // console.log(obj)
            layer.confirm('确定要删除此知识点吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (i) {
                layer.close(i);
                var loadIndex = layer.load(2);
                $.post('/knowledge/knowledge/delete', {
                    id: obj.data.id,
                }, function (res) {
                    layer.close(loadIndex);
                    if (200 === res.code) {
                        layer.msg(res.msg, {icon: 1});
                       // alert($("subjectId").val());
                        renderTree($("subjectId").val());
                    } else {
                        layer.msg(res.msg, {icon: 2});
                    }
                }, 'json');
            });
        }
    });
</script>
</html>
