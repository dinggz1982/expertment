<%--
  Created by IntelliJ IDEA.
  User: 东梅
  Date: 2022/2/28
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>实验室项目</title>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>Inner Page - Bethany Bootstrap Template</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="${ctx}/static/assets/images/logo.jpg" rel="icon">
    <link href="../../../resources/static/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <%--    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">--%>

    <!-- Vendor CSS Files -->
    <!-- Vendor CSS Files -->
    <link href="assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <link href="assets/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="assets/css/demo.css">
    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">


    <style>
        #innovation{
            margin: auto;
        }
        .border-panel{
            border: 1px solid #009970;
        }
        .list-group-item{
            cursor: pointer;
        }
        /*ul, li{*/
        /*    list-style: none;*/
        /*}*/
        .lock{
            position: absolute;
            top: 15px;
            right: 15px;
            width: 20px;
            height: 20px;
            background: url("assets/images/lock.png");
            background-size: 100% 100%;
        }
        .locknone{
            display: none;
        }
        #wrapper{
            width: 900px;
            margin: 20px auto;
        }
        .data-container{
            margin-top: 5px;
        }
        .data-container ul{
            padding: 0;
            margin: 0;
        }
        .data-container li{
            margin-bottom: 5px;
            padding: 5px 10px;
            background: #66677c;
            color: #fff;
        }
    </style>
</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="fixed-top d-flex align-items-center">
    <div class="container">
        <div class="header-container d-flex align-items-center justify-content-between">
            <div class="logo">
                <h1 class="text-light"><a href="index.html"><span>全部实验项目</span></a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
            </div>
            <nav id="navbar" class="navbar">
                <ul>
                    <li><a class="nav-link scrollto " href="index">中心首页</a></li>
                    <li><a class="nav-link scrollto" href="index">实验室介绍</a></li>
                    <li><a class="nav-link scrollto" href="index">实验资源</a></li>
                    <li><a class="nav-link scrollto" href="index">实验室</a></li>
                    <li><a class="nav-link scrollto" href="index">教师简介</a></li>
                    <li><a class="nav-link scrollto" href="/index_innovation">创新实践</a></li>
                    <li><a class="nav-link scrollto" href="/index_teaching">实验教学</a></li>
                    <li><a class="nav-link scrollto" href="http://jyxy.gzhu.edu.cn/kxyj/sysjs/sysaq.htm">规章制度</a></li>
                    <li><a class="nav-link scrollto" href="http://112.74.39.225:9090/volunteer/register/index">自闭症系统</a></li>
                    <li><a class="getstarted scrollto" href="http://www.gzhu.edu.cn/">广大官网</a></li>
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>
            </nav><!-- .navbar -->

        </div><!-- End Header Container -->
    </div>
</header><!-- End Header -->

<main id="main">

    <!-- ======= Breadcrumbs ======= -->
    <section class="breadcrumbs">
        <div class="container">

            <div class="d-flex justify-content-between align-items-center">
                <h2 style="visibility: hidden">实验项目</h2>
                <ol>
                    <li><a href="/index" style="color:#009970">中心首页</a></li>
                    <li style="color: black">实验项目</li>
                </ol>
            </div>

        </div>
    </section><!-- End Breadcrumbs -->
    <div class="container">
        <div class="row">
            <div class="col-xs-8 col-xs-offset-2">
                <h3 style="color: #009970">全部实验项目</h3>
                <div class="panel panel-primary border-panel">
                    <div class="panel-heading panel-color">
                        <h3 class="panel-title">实验项目</h3>
                    </div>
                    <ul class="list-group">
                    </ul>
                    <div class="col-md-12 column text-center">
                        <ul id="footer-limit"></ul>
                    </div>

<%--                <div id="wrapper">--%>
<%--                    <section>--%>
<%--                        <div class="data-container"></div>--%>
<%--                        <div id="pagination-demo1"></div>--%>
<%--                    </section>--%>
<%--                </div>--%>
                </div>
            </div>
        </div>
    </div>


</main><!-- End #main -->

<footer id="footer">

    <div class="footer-top">
        <div class="container">
            <div class="row">

                <div class="col-lg-3 col-md-6 footer-contact">
                    <h6 style="visibility: hidden">&ensp&ensp&ensp&ensp</h6>
                    <p>
                        广州大学教育学院<br>
                        广东省广州市番禺区广州大学城外环西路230号<br>
                        <strong>邮政编码</strong>510006<br>
                    </p>
                </div>

                <div class="col-lg-2 col-md-6 footer-links">
                    <h4>友情链接</h4>
                    <ul>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://www.gzhu.edu.cn/" target="_blank">广州大学官网</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://jyxy.gzhu.edu.cn/" target="_blank">广州大学教育学院官网</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer><!-- End Footer -->
