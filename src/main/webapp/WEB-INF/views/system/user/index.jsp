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
                        <label class="layui-form-label w-auto">学号/工号：</label>
                        <div class="layui-input-inline mr0">
                            <input name="username" class="layui-input" type="text" placeholder="输入账号"/>
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label w-auto">真实姓名：</label>
                        <div class="layui-input-inline mr0">
                            <input name="realName" class="layui-input" type="text" placeholder="输入用户名"/>
                        </div>
                    </div>
                    <div class="layui-inline" style="padding-right: 110px;">
                        <button class="layui-btn icon-btn" lay-filter="formSubSearchUser" lay-submit>
                            <i class="layui-icon">&#xe615;</i>搜索
                        </button>
                        <button id="btnAddUser" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加</button>

                    </div>
                    <div class="layui-inline">
                        批量上传用户<a href="#">(模板下载)</a>
                        <button type="button" class="layui-btn layui-btn-normal" id="test1">选择文件</button>
                        <button class="layui-btn" id="uploadFileBtn">开始上传</button>
                    </div>
                </div>
            </div>

            <table id="tableUser" lay-filter="tableUser"></table>
        </div>
    </div>
</div>

<!-- 表格操作列 -->
<script type="text/html" id="tableBarUser">
    <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
  <%--  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>--%>
    <a class="layui-btn layui-btn-xs" lay-event="reset">重置密码</a>
</script>
<!-- 表格状态列 -->
<script type="text/html" id="tableStateUser">
    <input type="checkbox" lay-filter="ckStateUser" value="{{d.userId}}" lay-skin="switch"
           lay-text="正常|锁定" {{d.state==0?'checked':''}}/>
</script>
<!-- 表单弹窗 -->
<script type="text/html" id="modelUser">
    <form id="modelUserForm" lay-filter="modelUserForm" class="layui-form model-form">
        <input name="id" type="hidden" value="0"/>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">学号/工号</label>
            <div class="layui-input-block">
                <input name="username" id="userename" placeholder="请输入学号/工号" type="text" class="layui-input"
                       maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item" name="passwd">
            <label class="layui-form-label layui-form-required">密码</label>
            <div class="layui-input-block">
                <input name="password" placeholder="请输入密码" type="password" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">真实姓名</label>
            <div class="layui-input-block">
                <input name="realName" placeholder="请输入真实姓名" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">邮箱</label>
            <div class="layui-input-block">
                <input name="email" placeholder="请输入邮箱" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">电话</label>
            <div class="layui-input-block">
                <input name="tel" placeholder="请输入电话" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">微信号</label>
            <div class="layui-input-block">
                <input name="weichat" placeholder="请输入微信号" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">导师工号</label>
            <div class="layui-input-block">
                <input name="teacherNo" placeholder="请输入导师工号" type="text" class="layui-input" maxlength="20"
                       lay-verType="tips" lay-verify="required" required/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">性别</label>
            <div class="layui-input-block">
                <input type="radio" name="gender" value="男" title="男" checked/>
                <input type="radio" name="gender" value="女" title="女"/>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label layui-form-required">角色</label>
            <div class="layui-input-block">
                <div id="userEditRoleSel"></div>
            </div>
        </div>
        <input type="hidden" name="roleIds">
        <div class="layui-form-item text-right">
            <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
            <button class="layui-btn" lay-filter="modelSubmitUser" lay-submit>保存</button>
        </div>
    </form>
</script>

<script>
    layui.use(['layer', 'form', 'upload', 'table', 'util', 'admin', 'xmSelect'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var table = layui.table;
        var util = layui.util;
        var admin = layui.admin;
        var upload = layui.upload;
        var xmSelect = layui.xmSelect;

        //批量导入用户
        upload.render({ //允许上传的文件后缀
            elem: '#test1'
            , url: '/system/user/saveUserFromFile' //上传接口
            , accept: 'file' //普通文件
            , exts: 'xlsx|xls' //只允许上传压缩文件
            , method: 'post'
            , done: function (res) {
                layer.msg('上传成功');
                //console.log(res)
            }, error: function (e) {
                layer.msg(e);
            }
        });

        // 渲染表格
        var insTb = table.render({
            elem: '#tableUser',
            url: '/system/user/list.json',
            page: true,
            toolbar: true,
            cellMinWidth: 100,
            cols: [[
                {type: 'numbers'},
                {field: 'username', sort: true, title: '学号/工号'},
                {field: 'realName', sort: true, title: '真实姓名'},
                {field: 'gender', sort: false, title: '性别', width: 60},
                {
                    field: 'roleName', title: '角色', templet: function (d) {
                        return d.roles.map(function (item) {
                            return '<span class="layui-badge layui-badge-gray">' + item.name + '</span>';
                        }).join('&nbsp;');
                    }, sort: true, width: 180
                },
                //{field: 'state', sort: true, templet: '#tableStateUser', title: '状态'},
                {align: 'center', toolbar: '#tableBarUser', title: '操作', minWidth: 200}
            ]]
        });

        // 添加
        $('#btnAddUser').click(function () {
            showEditModel();
        });

        // 搜索
        form.on('submit(formSubSearchUser)', function (data) {
            insTb.reload({where: data.field}, 'data');
        });

        // 工具条点击事件
        table.on('tool(tableUser)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;
            if (layEvent === 'edit') { // 修改
                showEditModel(data);
            } else if (layEvent === 'del') { // 删除
                doDel(data.id, data.realName);
            } else if (layEvent === 'reset') { // 重置密码
                resetPsw(data.id, data.realName);
            }
        });

        // 显示表单弹窗
        function showEditModel(mUser) {
            admin.open({
                type: 1,
                title: (mUser ? '修改' : '添加') + '用户',
                content: $('#modelUser').html(),
                success: function (layero, dIndex) {
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    var url = "/system/user/saveOrUpdate";//新增或修改用户
                    if (mUser == null || mUser.id === undefined) {
                    } else {
                        $("[name='username']").attr("readOnly", "readOnly");//将用户名设置为只读
                        $("[name='passwd']").css('display', 'none'); //把密码功能隐藏
                    }
                    form.val('modelUserForm', mUser);

                    // 渲染多选下拉框
                    var insRoleSel = xmSelect.render({
                        el: '#userEditRoleSel',
                        name: 'userEditRoleSel',
                        layVerify: 'required',
                        layVerType: 'tips',
                        data: [${roles}]
                    });
                    // 回显选中角色
                    if (mUser && mUser.roles) {
                        insRoleSel.setValue(mUser.roles.map(function (item) {
                            return item.id;
                        }));
                    }
                    // 禁止弹窗出现滚动条
                    $(layero).children('.layui-layer-content').css('overflow', 'visible');
                    //mUser.roleIds = insRoleSel.getValue();
                    // alert(insRoleSel.getValue());
                    // 表单提交事件
                    form.on('submit(modelSubmitUser)', function (data) {
                        layer.load(2);
                        data.field.roleIds = insRoleSel.getValue();
                        // layer.alert(JSON.stringify(data.field), {
                        //     title: '最终的提交信息'
                        // })
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
                        $("[name='username']").removeAttr("readonly");
                        return false;
                    });
                }
            });
        }

        // 删除用户
        function doDel(id, realName) {
            layer.confirm('确定要删除“' + realName + '”吗？', {
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

        // 修改用户状态
        form.on('switch(ckStateUser)', function (obj) {
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
