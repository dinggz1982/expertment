<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验室管理</title>
        <%--        <link rel="stylesheet" href="/element-ui/index.css">--%>
        <%@include file="/WEB-INF/views/include/include.jsp" %>
        <%--        <script type="text/javascript" src="/vue/vue.js"></script>--%>
        <%--        <script type="text/javascript" src="/element-ui/index.js"></script>--%>
    </head>
    <body>
        <%--        <div id="app">--%>
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
                                <label class="layui-form-label w-auto">实验申请：</label>
                                <div class="layui-input-inline mr0">
                                    <input name="name" class="layui-input" type="text" placeholder="输入实验申请"/>
                                </div>
                            </div>
                            <!-- <div class="layui-inline">
                                <label class="layui-form-label w-auto">实验室地址：</label>
                                <div class="layui-input-inline mr0">
                                    <input name="address" class="layui-input" type="text" placeholder="实验室地址"/>
                                </div>
                            </div> -->
                            <div class="layui-inline" style="padding-right: 110px;">
                                <button class="layui-btn icon-btn" lay-filter="formSubSearchLab" lay-submit>
                                    <i class="layui-icon">&#xe615;</i>搜索
                                </button>
                                <%--                                <button class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加--%>
                                <button id="btnAddLab" class="layui-btn icon-btn"><i class="layui-icon">&#xe654;</i>添加
                                </button>

                                <%--                                <a lay-href="/jfoiew">文本</a>--%>
                            </div>
                        </div>
                    </div>
                    <table id="tableLab" lay-filter="tableLab"></table>
                </div>
            </div>
        </div>
        <%--        </div>--%>
        <!-- 表格操作列 -->
        <script type="text/html" id="tableBarLab">
            <a class="layui-btn layui-btn-primary layui-btn-xs" lay-event="edit">修改</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="recall">撤回</a>
            <a class="layui-btn layui-btn-xs" lay-event="detail">查看实验详细情况</a>
        </script>

        <%--        <!-- 表单弹窗 -->--%>
        <%--        <script type="text/html" id="modelLab">--%>
        <%--            <div style="height: 400px;width: 800px;overflow: auto">--%>
        <%--                <form id="modelLabForm" lay-filter="modelLabForm" class="layui-form model-form">--%>
        <%--                    <input name="id" type="hidden"/>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">申请人</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="applyUserName" placeholder="请输入申请人姓名" type="text" class="layui-input"--%>
        <%--                                   maxlength="20"--%>
        <%--                                   lay-verType="tips" value="${currentUser.realName}" readonly lay-verify="required"--%>
        <%--                                   required/>--%>
        <%--                        </div>--%>
        <%--                        <input type="hidden" name="applyUserId" value="${currentUser.id}">--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">实验名称</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="name" placeholder="请输入实验申请" type="text" class="layui-input" maxlength="20"--%>
        <%--                                   lay-verType="tips" lay-verify="required" required/>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">实验室</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <select name="labId">--%>
        <%--                                <c:forEach items="${labs}" var="lab">--%>
        <%--                                    <option value="${lab.id}">${lab.name}</option>--%>
        <%--                                </c:forEach>--%>
        <%--                            </select>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>

        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">实验类型</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <select name="typeId">--%>
        <%--                                <c:forEach items="${types}" var="type">--%>
        <%--                                    <option value="${type.id}">${type.name}</option>--%>
        <%--                                </c:forEach>--%>
        <%--                            </select>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">实验时</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="hours" placeholder="请输入实验时" type="text" class="layui-input" maxlength="20"--%>
        <%--                                   lay-verType="tips" lay-verify="required" required/>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">所需被试数</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="number" placeholder="请输入所需被试数" type="text" class="layui-input"--%>
        <%--                                   maxlength="20"--%>
        <%--                                   lay-verType="tips" lay-verify="required" required/>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">学年</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="teamYear" id="teamYear" placeholder="请选择学年" type="text"--%>
        <%--                                   class="layui-input" maxlength="20" lay-verify="teamYear" autocomplete="off"--%>
        <%--                                   required/>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>

        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">学期</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <select name="teamId">--%>
        <%--                                <c:forEach items="${teamType}" var="team">--%>
        <%--                                    <option value="${team.id}">${team.name}</option>--%>
        <%--                                </c:forEach>--%>
        <%--                            </select>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>

        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">有效日期</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <input name="dateTime" id="dateTime" placeholder="yyyy-MM-dd HH:mm:ss" type="text"--%>
        <%--                                   class="layui-input" maxlength="20"--%>
        <%--                                   autocomplete="off" required/>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">时间段</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <el-date-picker--%>
        <%--                                    v-model="value1"--%>
        <%--                                    type="datetimerange"--%>
        <%--                                    range-separator="至"--%>
        <%--                                    start-placeholder="开始日期"--%>
        <%--                                    end-placeholder="结束日期">--%>
        <%--                            </el-date-picker>--%>
        <%--                        </div>--%>
        <%--                    </div>--%>

        <%--                    <div class="layui-form-item">--%>
        <%--                        <label class="layui-form-label layui-form-required">实验简介</label>--%>
        <%--                        <div class="layui-input-block">--%>
        <%--                            <textarea id="description" name="description" style="display: none;"></textarea>--%>

        <%--                        </div>--%>
        <%--                    </div>--%>
        <%--                    <div class="layui-form-item text-right">--%>
        <%--                        <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消--%>
        <%--                        </button>--%>
        <%--                        <button class="layui-btn" lay-filter="modelSubmitLab" lay-submit>保存</button>--%>
        <%--                    </div>--%>
        <%--                </form>--%>
        <%--            </div>--%>
        <%--        </script>--%>
        <%--        <!-- js部分 -->--%>
        <script>
            layui.use(['layer', 'index', 'form', 'admin', 'element', 'table', 'laydate', 'layedit', 'util', 'admin'], function () {
                var $ = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                var table = layui.table;
                var util = layui.util;
                var layedit = layui.layedit;
                var admin = layui.admin;
                var element = layui.element;
                var laydate = layui.laydate;
                var index = layui.index;
                // 渲染表格
                var insTb = table.render({
                    elem: '#tableLab',//要渲染的表格id
                    url: '${ctx}/experiment/apply/list.json',
                    page: true,
                    toolbar: true,
                    cellMinWidth: 100,
                    cols: [[
                        {type: 'numbers'},
                        {
                            field: 'applyTime', sort: true, templet: function (d) {
                                // console.log('applyime', d)
                                if (d.applyTime) {
                                    return util.toDateString(d.applyTime);
                                }
                                return ''
                            }, title: '申请时间'
                        },
                        {
                            field: 'approve', sort: true, templet: function (d) {
                                var status = d.status;
                                if (status === 0 || status === 8 || status === 4 || status === 5) {
                                    return "<a class='layui-btn layui-btn-primary layui-btn-xs' lay-event='approve'>提交申请</a>";
                                } else {
                                    return "已提交申请";
                                }
                            }, title: '提交申请'
                        },
                        {
                            field: 'status', sort: true, templet: function (d) {
                                var status = d.status;
                                var result = "";
                                switch (status) {
                                    case 0:
                                        result = "未提交";
                                        break;
                                    case 1:
                                        result = "等待导师审批";
                                        break;
                                    case 2:
                                        result = "导师已确认";
                                        break;
                                    case 3:
                                        result = "管理员已确认";
                                        break;
                                    case 4:
                                        result = "导师驳回";
                                        break;
                                    case 5:
                                        result = "管理员驳回";
                                        break;
                                    case 6:
                                        result = "数据收集中";
                                        break;
                                    case 7:
                                        result = "已完成";
                                        break;
                                    case 8:
                                        result = "已撤回";
                                        break;
                                    default:
                                        result = "未知状态";
                                }
                                return result;
                            }, title: '状态'
                        },
                        {field: 'name', sort: true, title: '申请名称'},
                        {
                            field: 'applyUser', sort: true, title: '申请人',
                            templet: function (d) {
                                return d.applyUser.realName;
                            }
                        },

                        {field: 'finishNumber', sort: true, title: '已完成被试数', minWidth: 20},
                        {field: 'applyNumber', sort: true, title: '已报名被试数', minWidth: 20},
                        {
                            // align: 'center', toolbar: '#tableBarLab', title: '操作', minWidth: 300,
                            align: 'center', title: '操作', minWidth: 300,
                            templet: function (d) {
                                var status = d.status
                                if (status === 0 || status === 8) {
                                    return "<a class='layui-btn layui-btn-primary layui-btn-xs' lay-event='edit'>修改</a>" +
                                        "<a class='layui-btn layui-btn-danger layui-btn-xs' lay-event='del'>删除</a>" +
                                        "<a class='layui-btn layui-btn-danger layui-btn-xs' lay-event='recall'>撤回</a>" +
                                        "<a class='layui-btn layui-btn-xs' lay-event='detail'>查看实验详细情况</a>"
                                } else {
                                    return "<a class='layui-btn layui-btn-danger layui-btn-xs' lay-event='del'>删除</a>" +
                                        "<a class='layui-btn layui-btn-danger layui-btn-xs' lay-event='recall'>撤回</a>" +
                                        "<a class='layui-btn layui-btn-xs' lay-event='detail'>查看实验详细情况</a>"
                                }
                            }
                        }
                    ]]
                });
                var learnYearStart
                var learnYearEnd
                var h = "admin-pagetabs";
                // 搜索
                form.on('submit(formSubSearchLab)', function (data) {
                    insTb.reload({where: data.field}, 'data');
                });
                form.verify({
                    teamYear: (date) => {
                        if (learnYearStart === null || learnYearStart === undefined) {
                            return "请选择日期"
                        }
                        if (learnYearEnd === null || learnYearEnd === undefined) {
                            return "请选择日期"
                        }
                        if (learnYearEnd - learnYearStart !== 1) {
                            return "选择的学年不正确"
                        }
                    }
                })
                // 工具条点击事件
                table.on('tool(tableLab)', function (obj) {
                    var data = obj.data;
                    var layEvent = obj.event;
                    if (layEvent === 'edit') { // 修改
                        // console.log("edit", data)
                        layui.use(['index'], function () {
                            var index = layui.index;
                            index.openTab({
                                title: '修改实验：' + data.name,
                                url: '/experiment/updateApply/' + data.id,
                                end: function () {
                                }
                            });
                        });
                        // showEditModel(data);
                    } else if (layEvent === 'del') { // 删除
                        doDel(data.id, data.name);
                    } else if (layEvent === 'recall') {
                        //撤回
                        // console.log('撤回', data.id, data.name)
                        doRecall(data.id, data.name);
                    } else if (layEvent === 'detail') { // 查看实验室详细情况
                        //新开一个页面
                        layui.use(['index'], function () {
                            var index = layui.index;
                            index.openTab({
                                title: '实验：' + data.name + '详细情况',
                                url: '/experiment/show/' + data.id,
                                end: function () {
                                }
                            });
                        });

                    } else if (layEvent === 'approve') {
                        doApprove(data.id, data.name);
                    }
                });
                // 添加
                $('#btnAddLab').click(function () {
                    let v = '/experiment/add'
                    index.openTab({
                        title: '添加新实验',
                        url: v,
                        end: function () {
                        }
                    });

                    // parent.layui.index.loadView({menuId: v, menuPath: v, menuName: '添加新实验'})
                });

                // 显示表单弹窗
                function showEditModel(mLab) {
                    admin.open({
                            type: 1,
                            area: ['800px', '450px'],
                            title: (mLab ? '修改' : '添加') + '实验申请',
                            content: $('#modelLab').html(),
                            success: function (layero, dIndex) {
                                $(layero).children('.layui-layer-content').css('overflow', 'visible');
                                var url = '${ctx}/experiment/apply/saveOrUpdate';
                                // 回显数据
                                form.val('modelLabForm', mLab);
                                var mylayedit = layui.layedit;
                                mylayedit.set({
                                    uploadImage: {
                                        url: '/experiment/lab/uploadImages'//接口url
                                        , type: '' //默认post
                                    }
                                });

                                //学年日期
                                laydate.render({
                                    elem: '#teamYear'
                                    , type: 'year'
                                    , range: true,
                                    done: (value, date, endDate) => {
                                        learnYearStart = date.year
                                        learnYearEnd = endDate.year
                                    }
                                });
                                //日期
                                laydate.render({
                                    elem: '#dateTime'
                                    , type: 'datetime'
                                    , range: true
                                });
                                var desc = mylayedit.build('description'); //建立编辑器
                                // 表单提交事件
                                form.on('submit(modelSubmitLab)', function (data) {
                                    console.log('submit,', data)
                                    layer.load(2);
                                    data.field.description = layedit.getContent(desc);
                                    $.post(url, data.field, function (res) {
                                        layer.closeAll('loading');
                                        if (res.code === 200) {
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
                        }
                    );
                }

                //撤回
                function doRecall(labId, labname) {
                    layer.confirm('确定要撤回“' + labname + '”吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.get('${ctx}/experiment/apply/recall/' + labId, function (res) {
                            layer.closeAll('loading');
                            if (res.code === 200) {
                                layer.msg(res.msg, {icon: 1});
                                insTb.reload({}, 'data');
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        })
                    })
                }

                // 删除
                function doDel(labId, labname) {
                    layer.confirm('确定要删除“' + labname + '”吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.post('${ctx}/experiment/apply/delete', {
                            id: labId
                        }, function (res) {
                            layer.closeAll('loading');
                            if (res.code === 200) {
                                layer.msg(res.msg, {icon: 1});
                                insTb.reload({}, 'data');
                            } else {
                                layer.msg(res.msg, {icon: 2});
                            }
                        }, 'json');
                    });
                }

                // 审批
                function doApprove(labId, labname) {
                    layer.confirm('确定要提交申请“' + labname + '”吗？', {
                        skin: 'layui-layer-admin',
                        shade: .1
                    }, function (i) {
                        layer.close(i);
                        layer.load(2);
                        $.post('${ctx}/experiment/apply/approve', {
                            id: labId
                        }, function (res) {
                            layer.closeAll('loading');
                            if (res.code === 200) {
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
