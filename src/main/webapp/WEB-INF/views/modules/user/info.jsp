<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>个人信息</title>
        <%@include file="../../include/include.jsp" %>
        <style>
            .user-info-head {
                width: 110px;
                height: 110px;
                position: relative;
                display: inline-block;
                border-radius: 50%;
                border: 2px solid #eee;
            }

            .user-info-head:hover:after {
                content: '\e624';
                position: absolute;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                color: #eee;
                background: rgba(0, 0, 0, 0.5);
                font-family: layui-icon;
                font-size: 28px;
                font-style: normal;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
                cursor: pointer;
                line-height: 110px;
                border-radius: 50%;
            }

            .user-info-head img {
                width: 110px;
                height: 110px;
                border-radius: 50%;
            }

            .info-list-item {
                position: relative;
                padding-bottom: 8px;
            }

            .info-list-item > .layui-icon {
                position: absolute;
            }

            .info-list-item > p {
                padding-left: 30px;
            }

            .dash {
                border-bottom: 1px dashed #ccc;
                margin: 15px 0;
            }

            .bd-list-item {
                padding: 14px 0;
                border-bottom: 1px solid #e8e8e8;
                position: relative;
            }

            .bd-list-item .bd-list-item-img {
                width: 48px;
                height: 48px;
                line-height: 48px;
                margin-right: 12px;
                display: inline-block;
                vertical-align: middle;
            }

            .bd-list-item .bd-list-item-content {
                display: inline-block;
                vertical-align: middle;
            }

            .bd-list-item .bd-list-item-lable {
                margin-bottom: 4px;
                color: #333;
            }

            .bd-list-item .bd-list-item-oper {
                position: absolute;
                right: 0;
                top: 50%;
                text-decoration: none !important;
                cursor: pointer;
                transform: translateY(-50%);
            }

            .user-info-form .layui-form-item {
                margin-bottom: 25px;
            }
        </style>
    </head>
    <body>
        <!-- 加载动画 -->
        <div class="page-loading">
            <div class="ball-loader">
                <span></span><span></span><span></span><span></span>
            </div>
        </div>

        <!-- 正文开始 -->
        <div class="layui-fluid">
            <div class="layui-row layui-col-space15">
                <!-- 左 -->
                <div class="layui-col-sm12 layui-col-md3">
                    <div class="layui-card">
                        <div class="layui-card-body" style="padding: 25px;">
                            <div class="text-center layui-text">
                                <div class="user-info-head" id="imgHead">
                                    <img src="${currentUser.avatar}"/>
                                </div>
                                <h2 style="padding-top: 20px;">${currentUser.realName}</h2>
                            </div>
                            <div class="layui-text" style="padding-top: 30px;">
                                <div class="info-list-item">
                                    <i class="layui-icon layui-icon-username"></i>
                                    <p>
                                        角色：
                                        <c:forEach items="${currentUser.roles}" var="role">
                                            ${role.name} &nbsp;&nbsp;
                                        </c:forEach>
                                    </p>
                                </div>
                            </div>
                            <div class="dash"></div>
                        </div>
                    </div>
                </div>
                <!-- 右 -->
                <div class="layui-col-sm12 layui-col-md9">
                    <div class="layui-card">
                        <div class="layui-card-body">

                            <div class="layui-tab layui-tab-brief" lay-filter="userInfoTab">
                                <ul class="layui-tab-title">
                                    <li class="layui-this">基本信息</li>
                                </ul>
                                <div class="layui-tab-content">
                                    <div class="layui-tab-item layui-show">
                                        <div class="layui-form user-info-form layui-text"
                                             style="max-width: 400px;padding-top: 25px;">
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">学号/工号:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="username" readonly class="layui-input"
                                                           value="${currentUser.username}"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">真实姓名:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="realName" class="layui-input"
                                                           value="${currentUser.realName}"/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">联系电话:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="tel" value="${currentUser.tel}"
                                                           class="layui-input" lay-verify="required" required/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <label class="layui-form-label">邮箱:</label>
                                                <div class="layui-input-block">
                                                    <input type="text" name="email" value="${currentUser.email}"
                                                           class="layui-input" lay-verify="required" required/>
                                                </div>
                                            </div>
                                            <div class="layui-form-item">
                                                <div class="layui-input-block">
                                                    <button class="layui-btn" lay-filter="userInfoSubmit" lay-submit>
                                                        更新基本信息
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                layui.use(['layer', 'form', 'element', 'admin'], function () {
                    var $ = layui.jquery;
                    var layer = layui.layer;
                    var form = layui.form;
                    var element = layui.element;
                    var admin = layui.admin;

                    // 选择头像
                    $('#imgHead').click(function () {
                        admin.cropImg({
                            imgSrc: $('#imgHead>img').attr('src'),
                            onCrop: function (res) {
                                console.log(res);
                                var url = "/userInfo/updateAvatar";
                                $.post(url, {"avatar": res}, function (result) {
                                    layer.load(2);
                                    if (result.code == 200) {
                                        layer.closeAll('loading');
                                        layer.msg(result.msg, {icon: 1});
                                        $('#imgHead>img').attr('src', res);
                                    } else {
                                        layer.msg(result.msg, {icon: 2});
                                    }
                                }, 'json');
                            }
                        });
                    });
                });
            </script>
    </body>
</html>
