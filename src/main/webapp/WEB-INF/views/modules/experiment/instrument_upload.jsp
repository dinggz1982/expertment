<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实验仪器批量上传</title>
    <%@include file="/WEB-INF/views/include/include.jsp" %>
</head>
<body>
<div style="margin-top: 20px;text-align: center">
    <div>
<button type="button" class="layui-btn" id="test1">
    <i class="layui-icon">&#xe67c;</i>上传图片
</button></div>
    <div style="margin-top: 10px"><a href="/experiment/instrument/getFile">导入模板</a></div>
</div>
<script>
    layui.use('upload', function(){
        var upload = layui.upload;

        //执行实例
        var uploadInst = upload.render({
            elem: '#test1' //绑定元素
            ,url: '/upload/' //上传接口
            ,done: function(res){
                //上传完毕回调
            }
            ,error: function(){
                //请求异常回调
            }
        });
    });
</script>
</body>
</html>
