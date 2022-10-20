<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>广州大学教育学院实验中心</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="/assets/images/logo.jpg" rel="icon">
    <link href="/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <%--    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"--%>
    <%--          rel="stylesheet">--%>

    <!-- Vendor CSS Files -->
    <link href="/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <style type="text/css">
        /**,
       *::before,
       *::after {
           box-sizing: inherit;
         }*/
        #t1 {
            font-size: 27px;
        }

        .box {
            width: 400px;
            display: block;
            height: 50px;
            padding-bottom: 20px;
            position: relative;
            border-radius: 5px;
            background: linear-gradient(to right, #abbd73 35%, #d6e2ad 100%);
            margin-bottom: 15px;
            color: darkslategray;
            box-shadow: 1px 2px 1px -1px #777;
            transition: background 200ms ease-in-out;
            text-align: left;
            transition: height 0.5s;
            overflow-y: hidden;
            overflow-x: hidden;
        }

        .shadow {
            position: relative;
        }

        .shadow:before {
            z-index: -1;
            position: absolute;
            content: "";
            bottom: 13px;
            right: 7px;
            width: 75%;
            top: 0;
            box-shadow: 0 15px 10px #777;
            -webkit-transform: rotate(4deg);
            transform: rotate(4deg);
            transition: all 150ms ease-in-out;
        }

        .box:hover {
            background: linear-gradient(to right, #abbd73 0%, #abbd73 100%);
        }

        .shadow:hover::before {
            -webkit-transform: rotate(0deg);
            transform: rotate(0deg);
            bottom: 20px;
            z-index: -10;
        }

        .circle {
            position: absolute;
            top: 15px;
            left: 15px;
            width: 20px;
            height: 20px;
            background: url("assets/images/next.png");
            background-size: 100% 100%;
            /*display: inline-block;*/
            /*text-align: right;*/
        }
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
        #cardBox1 {
            width: 420px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            text-align: center;
            float: left;
            margin-right: 10px;
            padding: 5px;
            padding-top: 15px;
        }

        #cardBox2 {
            width: 420px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
            text-align: center;
            float: left;
            margin-right: 10px;
            padding: 5px;
            padding-top: 15px;
        }

        .headerBox {
            color: #fff;
            padding: 10px;
            font-size: 20px;
            height: 60px;
            position: relative;
        }

        .headerBox span {
            display: block;
            width: auto;
            height: 20px;
            position: absolute;
            right: 10px;
            top: 20px;
        }

        .headerBox span a {
            color: white;
            font-size: 15px;
        }

        .bodyBox {
            padding: 10px;
        }

        .box span {
            display: block;
            position: absolute;
            top: 15px;
            left: 35px;
            width: 365px;
            height: 20px;
            padding-left: 5px;
            text-align: left;
            font-size: 16px;
            line-height: 20px;
            overflow-x: hidden;
            overflow-y: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
            cursor: pointer;
        }

        .bodyBox p {
            margin-left: 5px;
        }

        .teacher {
            width: 200px;
            height: 270px;
        }

        .teacher-box {
            width: 200px;
            margin-left: 20px;
            float: left;
        }

        .dynamic-info {
            position: absolute;
            top: 50px;
            left: 10px;
            width: 380px;
            height: auto;
            padding-left: 10px;
            padding-bottom: 20px;
            white-space: normal;
            word-wrap: break-word;
            font-size: 13px;
        }

        #hero p {
            font-size: 30px;
            font-weight: 600;
            color: white;
        }

        .icon-box a {
            color: white;
        }

        .navbar a {
            font-size: 15px;
            font-weight: 600;
        }

        #resource .icon-box {
            background: none;
        }

        #resource .icon-box a {
            color: white;
            cursor: pointer;
        }

        #footer p {
            color: white;
        }

        .experimentImg {
            width: 379px;
            height: 330px;
        }

        .experimentBox {
            width: 379px;
            height: auto;
            margin-right: 50px;
        }

        .fit-img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
    </style>
