<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="/layui/layim-v3.9.7/layui/css/layui.css"/>
    <title>课堂在线</title>
    <style>
        html {
            background-color: #333;
        }
    </style>
    <script type="text/javascript" src="/layui/layim-v3.9.7/layui/layui.js"></script>
</head>
<script>
    let socket;
    var host = window.location.host;


    var lockReconnect = false; //避免ws重复连接
    var isReconnect = true; //是否重连
    var wsUrl = 'ws://' + host + '/classIm/${user.id}';
    socket = new WebSocket(wsUrl);

    function createWebSocket(wsUrl) {
        try {
            if ('WebSocket' in window) {
                socket = new WebSocket(wsUrl);
            } else if ('MozWebSocket' in window) {
                socket = new MozWebSocket(wsUrl);
            } else {
                layer.msg('您的浏览器不支持websocket协议,建议使用新版谷歌、火狐等浏览器，请勿使用IE10以下浏览器，360浏览器请使用极速模式，不要使用兼容模式！')
            }
            initEventHandle();
        } catch (e) {
            if (isReconnect) {
                reconnect(wsUrl);
            }
            console.log(e);
        }
    }

    function initEventHandle() {
        socket.onclose = function () {
            console.log("连接关闭!" + new Date().toLocaleTimeString());
            if (isReconnect) {
                reconnect(wsUrl);
            }
        };
        socket.onerror = function () {
            layer.msg('网络连接错误，请重新登录！')
            websocketColse();//主动关闭连接
            //定位到登录页面
            console.log("连接错误!" + new Date().toLocaleTimeString());
            if (isReconnect) {
                reconnect(wsUrl);
            }
        };

        //主动关闭连接
        function websocketColse() {
            console.log("主动关闭连接!");
            isReconnect = false
            socket.close()
            socket = null
            lockReconnect = false
            localStorage.clear();
        }

        socket.onopen = function () {
            heartCheck.reset().start(); //心跳检测重置
            // if (localStorage.getItem("userInfor")) {
            //     sendSock("SHIOT|REG|" + JSON.parse(localStorage.getItem("userInfor")).UserId);
            // }
            console.log("连接成功!" + new Date().toLocaleTimeString());
        };
        // ws.onmessage = function (event) { //如果获取到消息，心跳检测重置
        //     heartCheck.reset().start(); //拿到任何消息都说明当前连接是正常的
        //     console.log("收到消息啦:" + event.data)
        //     var arr = event.data.split('|')
        //     if (arr[1] == 'NEWS01') {
        //         var dataArr = event.data.split('|')
        //         Message.success('新消息：  ' + dataArr[4])
        //     }
        //     var eventData = event.data;
        //     handMsg(eventData);
        // };
    }

    //重连
    function reconnect(wsUrl) {
        if (lockReconnect) return;
        lockReconnect = true;
        setTimeout(function () { //没连接上会一直重连，设置延迟避免请求过多
            createWebSocket(wsUrl);
            lockReconnect = false;
        }, 2000);
    }

    //心跳检测
    var heartCheck = {
        //timeout: 540000,        //9分钟发一次心跳
        timeout: 3600, //1分钟发一次心跳
        // timeout: 10800, //3分钟发一次心跳
        timeoutObj: null,
        serverTimeoutObj: null,
        reset: function () {
            clearTimeout(this.timeoutObj);
            clearTimeout(this.serverTimeoutObj);
            return this;
        },
        start: function () {
            var self = this;
            this.timeoutObj = setTimeout(function () {
                self.serverTimeoutObj = setTimeout(function () {
                    //如果超过一定时间还没重置，说明后端主动断开了
                    //如果onclose会执行reconnect，我们执行ws.close()就行了.如果直接执行reconnect 会触发onclose导致重连两次
                    // ws.close();
                }, self.timeout)
            }, this.timeout)
        }
    }
    // 监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        socket.close();
    }

    //刷新页面后需要重连
    if (window.performance.navigation.type == 1) {
        if (isReconnect) {
            reconnect(wsUrl);
        }
    }

    // console.log(host);
    //以下为 layim 最新版写法
    layui.config({
        layimPath: '/layui/layim-v3.9.7/dist/' //配置 layim.js 所在目录
        , layimAssetsPath: '/layui/layim-v3.9.7/dist/layim-assets/' //layim 资源文件所在目录
    }).extend({
        layim: layui.cache.layimPath + 'layim' //配置 layim 组件所在的路径
    }).use('layim', function (layim) { //加载组件

        //配置
        layim.config({
            // brief: true,//是否简约模式（如果true则不显示主面板）
            //获取主面板列表信息
            init: {
                url: '/classIm/init' //接口地址（返回的数据格式见下文）
                , type: 'get' //默认get，一般可不填
                , data: {} //额外参数
            }
        });


        //面板初始化时候获取用户id
        layim.on("ready", function (data) {
            // console.log(socket.readyState);
            console.log(socket);
            socket.onmessage = function (res) {
                //console.log(res.data);
                res = JSON.parse(res.data);
                //console.log(res.content);
                layim.getMessage({
                    username: res.username
                    ,avatar: res.avatar
                    ,id: res.id
                    ,type: res.type
                    ,content: res.content
                    ,timestamp: new Date().getTime()
                });
            }
            // res = JSON.parse(res.data);
            // layim.getMessage(res.data);
            // if(res.emit === 'chatMessage'){
            //   layim.getMessage(res.data); //res.data即你发送消息传递的数据（阅读：监听发送的消息）
            // }
            //  let chat = JSON.parse(res);
            // }
            // socket.onmessage = function(res){
            //   console.log(res);
            //   res = JSON.parse(res);
            //   // if(res.emit === 'chatMessage'){
            //   //   layim.getMessage(res.data); //res.data即你发送消息传递的数据（阅读：监听发送的消息）
            //   // }
            // };
        });

        //发送消息
        layim.on("sendMessage", function (res) {
            socket.send(JSON.stringify({
                type: "chatMessage",
                data: res
            }))
        });


        window.onunload = function () {
            socket.onclose = function () {
                layer.msg("服务器断开连接");
            }
        };
    });

</script>
</body>
</html>
