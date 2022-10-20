<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" pageEncoding="UTF-8" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"></c:set>
<!-- css -->
<link rel="stylesheet" href="/layui/assets/libs/layui/css/layui.css"/>
<link rel="stylesheet" href="/layui/assets/module/admin.css?v=316"/>
<style>
    .main-row {
        border-radius: 2px;
        background-color: #fff;
        box-shadow: 0 1px 2px 0 rgb(0 0 0 / 5%);
        padding: 10px 15px;
    }
</style>
<style>
    /*在Chrome下移除input[number]的上下箭头*/
    .no-number::-webkit-outer-spin-button,
    .no-number::-webkit-inner-spin-button {
        margin: 0;
        -webkit-appearance: none !important;
    }

    .no-number input[type="number"]::-webkit-outer-spin-button,
    .no-number input[type="number"]::-webkit-inner-spin-button {
        margin: 0;
        -webkit-appearance: none !important;
    }

    /*在firefox下移除input[number]的上下箭头*/
    .no-number {
        -moz-appearance: textfield;
    }

    .no-number input[type="number"] {
        -moz-appearance: textfield;
    }
</style>
<!-- js部分 -->
<script type="text/javascript" src="/layui/assets/libs/layui/layui.js"></script>
<script type="text/javascript" src="/layui/assets/js/common.js?v=316"></script>


<script>
    //设置全局请求，如果请求失败，重定向到指定页面
    layui.use(['layer', 'index'], function () {
        var c = layui.jquery;
        var index = layui.index;
        var layer = layui.layer;
        var url = '/system/user/checkUserInfoIsComplete'
        var test = window.location.pathname
        // // console.log('test:', test)

        var contain = [
            "/login",
            "/vue/",
            "/static/",
            "/system/registry/registry",
            "/system/user/updateUserInfoPage",
            "/element-ui/", '/volunteer/register/index',
            "/system/registry/toRegistry"
        ]

        // // console.log('')

        function check() {
            if (test === '/' || test === '/system/index' || test === '/login' || test === '/index') {
                return
            }
            var isGo = true
            contain.forEach(item => {
                if (test.startsWith(item)) {
                    isGo = false
                }
            })
            // // console.log('isgo:', isGo)
            if (isGo) {
                c.get(url, res => {
                    // // console.log('checkUserInfoIsCompletem,res:', res)
                    if (res.code === 0) {
                        if (!res.data) {
                            var isYes = false
                            //验证不通过
                            top.layer.open({
                                type: 1,
                                offset: 'auto',
                                title: false,
                                area: '300px;',
                                id: 'updateUserInfoPageOpen',
                                content: '<div style="padding: 20px;color: orangered">个人信息未完善,请先完善个人信息!</div>',
                                btn: '去完善',
                                btnAlign: 'c',
                                shade: [0.5, '#f5f5f5'],
                                yes: function () {
                                    // layer.closeAll();
                                    // // console.log('yes')
                                    top.layui.index.openTab({
                                        title: '完善个人信息',
                                        url: '/system/user/updateUserInfoPage'
                                    });
                                    isYes = true
                                    top.layer.closeAll();
                                    top.layui.index.cleanAll()
                                },
                                end: () => {
                                    // // // console.log('end:')
                                    if (!isYes) {
                                        top.location = '/logout'
                                    }
                                }
                            })
                        }
                    }
                })
            }
        }

        check()
        var text = '<title>实验管理系统</title>'

        c.ajaxSetup({
            complete: res => {
                //ajax请求完成，不管成功失败
                if (res.responseText.indexOf(text) !== -1) {
                    top.layer.open({
                        type: 1,
                        offset: 'auto',
                        id: 'loginPageOpen',
                        content: '<div style="padding: 20px;color: orangered">账号已在其他地方登录!</div>',
                        btn: '确定',
                        btnAlign: 'c',
                        shade: [0.5, '#f5f5f5'],
                        yes: function () {
                            top.location = '/login'
                        }
                    })
                }
            }

        })
    })


    var formatDate2 = (date) => {
        let y = date.getFullYear();
        let m = date.getMonth() + 1;
        m = m < 10 ? ('0' + m) : m;
        let d = date.getDate();
        d = d < 10 ? ('0' + d) : d;
        let h = date.getHours();
        let minute = date.getMinutes();
        minute = minute < 10 ? ('0' + minute) : minute;
        let second = date.getSeconds();
        second = minute < 10 ? ('0' + second) : second;
        return y + '-' + m + '-' + d + ' ' + h + ':' + minute;
    }


    Date.prototype.Format = function (fmt) { //author: meizz
        var o = {
            "M+": this.getMonth() + 1, //月份
            "d+": this.getDate(), //日
            "h+": this.getHours(), //小时
            "m+": this.getMinutes(), //分
            "s+": this.getSeconds(), //秒
            "q+": Math.floor((this.getMonth() + 3) / 3), //季度
            "S": this.getMilliseconds() //毫秒
        };
        if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
        for (var k in o)
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
        return fmt;
    }
</script>
