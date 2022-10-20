<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>实验详细情况</title>
        <%@include file="/WEB-INF/views/include/include.jsp" %>
    </head>
    <body>
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 20px;">
            <legend>实验名称：${apply.name}（申请人：${apply.applyUser.realName}）</legend>
        </fieldset>
        <blockquote class="layui-elem-quote">
            ${apply.description}
        </blockquote>
        <!-- 页面加载loading -->
        <div class="page-loading">
            <div class="ball-loader">
                <span></span><span></span><span></span><span></span>
            </div>
        </div>
        <!-- 正文开始 -->
        <div class="layui-fluid">
            <div class="layui-card">
                <table class="layui-table">
                    <thead>
                        <tr>
                            <th>名称</th>
                            <th>申请人</th>
                            <th>起止时间</th>
                            <th>实验室</th>
                            <th>实验类型</th>
                            <th>实验人数</th>
                            <th>已报名人数</th>
                            <th>已实验人数</th>
                            <th>当前审批状态</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>${apply.name}</td>
                            <td>${apply.applyUser.realName}</td>
                            <td><fmt:formatDate value="${apply.startDate}"
                                                pattern="yyyy-MM-dd HH:mm:ss"/>到<fmt:formatDate value="${apply.endDate}"
                                                                                                pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td>${apply.lab.name}</td>
                            <td>${apply.type.name}</td>
                            <td>${apply.number}</td>
                            <td>${apply.applyNumber}</td>
                            <td>${apply.finishNumber}</td>
                            <th>${apply.status}</th>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </body>
</html>
