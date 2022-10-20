<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<!DOCTYPE html>

<head>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>广州大学心理实验室</title>
    <meta content="" name="description">
    <meta content="" name="keywords">

    <!-- Favicons -->
    <link href="${ctx}/assets/images/logo.jpg" rel="icon">
    <link href="${ctx}/assets/img/apple-touch-icon.png" rel="apple-touch-icon">

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">

    <!-- Vendor CSS Files -->
    <link href="${ctx}/assets/vendor/aos/aos.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/glightbox/css/glightbox.min.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="${ctx}/assets/vendor/swiper/swiper-bundle.min.css" rel="stylesheet">

    <!-- Template Main CSS File -->
    <link href="assets/css/style.css" rel="stylesheet">
    <style type="text/css">
        /**,
        *::before,
        *::after {
            box-sizing: inherit;
          }*/
        .box {
            width: 400px;
            display: block;
            height: 50px;
            position: relative;
            border-radius: 5px;
            background: linear-gradient(to right, #abbd73 35%, #d6e2ad 100%);
            margin-bottom: 40px;
            color: darkslategray;
            box-shadow: 1px 2px 1px -1px #777;
            transition: background 200ms ease-in-out;
            text-align:left;
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
            border-radius: 50%;
            box-shadow: inset 1px 1px 1px 0px rgba(0, 0, 0, 0.5), inset 0 0 0 25px white;
            width: 20px;
            height: 20px;
            display: inline-block;
            text-align:right;
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
        }

        .bodyBox {
            padding: 10px;
        }
        .box span{
            display: block;
            position: absolute;
            top: 15px;
            left: 35px;
            width:365px;
            height:20px;
            padding-left: 5px;
            text-align: left;
            font-size: 16px;
            line-height: 20px;
            overflow-x: hidden;
            overflow-y: hidden;
            white-space:nowrap;
            text-overflow: ellipsis;
        }

        .bodyBox p {
            margin-left: 5px;
        }

    </style>
</head>

<body>

<!-- ======= Header ======= -->
<header id="header" class="fixed-top d-flex align-items-center">
    <div class="container">
        <div class="header-container d-flex align-items-center justify-content-between">
            <div class="logo">
                <h1 class="text-light"><a href="index.html"><span>广州大学心理实验室</span></a></h1>
                <!-- Uncomment below if you prefer to use an image logo -->
                <!-- <a href="index.html"><img src="assets/img/logo.png" alt="" class="img-fluid"></a>-->
            </div>

            <nav id="navbar" class="navbar">
                <ul>
                    <li><a class="nav-link scrollto active" href="#hero">中心首页</a></li>
                    <li><a class="nav-link scrollto" href="#about">实验室介绍</a></li>
                    <li><a class="nav-link scrollto" href="#services">实验资源</a></li>
                    <li><a class="nav-link scrollto " href="#team">教师简介</a></li>
                    <li><a class="nav-link scrollto" href="#">创新实践</a></li>
                    <li><a class="nav-link scrollto" href="#">实验教学</a></li>
                    <li><a class="getstarted scrollto" href="http://www.gzhu.edu.cn/">广大官网</a></li>
                </ul>
                <i class="bi bi-list mobile-nav-toggle"></i>
            </nav><!-- .navbar -->

        </div><!-- End Header Container -->
    </div>
</header><!-- End Header -->

<!-- ======= Hero Section ======= -->
<section id="hero" class="d-flex align-items-center">
    <div class="container text-center position-relative" data-aos="fade-in" data-aos-delay="200">
        <h1>欢迎来到广州大学心理实验室</h1>
        <h2>在这里你可以遇到你心仪的心理实验室功能</h2>
        <a href="#about" class="btn-get-started scrollto">登录</a>
        <a href="#about" class="btn-get-started scrollto">注册</a>
    </div>
</section><!-- End Hero -->

<main id="main">

    <!-- ======= Why Us Section ======= -->
    <section id="about" class="why-us">
        <div class="container">

            <div class="row">
                <div class="col-lg-4 d-flex align-items-stretch" data-aos="fade-right">
                    <div class="content" id="introduct">
                        <h3>广州大学心理实验室</h3>
                        <p>
                        </p>
                        <div class="text-center">
                            <a href="#" class="more-btn">了解更多<i class="bx bx-chevron-right"></i></a>
                        </div>
                    </div>
                </div>
                <div id="cardBox1">
                    <div class="headerBox" style="background-color: #009970;">
                        <p>
                            <a title="查看更多" style="cursor: pointer; color:white">最新实验室动态</a>
                        </p>
                    </div>
                    <div class="bodyBox">
                    </div>
                </div>
                <div id="cardBox2">
                    <div class="headerBox" style="background-color: #009970;">
                        <p>
                            <a title="查看更多" style="cursor: pointer; color:white">最新的实验室项目</a>
                        </p>
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
    <section id="cta" class="cta">
        <div class="container">

            <div class="text-center" data-aos="zoom-in">
                <h3>马上登录</h3>
                <p>想要享受实验室资源，需要您登录验证身份，如果您是本校本学院学生/老师，有账号直接可以登录，如果还没有账号，需要与心理学学院提出申请，在本页面即可通过注册获取账号，享受权益</p>
                <a class="cta-btn" href="#">立即行动</a>
            </div>

        </div>
    </section><!-- End Cta Section -->

    <!-- ======= Services Section ======= -->
    <section id="services" class="services section-bg">
        <div class="container">

            <div class="row">
                <div class="col-lg-4">
                    <div class="section-title" data-aos="fade-right">
                        <h2>实验室资源</h2>
                        <p>实验申请可以申请一些实验利用实验室设备进行探究，被试报名可以报名一些实验，仪器借用可以借用实验室里面你需要的设备/仪器，实验室申请可以申请需要的特定实验室</p>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row">
                        <div class="col-md-6 d-flex align-items-stretch">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="100">
                                <div class="icon"><i class="bx bxl-dribbble"></i></div>
                                <h4><a href="">实验申请</a></h4>
                                <p>申请者可以申请大量有意义的实验，完成作业，完成自身的学业</p>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex align-items-stretch mt-4 mt-lg-0">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="200">
                                <div class="icon"><i class="bx bx-file"></i></div>
                                <h4><a href="">被试报名</a></h4>
                                <p>参加报名其他学生的实验或老师公布的实验，可以获取一定的报酬</p>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex align-items-stretch mt-4">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="300">
                                <div class="icon"><i class="bx bx-tachometer"></i></div>
                                <h4><a href="">仪器借用</a></h4>
                                <p>为了完成特定的实验需要特定的仪器设备，在这里你会得到满足！</p>
                            </div>
                        </div>

                        <div class="col-md-6 d-flex align-items-stretch mt-4">
                            <div class="icon-box" data-aos="zoom-in" data-aos-delay="400">
                                <div class="icon"><i class="bx bx-world"></i></div>
                                <h4><a href="">实验室申请</a></h4>
                                <p>拥有各种各样的实验室，通过申请，批准，实验离成功就不远了</p>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>
    </section>


    <!-- ======= Team Section ======= -->
    <section id="team" class="team">
        <div class="container">
            <div class="row">
                <div class="col-lg-4">
                    <div class="section-title" data-aos="fade-right">
                        <h2>教师简介</h2>
                        <p>介绍实验室的主要老师，里面肯定有你想要认识的</p>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="row">

                        <div class="col-lg-6">
                            <div class="member" data-aos="zoom-in" data-aos-delay="100">
                                <div class="pic"><img src="${ctx}/assets/images/i1.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师1</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522223333</p>
                                    <p>邮箱：16522223333@test.com</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mt-4 mt-lg-0">
                            <div class="member" data-aos="zoom-in" data-aos-delay="200">
                                <div class="pic"><img src="${ctx}/assets/images/i2.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师2</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522224444</p>
                                    <p>邮箱：16522224444@test.com</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mt-4">
                            <div class="member" data-aos="zoom-in" data-aos-delay="300">
                                <div class="pic"><img src="${ctx}/assets/images/i3.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师3</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522225555</p>
                                    <p>邮箱：16522225555@test.com</p>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-6 mt-4">
                            <div class="member" data-aos="zoom-in" data-aos-delay="400">
                                <div class="pic"><img src="${ctx}/assets/images/i4.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师4</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522226666</p>
                                    <p>邮箱：16522226666@test.com</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 mt-4">
                            <div class="member" data-aos="zoom-in" data-aos-delay="400">
                                <div class="pic"><img src="${ctx}/assets/images/i5.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师5</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522227777</p>
                                    <p>邮箱：16522227777@test.com</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 mt-4">
                            <div class="member" data-aos="zoom-in" data-aos-delay="400">
                                <div class="pic"><img src="${ctx}/assets/images/i6.png" class="img-fluid" alt=""></div>
                                <div class="member-info">
                                    <h4>老师6</h4>
                                    <p>职责：教师</p>
                                    <p>电话：16522228888</p>
                                    <p>邮箱：16522228888@test.com</p>
                                </div>
                            </div>
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
                    <h3>地址</h3>
                    <p>
                        广东省广州市番禺区<br>
                        广州大学教育学院心理系<br>
                        <br><br>
                        <strong>邮政编码</strong>510006<br>
                        <strong>邮箱</strong> info@example.com<br>
                    </p>
                </div>

                <div class="col-lg-2 col-md-6 footer-links">
                    <h4>友情链接</h4>
                    <ul>
                        <li><i class="bx bx-chevron-right"></i> <a href="www.gzhu.edu.cn" target="_blank">广州大学</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://www.most.gov.cn/index.html" target="_blank">中华人民共和国科学技术部</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://www.moe.gov.cn/" target="_blank">中华人民共和国教育部</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="https://www.nsfc.gov.cn/" target="_blank">国家自然基金科学委员会</a></li>
                        <li><i class="bx bx-chevron-right"></i> <a href="http://www.chinaooc.cn/front/index.htm" target="_blank">国家一级本科课程建设工作网</a></li>
                    </ul>
                </div>

<%--                <div class="col-lg-3 col-md-6 footer-links">--%>
<%--                    <h4>Our Services</h4>--%>
<%--                    <ul>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="#">Web Design</a></li>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="#">Web Development</a></li>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="#">Product Management</a></li>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="#">Marketing</a></li>--%>
<%--                        <li><i class="bx bx-chevron-right"></i> <a href="#">Graphic Design</a></li>--%>
<%--                    </ul>--%>
<%--                </div>--%>

            </div>
        </div>
    </div>
</footer><!-- End Footer -->

<a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

<!-- Vendor JS Files -->
<script src="${ctx}/assets/vendor/aos/aos.js"></script>
<script src="${ctx}/assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${ctx}/assets/vendor/glightbox/js/glightbox.min.js"></script>
<script src="${ctx}/assets/vendor/isotope-layout/isotope.pkgd.min.js"></script>
<script src="${ctx}/assets/vendor/php-email-form/validate.js"></script>
<script src="${ctx}/assets/vendor/purecounter/purecounter.js"></script>
<script src="${ctx}/assets/vendor/swiper/swiper-bundle.min.js"></script>

<!-- Template Main JS File -->
<script src="assets/js/main.js"></script>

</body>
<script type="text/javascript" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
    /**
     * 渲染实验室介绍数据
     */
    function setIntroduct(data){
            var str=data.data.description.substring(0,276);
            document.getElementById("introduct").querySelector("p").innerText=str
    }
    function getIntroduct(){
        $.ajax({
            url:"/experiment/setDescription/get-description",
            type:"get",
            dataType:"json",
            async:false,
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
    function setDynamics(data) {
        var dynamics=document.getElementById("cardBox1").querySelector(".bodyBox")
        var dynamicshtmls=""
        for(var i=0;i<data.data.records.length;i++){
            var dynamicshtml="<div class='box shadow'>"+"<span>"+data.data.records[i].content+"</span><div class='circle'></div></div>"
            dynamicshtmls=dynamicshtmls+dynamicshtml
        }
        dynamics.innerHTML=dynamicshtmls

    }
    function getDynamics(){
        $.ajax({
            url:"/experiment/dynamic/getDynamicList",
            type:"get",
            data: {
                page:1,
                limit:5
            },
            dataType:"json",
            async:false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                setDynamics(data)
            }, fail: function () {
                console.log("fail")
            }
        })

    }
    getDynamics()
    /**
     * 渲染最新实验项目数据
     */
    function setDemos(data){
        var demos=document.getElementById("cardBox2").querySelector(".bodyBox")
        var demoshtmls=""
        for(var i=0;i<data.data.records.length;i++){
            var demoshtml="<div class='box shadow'>"+"<span>"+data.data.records[i].name+"</span><div class='circle'></div></div>"
            demoshtmls=demoshtmls+demoshtml
        }
        demos.innerHTML=demoshtmls
    }
    function getDemos(){
        $.ajax({
            url:"/api/front/experiment/getNewExperimentApply",
            type:"get",
            data: {
                page:2,
                limit:5
            },
            dataType:"json",
            async:false,
            contentType: 'application/json',
            success: function (data) {
                //console.log(data)
                setDemos(data)
            }, fail: function () {
                console.log("fail")
            }
        })

    }
    getDemos()

</script>

</html>
