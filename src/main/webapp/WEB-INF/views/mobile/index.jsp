<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>土壤检测</title>
    <%@include file="../include/include.jsp" %>
    <script type="text/javascript" src="/layui/icon/iconfont.js"></script>
    <link rel="stylesheet" href="/layui/icon/iconfont.css">
    <style>
        /** 统计快捷方式样式 */
        .console-link-block {
            font-size: 16px;
            padding: 20px 20px;
            border-radius: 4px;
            background-color: #40D4B0;
            color: #FFFFFF !important;
            box-shadow: 0 2px 3px rgba(0, 0, 0, .05);
            position: relative;
            overflow: hidden;
            display: block;
        }

        .console-link-block .console-link-block-num {
            font-size: 40px;
            margin-bottom: 5px;
            opacity: .9;
        }

        .console-link-block .console-link-block-text {
            opacity: .8;
        }

        .console-link-block .console-link-block-icon {
            position: absolute;
            top: 50%;
            right: 20px;
            width: 50px;
            height: 50px;
            font-size: 50px;
            line-height: 50px;
            margin-top: -25px;
            color: #FFFFFF;
            opacity: .8;
        }

        .console-link-block .console-link-block-band {
            color: #fff;
            width: 100px;
            font-size: 12px;
            padding: 2px 0 3px 0;
            background-color: #E32A16;
            line-height: inherit;
            text-align: center;
            position: absolute;
            top: 8px;
            right: -30px;
            transform-origin: center;
            transform: rotate(45deg) scale(.8);
            opacity: .95;
            z-index: 2;
        }

        /** 应用快捷块样式 */
        .console-app-group {
            padding: 16px;
            border-radius: 4px;
            text-align: center;
            background-color: #fff;
            cursor: pointer;
            display: block;
        }

        .console-app-group .console-app-icon {
            width: 32px;
            height: 32px;
            line-height: 32px;
            margin-bottom: 6px;
            display: inline-block;
            -webkit-box-sizing: border-box;
            -moz-box-sizing: border-box;
            box-sizing: border-box;
            font-size: 32px;
            color: #69c0ff;
        }

        .console-app-group:hover {
            box-shadow: 0 0 15px rgba(0, 0, 0, .08);
        }

        /** //应用快捷块样式 */

        /** 小组成员 */
        .console-user-group {
            position: relative;
            padding: 10px 0 10px 60px;
        }

        .console-user-group .console-user-group-head {
            width: 32px;
            height: 32px;
            position: absolute;
            top: 50%;
            left: 12px;
            margin-top: -16px;
            border-radius: 50%;
        }

        .console-user-group .layui-badge {
            position: absolute;
            top: 50%;
            right: 8px;
            margin-top: -10px;
        }

        .console-user-group .console-user-group-name {
            line-height: 1.2;
        }

        .console-user-group .console-user-group-desc {
            color: #8c8c8c;
            line-height: 1;
            font-size: 12px;
            margin-top: 5px;
        }

        /** 卡片轮播图样式 */
        .admin-carousel .layui-carousel-ind {
            position: absolute;
            top: -41px;
            text-align: right;
        }

        .admin-carousel .layui-carousel-ind ul {
            background: 0 0;
        }

        .admin-carousel .layui-carousel-ind li {
            background-color: #e2e2e2;
        }

        .admin-carousel .layui-carousel-ind li.layui-this {
            background-color: #999;
        }

        /** 广告位轮播图 */
        .admin-news .layui-carousel-ind {
            height: 45px;
        }

        .admin-news a {
            display: block;
            line-height: 70px;
            text-align: center;
        }

        /** 最新动态时间线 */
        .layui-timeline-dynamic .layui-timeline-item {
            padding-bottom: 0;
        }

        .layui-timeline-dynamic .layui-timeline-item:before {
            top: 16px;
        }

        .layui-timeline-dynamic .layui-timeline-axis {
            width: 9px;
            height: 9px;
            left: 1px;
            top: 7px;
            background-color: #cbd0db;
        }

        .layui-timeline-dynamic .layui-timeline-axis.active {
            background-color: #0c64eb;
            box-shadow: 0 0 0 2px rgba(12, 100, 235, .3);
        }

        .dynamic-card-body {
            box-sizing: border-box;
            overflow: hidden;
        }

        .dynamic-card-body:hover {
            overflow-y: auto;
            padding-right: 9px;
        }

        /** 优先级徽章 */
        .layui-badge-priority {
            border-radius: 50%;
            width: 20px;
            height: 20px;
            padding: 0;
            line-height: 18px;
            border-width: 2px;
            font-weight: 600;
        }

    </style>
</head>
<body>

<div class="layui-container layui-row layui-fluid">
    <div class="layui-row" style="margin-top: 5px;">
        <div class="layui-col-md12 site-content">
            <blockquote class="layui-elem-quote">
                <h1 style="text-align: center">当前菜园状态</h1>
            </blockquote>
        </div>
    </div>
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#9BC539;">
                <div class="console-link-block-num">15</div>
                <div class="console-link-block-text"><h2>温度</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-wendu"></span>
            </div>
        </div>
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#FEAA4F;">
                <div class="console-link-block-num">13</div>
                <div class="console-link-block-text"><h2>湿度</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-shidu"></span>
            </div>
        </div>
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#F591A2;">
                <div class="console-link-block-num">13</div>
                <div class="console-link-block-text"><h2>酸碱度</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-pHzhi"></span>
            </div>
        </div>
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#9DAFFF;">
                <div class="console-link-block-num">13</div>
                <div class="console-link-block-text"><h2>氮含量</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-turangdanhanliang"></span>
            </div>
        </div>
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#FEAA4F;">
                <div class="console-link-block-num">11</div>
                <div class="console-link-block-text"><h2>磷含量</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-turanglinhanliang"></span>
            </div>
        </div>
        <div class="layui-col-md2 layui-col-sm4 layui-col-xs6">
            <div class="console-link-block" style="background-color:#55A5EA;">
                <div class="console-link-block-num">26</div>
                <div class="console-link-block-text"><h2>钾含量</h2></div>
                <span class="console-link-block-icon layui-icon iconfont icon-turangjiahanliang"></span>
            </div>
        </div>
    </div>
    <div class="layui-row" style="margin-top: 5px;">
        <div class="layui-col-md12 site-content">
            <blockquote class="layui-elem-quote">
                <h1 style="text-align: center">详细数据</h1>
            </blockquote>
        </div>
    </div>
    <div class="layui-row layui-col-space15">
        <div class="layui-col-sm6" style="padding-bottom: 0;">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-xs6 layui-col-sm3">
                    <div class="console-app-group" ew-href="/mobile/list" ew-title="传感器管理">
                        <i class="console-app-icon layui-icon layui-icon-slider"
                           style="font-size: 26px;padding-top: 3px;margin-right: 6px;"></i>
                        <div class="console-app-name">传感器列表</div>
                    </div>
                </div>
                <div class="layui-col-xs6 layui-col-sm3">
                    <div class="console-app-group" ew-href="/mobile/sensorData" ew-title="传感器数据">
                        <i class="console-app-icon layui-icon layui-icon-chart" style="color: #95de64;"></i>
                        <div class="console-app-name">详细数据</div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>

</html>