</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="fixed-top d-flex align-items-center">
    <div class="container">
        <div class="header-container d-flex align-items-center justify-content-between">
            <div class="logo">
                <h1 class="text-light"><a href="/index"><span id="t1">广州大学教育学院实验中心</span></a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
            </div>

            <nav id="navbar" class="navbar">
                <ul>
                    <li><a class="nav-link scrollto active" href="#hero">中心首页</a></li>
                    <li><a class="nav-link scrollto" href="#about">实验室介绍</a></li>
                    <li><a class="nav-link scrollto" href="#resource">实验资源</a></li>
                    <li><a class="nav-link scrollto" href="#lab">实验室</a></li>
                    <li><a class="nav-link scrollto" href="#teacher">教师简介</a></li>
                    <li><a class="nav-link scrollto" href="/index_innovation">创新实践</a></li>
                    <li><a class="nav-link scrollto" href="/index_teaching">实验教学</a></li>
                    <li><a class="nav-link scrollto" href="http://jyxy.gzhu.edu.cn/kxyj/sysjs/sysaq.htm">规章制度</a></li>
                    <li><a class="nav-link scrollto" href="http://112.74.39.225:9090/volunteer/register/index">自闭症系统</a>
                    </li>
                    <li><a class="getstarted scrollto" href="http://jyxy.gzhu.edu.cn/">学院官网</a></li>
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>
            </nav><!-- .navbar -->

        </div><!-- End Header Container -->
    </div>
</header><!-- End Header -->

<!-- ======= Hero Section ======= -->
<section id="hero" class="d-flex align-items-center">
    <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">
        <p>“未成年人心理健康与教育神经”省哲学社会科学重点实验室</br></br>“教育与学习技术”省级实验教学示范中心</p>
        <a href="/login" class="btn-get-started scrollto">登录</a>
        <a href="/system/registry/toRegistry" class="btn-get-started scrollto">注册</a>
    </div>
</section><!-- End Hero -->

<main id="main">

    <!-- ======= Why Us Section ======= -->
    <section id="about" class="why-us">
        <div class="container">

            <div class="row">
                <div class="col-lg-4 d-flex align-items-stretch" data-aos="fade-right">
                    <div class="content" id="introduct">
                        <h3>实验室简介</h3>
                        <p>
                        </p>
                        <div class="text-center">
                            <a href="/index_experimentIntro_more" class="more-btn">了解更多<i
                                    class="bx bx-chevron-right"></i></a>
                        </div>
                    </div>
                </div>
                <div id="cardBox1">
                    <div class="headerBox" style="background-color: #009970;">
                        <p>
                            <a style="color:white">实验室动态</a>
                        </p>
                        <span><a href="/dynamic_more">更多>></a></span>
                    </div>
                    <div class="bodyBox">
                    </div>
                </div>
                <div id="cardBox2">
                    <div class="headerBox" style="background-color: #009970;">
                        <p>
                            <a style="color:white">新增实验室项目</a>
                        </p>
                        <span><a href="/experiment_more">更多>></a></span>
                    </div>
                    <div class="bodyBox">
                    </div>
                </div>
            </div>
        </div>
        </div>

        </div>
    </section><!-- End Why Us Section -->

    <!-- ======= Cta Section ======= -->
    <section id="resource" class="cta services section-bg">
        <div class="container">

            <%--                <div class="text-center" data-aos="zoom-in">--%>
            <%--                    <h3>马上登录</h3>--%>
            <%--                   <a class="cta-btn" href="#">立即行动</a>--%>
            <%--                </div>--%>
            <div class="row">
                <div class="col-lg-4">
                    <div class="section-title" data-aos="fade-right">
                        <h2 style="color: white">实验室资源</h2>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row">
                        <div class="col-md-6 d-flex align-items-stretch">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="100">
                                <div class="icon"><i class="bx bxl-dribbble"></i></div>
                                <h4><a onclick="linkTo('application1')">实验申请</a></h4>
                                <p style="visibility: hidden">
                                    &ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp</p>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex align-items-stretch mt-4 mt-lg-0">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="200">
                                <div class="icon"><i class="bx bx-file"></i></div>
                                <h4><a onclick="linkTo('signUp')">被试报名</a></h4>
                                <p style="visibility: hidden">
                                    &ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp</p>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex align-items-stretch mt-4">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="300">
                                <div class="icon"><i class="bx bx-tachometer"></i></div>
                                <h4><a onclick="linkTo('borrow')">仪器借用</a></h4>
                                <p style="visibility: hidden">
                                    &ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp</p>
                            </div>
                        </div>
                        <div class="col-md-6 d-flex align-items-stretch mt-4">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="400">
                                <div class="icon"><i class="bx bx-world"></i></div>
                                <h4><a onclick="linkTo('application2')">实验室申请</a></h4>
                                <p style="visibility: hidden">
                                    &ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp&ensp</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </section><!-- End Cta Section -->

    <section id="lab" class="portfolio">
        <div class="container">
            <div class="section-title aos-init aos-animate" data-aos="fade-left">
                <h2>实验室</h2>
            </div>
            <div class="row portfolio-container aos-init aos-animate" data-aos="fade-up" data-aos-delay="200"
                 id="lab-items">
            </div>
        </div>
    </section><!-- End Portfolio Section -->
    <!-- ======= Team Section ======= -->
    <section id="teacher" class="team">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="section-title aos-init" data-aos="fade-right">
                        <h2>教师简介</h2>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row" id="teacherInfo">
                    </div>

                </div>

            </div>
        </div>

        </div>
    </section><!-- End Team Section -->

