<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>权限菜单</title>
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
                            <input id="edtSearchAuth" class="layui-input" placeholder="输入关键字"/>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <button id="btnSearchAuth" class="layui-btn icon-btn"><i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddAuth" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加</button>
                    </div>
                </div>
            </div>

            <table id="tableAuth"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarAuth">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<!-- 表单弹窗 -->
<script type="text/html" id="modelAuth">
    <form id="modelAuthForm" lay-filter="modelAuthForm" class="layui-form model-form">
        <input name="id" type="hidden"/>
        <div class="layui-form-item">
            <label class="layui-form-label">上级菜单</label>
            <div class="layui-input-block">
                <div id="menuParentSel" class="ew-xmselect-tree"></div>
                <%--<select name="pId" lay-search>
                    <option value="">请选择上级菜单</option>
                    <c:forEach items="${menus}" var="menu">
                        <option value="${menu.id}">${menu.name}</option>
                    </c:forEach>
                </select>--%>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">权限名称</label>
            <div class="layui-input-block">
                <input name="name" placeholder="请输入权限名称" type="text" class="layui-input" maxlength="50"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">权限类型</label>
            <div class="layui-input-block">
                <input name="type" type="radio" value="0" title="菜单" checked/>
                <input name="type" type="radio" value="1" title="按钮"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">菜单url</label>
            <div class="layui-input-block">
                <input name="url" placeholder="请输入菜单url" type="text" class="layui-input"/>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">菜单图标</label>
            <div class="layui-input-block">
                <input name="icon" placeholder="请输入菜单图标" type="text" class="layui-input"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">排序号</label>
            <div class="layui-input-block">
                <input name="orderNumber" placeholder="请输入排序号" type="number" class="layui-input" min="0" max="1000"
                       lay-verType="tips" lay-verify="required|number" required/>
            </div>
        </div>
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitAuth" lay-submit>保存</button>
        </div>
    </form>
</script>
<script>
    layui.use(['layer', 'form', 'admin','xmSelect', 'treeTable', 'util'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var admin = layui.admin;
        var treeTable = layui.treeTable;
        var util = layui.util;
        var xmSelect = layui.xmSelect;
        var menuTree;

        // 渲染表格
        var insTb = treeTable.render({
            elem: '#tableAuth',
            tree: {
                iconIndex: 1,  // 折叠图标显示在第几列
                idName: 'id',  // 自定义id字段的名称
                pidName: 'parentId',  // 自定义标识是否还有子节点的字段名称
                isPidData: true  // 是否是pid形式数据
            },
            cellMinWidth: 100,
            cols: [
                {type: 'numbers'},
                {field: 'name', title: '权限名称', width: 260},
                {field: 'url', title: '菜单url'},
                {field: 'orderNumber', title: '排序号', align: 'center', width: 100},
                {title: '菜单图标', templet: '<p><i class="{{d.icon}}"></i></p>', align: 'center', width: 100},
                {
                    title: '类型', templet: function (d) {
                        if(d.type){
                            return '<span class="layui-badge layui-badge-blue">按钮</span>';
                        }else{
                            return '<span class="layui-badge layui-badge-green">菜单</span>';
                        }
                    }, align: 'center', width: 100
                },
                {
                    templet: function (d) {
                        return util.toDateString(d.createTime);
                    }, title: '创建时间', align: 'center'
                },
                {templet: '#tableBarAuth', title: '操作', align: 'center', width: 160}
            ],
            reqData: function (data, callback) {
                $.get('/system/menu/authorities', function (res) {
                    menuTree = res.data;
                   // console.log(menuTree);
                    callback(res.data);
                });
            }
        });

        // 搜索
        $('#btnSearchAuth').click(function () {
            var keyword = $('#edtSearchAuth').val();
            if (keyword) {
                insTb.filterData(keyword);
            } else {
                insTb.clearFilter();
            }
        });

        // 添加按钮点击事件
        $('#btnAddAuth').click(function () {
            showEditModel();
        });

        // 工具条点击事件
        treeTable.on('tool(tableAuth)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data,data.parentId);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.name);
            }
        });

        // 显示表单弹窗
        function showEditModel(mAuth,parentId) {
            //alert(pid);
            //console.log(mAuth);
            admin.open({
                type: 1,
                title: (mAuth ? '修改' : '添加') + '权限',
                content: $('#modelAuth').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url ='/system/menu/saveOrUpdate';
                    if (mAuth && mAuth.type == '1') {
                        $('#modelAuthForm input[name="type"][value="1"]').prop("checked", true);
                    }
                    form.val('modelAuthForm', mAuth);  // 回显数据
                    // 表单提交事件

                    form.on('submit(modelSubmitAuth)', function (data) {
                        // if (data.field.parentId == '') {
                        //     data.field.parentId = '-1';
                        // }
                       //console.log(insXmSel.getValue()[0].id);
                       // console.log(data.field);
                       // alert(data.field.pid);
                       // alert(insXmSel.getValue('valueStr'));
                        layer.load(2);
                        data.field.parentId = insXmSel.getValue('valueStr');
                        $.post(url, data.field, function (res) {
                            layer.closeAll('loading');
                            if (res.code == 200) {
                                layer.close(dIndex);
                                layer.msg(res.msg, {icon: 1});
                                insTb.refresh();
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }, 'json');
                        return false;
                    });

                    // 渲染下拉树
                    var insXmSel = xmSelect.render({
                        el: '#menuParentSel',
                        height: '250px',
                        data: menuTree,
                        //name:'pId',
                        initValue: mAuth ? [mAuth.parentId] : (parentId ? [parentId] : []),
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

                }
            });
        }

        // 删除
        function doDel(id, name) {
            layer.confirm('确定要删除“' + name + '”吗？', {
                skin: 'layui-layer-admin',
                shade: .1
            }, function (index) {
                layer.close(index);
                layer.load(2);
                $.post('/system/menu/delete', {
                    id: id
                }, function (res) {
                    layer.closeAll('loading');
                    if (res.code == 200) {
                        layer.msg(res.msg, {icon: 1});
                        insTb.refresh();
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
