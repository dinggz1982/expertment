<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>试卷</title>
    <%@include file="/WEB-INF/views/include/include.jsp" %>
</head>
<body>
<div class="layui-row layui-col-space15">
    <div class="layui-col-md12">
        <c:forEach items="${testPaper.singleChoices}" var="sigle">
            <div class="layui-card">
                <div class="layui-card-header">${sigle.description}</div>
                <div class="layui-card-body">
                        ${sigle.itemA}<input type="radio" name="rightAnswer" value="A" title="${sigle.itemA}">
                                ${sigle.itemB} <input type="radio" name="rightAnswer" value="B" title="${sigle.itemB}">
                                ${sigle.itemC}<input type="radio" name="rightAnswer" value="C" title="${sigle.itemC}">
                                ${sigle.itemD}<input type="radio" name="rightAnswer" value="D" title="${sigle.itemD}">
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