</main><!-- End #main -->

<!-- ======= Footer ======= -->
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
                        <li><i class="bx bx-chevron-right"></i> <a href="http://www.gzhu.edu.cn/"
                                                                   target="_blank">广州大学官网</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://jyxy.gzhu.edu.cn/" target="_blank">广州大学教育学院官网</a>
                        </li>
                    </ul>
                </div>
<%--                <div class="col-lg-2 col-md-6 footer-links">--%>
<%--                    <h4>其他链接</h4>--%>
<%--                    <ul>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="http://jyxy.gzhu.edu.cn/kxyj/sysjs/sysaq.htm"--%>
<%--                                                                   target="_blank">规章制度</a></li>--%>
<%--                    </ul>--%>
<%--                </div>--%>
            </div>
        </div>
    </div>
</footer><!-- End Footer -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
        class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="/assets/vendor/aos/aos.js"></script>
<script src="/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="/assets/vendor/php-email-form/validate.js"></script>
<script src="/assets/vendor/purecounter/purecounter.js"></script>
<script src="/assets/vendor/swiper/swiper-bundle.min.js"></script>

<!-- Template Main JS File -->
<script src="/assets/js/main.js"></script>

</body>
<script src="/assets/js/jquery-1.11.0.min.js" type="text/javascript"></script>
<script>
    /**
     * 渲染实验室介绍数据
     */
    function setIntroduct(data) {
        var str = data.data.description.substring(0, 300);
        document.getElementById("introduct").querySelector("p").innerHTML = str + '...'
        var info= document.getElementById("introduct").querySelector("p").querySelectorAll("p")
        for(var i=0;i<info.length;i++){
                var info2=info[i].querySelectorAll("span")
            for(var y=0;y<info2.length;y++){
                    info2[y].style.backgroundColor=""
                    info2[y].style.color="white"
            }
        }

    }

    function getIntroduct() {
        $.ajax({
            url: "/experiment/setDescription/get-description",
            type: "get",
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                setIntroduct(data)
            }, fail: function () {
                console.log("fail")
            }
        })
    }

    getIntroduct()

    /**
     * 渲染实验室动态数据
     * @param data
     */
    var allDynamic = []

    function setDynamics(data) {
        //console.log(data)
        var dynamics = document.getElementById("cardBox1").querySelector(".bodyBox")
        var dynamicshtmls = ""
        for (var i = 0; i < data.length &&i < 7; i++) {
            var dynamicshtml = "<div class='box shadow' onclick='showDynamics(" + i + ")'>" + "<span>" + data[i].title + "</span><div class='circle'></div><div class='dynamic-info'>" + data[i].content + "</div></div>"
            dynamicshtmls = dynamicshtmls + dynamicshtml
        }
        dynamics.innerHTML = dynamicshtmls

    }

    function addDynamic(data) {
        for (var k = 0; k < data.length; k++) {
            allDynamic.push(data[k])
        }
    }

    function getAllDynamic() {
        $.ajax({
            url: "/experiment/dynamic/getDynamicList",
            type: "get",
            data:{
                page:1
            },
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                addDynamic(data.data.records)
                setDynamics(allDynamic)
            }, fail: function () {
                console.log("fail")
            }
        })
    }

    // function getDynamics(data) {
    //     for (var i = 0; i < data.data.pages; i++) {
    //         $.ajax({
    //             url: "/experiment/dynamic/getDynamicList",
    //             type: "get",
    //             data: {
    //                 page: i
    //             },
    //             dataType: "json",
    //             async: false,
    //             contentType: 'application/json',
    //             success: function (data) {
    //                 addDynamic(data.data.records)
    //                 console.log(data.data.records)
    //             }, fail: function () {
    //                 console.log("fail")
    //             }
    //         })
    //     }
    //
    // }
    getAllDynamic()
    /**
     * 渲染最新实验项目数据
     */
    var allDemo = []

    function setDemos(data) {
        var demos = document.getElementById("cardBox2").querySelector(".bodyBox")
        var demoshtmls = ""
        for (var i = 0; i<data.length&&i < 7; i++) {
            var lockSign=""
            if(data[i].isLock==0) {
                lockSign = "locknone"
            }
                else{
                lockSign="lock"
            }
            var demoshtml = "<div class='box shadow' onclick=linkTo('signUp')>" + "<span>" + data[i].name + "</span><div class='circle'></div><div class='"+lockSign+"'></div></div>"
            demoshtmls = demoshtmls + demoshtml
        }
        demos.innerHTML = demoshtmls
    }

    function addDemo(data) {
        for (var k = 0; k < data.data.records.length; k++) {
            allDemo.push(data.data.records[k])
        }
    }

    function getAllDemo() {
        $.ajax({
            url: "/api/front/experiment/getNewExperimentApply",
            type: "get",
            data:{
                page:1
            },
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                addDemo(data)
            }, fail: function () {
                console.log("fail")
            }
        })
        setDemos(allDemo)
    }

    // function getDemos(data) {
    //     for (var i = 0; i < data.data.pages; i++) {
    //         $.ajax({
    //             url: "/api/front/experiment/getNewExperimentApply",
    //             type: "get",
    //             data: {
    //                 page: i
    //             },
    //             dataType: "json",
    //             async: false,
    //             contentType: 'application/json',
    //             success: function (data) {
    //                 console.log(data)
    //                 addDemo(data)
    //             }, fail: function () {
    //                 console.log("fail")
    //             }
    //         })
    //     }
    //     setDemos(allDemo)
    // }

    getAllDemo()
    /**
     * 点击展开实验室动态
     */
    var sign = -1

    function showDynamics(number) {
        var dynamic = document.getElementById("cardBox1").querySelectorAll(".box")
        if (number == sign) {
            if (parseInt(dynamic[number].style.height) > 50) {
                dynamic[number].style.height = "50px"
            } else {
                dynamic[number].style.height = parseInt(dynamic[number].querySelector(".dynamic-info").offsetHeight) + 50 + "px";
            }
        } else {
            for (var i = 0; i < dynamic.length; i++) {
                dynamic[i].style.height = "50px"
            }
            dynamic[number].style.height = parseInt(dynamic[number].querySelector(".dynamic-info").offsetHeight) + 50 + "px"
            //console.log("test")
        }
        sign = number
    }

    /**
     * 实验室信息
     */

    function setLabInfo(data) {
        var labs = document.getElementById("lab-items")
        var labhtmls = ""
        for (var i = 0; i < data.data.records.length; i++) {
            var labhtml = "<div class='col-lg-4 col-md-6 portfolio-item filter-app experimentBox'>" +
                "<div class='portfolio-wrap experimentImg'>" +
                "<img src='" + JSON.parse(data.data.records[i].imgList) + "'" + "class='img-fluid fit-img' alt=''>" +
                "<div class='portfolio-info experimentInfo'>" +
                "<h4>" + data.data.records[i].name + "</h4>" +
                "<p>" + data.data.records[i].description + "</p></div>" +
                "</div>" +
                "<h3><center>" + data.data.records[i].name + "</center></h3>" +
                "</div>"
            labhtmls = labhtmls + labhtml
        }
        labs.innerHTML = labhtmls
    }

    function getLabInfoNum() {
        $.ajax({
            url: "/api/front/lab/list",
            type: "get",
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                getLabInfo(data.data.total)
            }, fail: function () {
                console.log("fail")
            }
        })
    }

    function getLabInfo(total) {
        $.ajax({
            url: "/api/front/lab/list",
            type: "get",
            data: {
                limit: total
            },
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                setLabInfo(data)
            }, fail: function () {
                console.log("fail")
            }
        })
    }

    getLabInfoNum()

    /**
     * 教师简介
     */
    function setTeacherInfo(data) {
        var teacherInfo = document.getElementById("teacherInfo")
        var normal = "教师"
        var teacherInfoHtmls = ""
        for (var i = 0; i < data.data.length; i++) {
            var teacherInfoHtml = "<div class='col-lg-6 mt-4 teacher-box'>" +
                "<div class='member teacher aos-init' data-aos='zoom-in' data-aos-delay='100'>" +
                "<div class='pic'><img src='" + data.data[i].avatarPath + "' class='img-fluid teacher-img' alt=''></div>" +
                "<div class='member-info'>" +
                "<p style='font-weight: 600'>姓名：" + data.data[i].realName + "</p>" +
                "<p>职责：" + data.data[i].positionName + "</p>" +
                "</div></div></div>"
            teacherInfoHtmls = teacherInfoHtmls + teacherInfoHtml
        }
        teacherInfo.innerHTML = teacherInfoHtmls
    }

    function getTeacherInfo() {
        $.ajax({
            url: "system/front/teacherList/getFrontTeacherList",
            type: "get",
            dataType: "json",
            async: false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                setTeacherInfo(data)
            }, fail: function () {
                console.log("fail")
            }
        })
    }

    getTeacherInfo()

    /**
     * 跳转到接口
     */
    function linkTo(symbol) {
        localStorage.setItem('symbol', symbol)
        window.location.href = '/system/index'
    }
</script>
</html>
