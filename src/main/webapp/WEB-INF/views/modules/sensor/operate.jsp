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
        <div class="layui-card-body">
            <!-- 表单开始 -->
            <form class="layui-form" id="formBasForm" lay-filter="formBasForm">
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">选择传感器:</label>
                    <div class="layui-input-block">
                        <select name="id">
                            <c:forEach items="${sensors}" var="sensor">
                                <option value="${sensor.id}">${sensor.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">操作类型:</label>
                    <div class="layui-input-block">
                        <input type="radio" name="status" value="1" title="开启" checked>
                        <input type="radio" name="status" value="0" title="关闭">
                    </div>
                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label layui-form-required">持续时间:</label>
                    <div class="layui-input-block">
                        <input name="time" placeholder="持续时间" class="layui-input"
                               lay-verType="tips" lay-verify="required" required/>
                    </div>
                </div>
                <div class="layui-form-item text-right">
                    <button class="layui-btn layui-btn-primary" type="button" ew-event="closePageDialog">取消</button>
                    <button class="layui-btn" lay-filter="modelSubmitSensor" lay-submit>保存</button>
                </div>
            </form>
        </div>
    </div>
</div>


</body>
<script>
    layui.use(['layer', 'form'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var url = "/sensor/sensor/operate";
        // 表单提交事件
        form.on('submit(modelSubmitSensor)', function (data) {
            layer.load(2);
            $.get(url, data.field, function (res) {
               // alert(data);
                layer.closeAll('loading');
                if (res.code == 200) {
                    // layer.close(dIndex);
                    layer.msg(res.msg, {icon: 1});
                    //  insTb.reload({}, 'data');
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            }, 'json');
            return false;
        });
    });
</script>
</html>
