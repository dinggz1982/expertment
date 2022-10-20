<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>被试审批</title>
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
                            <div class="layui-row">
                                <div class="layui-col-lg4">
                                    <form>
                                        <div class="layui-form-item">
                                            <label class="layui-form-label layui-form-required">实验名称:</label>
                                            <div class="layui-input-block">
                                                <div id="userExperimentList"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <table id="tableLab" style="margin-top: 20px" lay-filter="tableLab"></table>
                </div>
            </div>
        </div>

        <%--        被试审核弹窗--%>
        <script type="text/html" id="studentApprove">
            <form id="approveForm" lay-filter="approveForm" class="layui-form model-form">
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">审批</label>
                    <div class="layui-input-block">
                        <input type="radio" name="approve" value="1" title="通过" checked="">
                        <input type="radio" name="approve" value="0" title="驳回">
                    </div>
                </div>
                <div class="layui-form-item text-right">
                    <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
                    <button class="layui-btn" lay-filter="modelSubmitApprove" lay-submit>提交</button>
                </div>
            </form>
        </script>


        <script>
            layui.use(['layer', 'form', 'admin', 'table', 'laydate', 'layedit', 'util', 'xmSelect', 'admin'], function () {
                var $ = layui.jquery;
                var layer = layui.layer;
                var form = layui.form;
                var table = layui.table;
                var util = layui.util;
                var layedit = layui.layedit;
                var admin = layui.admin;
                var laydate = layui.laydate;
                var xmSelect = layui.xmSelect;
                let insTb
                let signUpType = null

                let apply = [${apply}]
                let applyId

                $.get('${ctx}/experiment/signup/type/', res => {
                    signUpType = res.data
                })

                let insRoleSel = xmSelect.render({
                    el: '#userExperimentList',
                    name: 'userExperimentList',
                    on: data => {
                        console.log(data)
                        let arr = data.arr
                        if (arr.length === 1) {
                            applyId = arr[0].value
                        } else {
                            applyId === null
                        }
                        updateTable()
                    },
                    radio: true,
                    layVerify: 'required',
                    layVerType: 'tips',
                    data: apply
                });


                if (apply.length > 0) {
                    applyId = apply[0].value
                    insRoleSel.setValue([applyId])
                    updateTable()
                }

                function updateTable() {
                    if (applyId !== null) {
                        insTb = table.render({
                            elem: '#tableLab',//要渲染的表格id
                            url: '${ctx}/experiment/studentApprove/list/' + applyId,
                            page: true,
                            toolbar: true,
                            cellMinWidth: 100,
                            cols: [[
                                {type: 'numbers'},
                                {
                                    field: 'applyTime', sort: true, templet: function (d) {
                                        return util.toDateString(d.createTime);
                                    }, title: '申请时间'
                                },
                                {
                                    field: 'status', sort: true, templet: d => {
                                        let res = '未知审批状态'
                                        let status = d.status;
                                        signUpType.forEach(item => {
                                            if (item.id === status) {
                                                res = item.desc
                                            }
                                        })
                                        return res
                                    }, title: '状态'
                                },
                                {
                                    field: 'name', sort: true, title: '实验名称', templet: d => {
                                        return d.apply.name
                                    }
                                },
                                {
                                    field: 'applyUser', sort: true, title: '申请人',
                                    templet: d => {
                                        return d.signupUser.realName;
                                    }
                                }, {
                                    align: 'center',
                                    title: '操作',
                                    minWidth: 250,
                                    templet: function (e) {
                                        let res = ''
                                        if (e.status === 1) {
                                            res += "<a class='layui-btn layui-btn-xs' lay-event='approve'>审核</a>"
                                        }
                                        res += "<a class='layui-btn layui-btn-xs' lay-event='detail'>查看实验详细情况</a>"
                                        return res
                                    }
                                }
                            ]]
                        });
                    } else {
                    }
                }

                table.on('tool(tableLab)', function (obj) {
                    // console.log('table.on,obj:', obj)
                    let data = obj.data;
                    if (obj.event === 'approve') {
                        showApprove(data);
                    } else if (obj.event === 'detail') {
                        // console.log('data:', data)
                        layui.use(['index'], function () {
                            var index = layui.index;
                            index.openTab({
                                title: '实验：' + data.apply.name + '详细情况',
                                url: '/experiment/show/' + data.apply.id,
                                end: function () {
                                }
                            });
                        });
                    }
                })

                function showApprove(data) {
                    console.log('show approve ', data)
                    admin.open({
                        type: 1,
                        area: '600px',
                        title: '被试审核',
                        content: $('#studentApprove').html(),
                        success: function (layero, dIndex) {
                            $(layero).children('.layui-layer-content').css('overflow', 'visible');
                            let url = '${ctx}/experiment/studentApprove/approve/' + data.applyId + '/' + data.signupUserId
                            form.on('submit(modelSubmitApprove)', data => {
                                // layer.load(2);
                                url = url + '/' + data.field.approve
                                $.get(url, res => {
                                    if (res.code === 200) {
                                        layer.msg(res.msg, {icon: 1});
                                    } else {
                                        layer.msg(res.msg, {icon: 2});
                                    }
                                    updateTable()
                                })
                            })
                        }
                    })
                    form.render('radio');
                }
            })
        </script>
        <!-- js部分 -->

    </body>
</html>
