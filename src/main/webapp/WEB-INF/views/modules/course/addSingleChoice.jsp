<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
    <title>新增单选题</title>
    <%@include file="/WEB-INF/views/include/include.jsp" %>
    <style>
        [lay-filter="eQuestionForm"] .layui-form-item, .layui-inline {
            margin-bottom: 0;
            margin-top: 20px;
        }

        .qa-xx-item {
            padding-left: 25px;
            margin-bottom: 20px;
        }

        .qa-xx-item-title {
            position: absolute;
            left: 0;
            line-height: 38px;
        }

    </style>
</head>
<body>

<!-- 正文开始 -->
<div class="layui-fluid">
    <div class="layui-card">
       <div style="text-align: center"><h1>第二步：修改或新增单选题试题</h1></div>
        <div style="text-align: center;margin-top: 10px;margin-bottom: 10px;"><h2>题干：${baseQuestionInfo.title}</h2></div>

        <div class="layui-card-body">
            <form class="layui-form" lay-filter="eQuestionForm" style="max-width: 960px;">
                <input type="hidden" name="id" value="${question.id}"/>
                <input type="hidden" name="baseQuestionId" value="${baseQuestionInfo.id}"/>
                <div class="layui-form-item">
                    <label class="layui-form-label">试题内容：</label>
                    <div class="layui-input-block">
                        <textarea name="description" id="eQuestionContentEdt"
                                  style="display: block !important;visibility: hidden;height: 1px;border: none;">${question.description}</textarea>
                    </div>
                </div>

                <div class="layui-form-item layui-form-text">
                    <label class="layui-form-label">试题选项：</label>
                    <div class="layui-input-block">
                        <div class="qa-xx-item">
                            <span class="qa-xx-item-title">A：</span>
                            <input type="text" name="itemA" placeholder="请输入选项内容" value="${question.itemA}" class="layui-input"
                                   autocomplete="off" lay-verType="tips" lay-verify="required" required/>
                        </div>
                        <div class="qa-xx-item">
                            <span class="qa-xx-item-title">B：</span>
                            <input type="text" name="itemB" placeholder="请输入选项内容" value="${question.itemB}" class="layui-input"
                                   autocomplete="off" lay-verType="tips" lay-verify="required" required/>
                        </div>
                        <div class="qa-xx-item">
                            <span class="qa-xx-item-title">C：</span>
                            <input type="text" name="itemC" placeholder="请输入选项内容" value="${question.itemC}" class="layui-input"
                                   autocomplete="off" lay-verType="tips" lay-verify="required" required/>
                        </div>
                        <div class="qa-xx-item">
                            <span class="qa-xx-item-title">D：</span>
                            <input type="text" name="itemD" placeholder="请输入选项内容" value="${question.itemD}" class="layui-input" autocomplete="off"/>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <label class="layui-form-label">正确选项：</label>
                    <div class="layui-input-block">
                        <c:choose>
                            <c:when test="${question.rightAnswer eq 'A'}">
                                <input type="radio" name="rightAnswer" value="A" title="A" checked>
                            </c:when>
                            <c:otherwise>
                                <input type="radio" name="rightAnswer" value="A" title="A">
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${question.rightAnswer eq 'B'}">
                                <input type="radio" name="rightAnswer" value="B" title="B" checked>
                            </c:when>
                            <c:otherwise>
                                <input type="radio" name="rightAnswer" value="B" title="B">
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${question.rightAnswer eq 'C'}">
                                <input type="radio" name="rightAnswer" value="C" title="C" checked>
                            </c:when>
                            <c:otherwise>
                                <input type="radio" name="rightAnswer" value="C" title="C">
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${question.rightAnswer eq 'D'}">
                                <input type="radio" name="rightAnswer" value="D" title="D" checked>
                            </c:when>
                            <c:otherwise>
                                <input type="radio" name="rightAnswer" value="D" title="D">
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

                <div class="layui-form-item">
                    <div class="layui-input-block text-center">
                        <button ew-event="closeThisTabs" type="button" class="layui-btn layui-btn-primary">&emsp;关闭&emsp;</button>
                        <button class="layui-btn" lay-filter="eQuestionSubmit" lay-submit>&emsp;提交&emsp;</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- js部分 -->
<script>
    layui.use(['layer', 'form', 'xmSelect', 'layedit'], function () {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var xmSelect = layui.xmSelect;
        var layedit = layui.layedit;
        layedit.set({
            uploadImage: {
                url: '/course/question/imageUpload' //接口url
                ,type: '' //默认post
            }
        });
        var editIndex = layedit.build('eQuestionContentEdt'
            ,{
                tool: [
                    'strong' //加粗
                    ,'italic' //斜体
                    ,'underline' //下划线
                    ,'del' //删除线

                    ,'|' //分割线

                    ,'left' //左对齐
                    ,'center' //居中对齐
                    ,'right' //右对齐
                    ,'link' //超链接
                    ,'unlink' //清除链接
                    ,'face' //表情
                    ,'image' //插入图片
                    ,'help' //帮助
                ]
            }
        ); // 建立编辑器

        // 表单提交事件
        form.on('submit(eQuestionSubmit)', function (data) {
           // alert(layedit.getContent(editIndex));
            data.field.description = layedit.getContent(editIndex);

            console.log(data.field);
            var url = "/course/singleChoice/saveOrUpdate";
            var loadIndex = layer.load(2);
            $.post(url, data.field, function (res) {
               // layer.close(loadIndex);
                if (200 === res.code) {
                    layer.msg(res.msg, {icon: 1});
                    renderTree(${textbook.id});
                } else {
                    layer.msg(res.msg, {icon: 2});
                }
            }, 'json');
        });
    });
</script>
</body>
</html>