<!-- Vendor JS Files -->
<script src="assets/vendor/aos/aos.js"></script>
<script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="assets/vendor/php-email-form/validate.js"></script>
<script src="assets/vendor/purecounter/purecounter.js"></script>
<script src="assets/vendor/swiper/swiper-bundle.min.js"></script>

<script src="assets/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script type="text/javascript" src="assets/js/paginathing.js"></script>
<script src="assets/js/bootstrap-paginator.js"></script>
<script src="assets//js/bootstrap.min.js"></script>
<script type="text/javascript" src="assets/js/bootstrap.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>

</body>
<%--<script src="assets/js/jquery-1.10.2.min.js" type="text/javascript"></script>--%>
<%--<script src="assets/js/pagination.js"></script>--%>
<script type="text/javascript">
    // jQuery(document).ready(function($){
    //     var allData=[]
    //     function setdata(data) {
    //         for (var i=0;i<data.length; i++) {
    //             $('.list-group').append("<li class='list-group-item' onclick=linkTo('signUp')>"+data[i].name+'</li>');
    //         }
    //     }
    //
    //         function  addData(data){
    //             for(var k=0;k<data.data.records.length;k++){
    //                 allData.push(data.data.records[k])
    //             }
    //         }
    //         function fenye(data){
    //             $('.list-group').paginathing({
    //                 perPage:10,
    //                 limitPagination: data.data.pages,
    //                 containerClass: 'panel-footer',
    //                 currentPage:1,
    //                 pageNumbers: true
    //             })
    //         }
    //         $.ajax({
    //             url: "/api/front/experiment/getNewExperimentApply",
    //             type: "get",
    //             data:{
    //                 page:1
    //             },
    //             dataType: "json",
    //             async: false,
    //             contentType: 'application/json',
    //             success: function (data) {
    //                getAll(data)
    //             }, fail: function () {
    //                 console.log("fail")
    //             }
    //         })
    //     function  getAll(data) {
    //         for (var i=1;i<data.data.pages+1;i++){
    //             $.ajax({
    //                 url: "/api/front/experiment/getNewExperimentApply",
    //                 type: "get",
    //                 data:{
    //                     page:i
    //                 },
    //                 dataType: "json",
    //                 async: false,
    //                 contentType: 'application/json',
    //                 success: function (data) {
    //                     //console.log(data)
    //                     addData(data)
    //                 }, fail: function () {
    //                     console.log("fail")
    //                 }
    //             })
    //         }
    //         setdata(allData)
    //         fenye(data)
    //     }
    //  });

    var limit = 30;
    function initTable() {
        $.ajax({
            url: '/api/front/experiment/getNewExperimentApply',
            type: 'get',
            data: { page: 1, limit: limit },
            dataType: 'json',
            success: function (data) {
                var htmlall=""
                for (var i=0;i<data.data.records.length; i++) {
                    var lockSign=""
                    if(data.data.records[i].isLock==0) {
                        lockSign = "locknone"
                    }
                    else{
                        lockSign="lock"
                    }
                    var html="<li class='list-group-item' onclick=linkTo('signUp')>"+"<div class='"+lockSign+"'></div>"+data.data.records[i].name+'</li>'
                    htmlall=htmlall+html
                }
                $(".list-group").html(htmlall);
                var pageCount =data.data.pages//总页数
                var options = {
                    bootstrapMajorVersion: 3, //版本
                    currentPage: 1, //当前页数
                    totalPages: pageCount, //总页数
                    numberOfPages: 5,
                    itemTexts: function (type, page, current) {
                        switch (type) {
                            case "first":
                                return "首页";
                            case "prev":
                                return "上一页";
                            case "next":
                                return "下一页";
                            case "last":
                                return "末页";
                            case "page":
                                return page;
                        }
                    },//点击事件，用于通过Ajax来刷新整个list列表
                    onPageClicked: function (event, originalEvent, type, page) {
                        $.ajax({
                            url: '/api/front/experiment/getNewExperimentApply',
                            type: 'get',
                            data: { page: page, limit: limit },
                            dataType: 'json',
                            success: function (data) {
                                var htmlall=""
                                for (var i=0;i<data.data.records.length; i++) {
                                    var lockSign=""
                                    if(data.data.records[i].isLock==0) {
                                        lockSign = "locknone"
                                    }
                                    else{
                                        lockSign="lock"
                                    }
                                    var html="<li class='list-group-item' onclick=linkTo('signUp')>"+"<div class='"+lockSign+"'></div>"+data.data.records[i].name+'</li>'
                                    htmlall=htmlall+html
                                }
                                $(".list-group").html(htmlall);
                            }
                        });
                    }
                };
                $('#footer-limit').bootstrapPaginator(options);
            }
        });

    }

    $(function () {
        initTable();
    });


    /**
     * 跳转打开指定接口
     * @param symbol
     */
    function  linkTo(symbol){
        localStorage.setItem('symbol',symbol)
        window.location.href ='/system/index'
    }

</script>
</html>
