<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
  <link rel="stylesheet" href="/layui/assets/libs/layui/css/layui.css"/>
  <title>课堂在线</title>
  <style>
    html{background-color: #333;}
  </style>
  <script type="text/javascript" src="/layui/assets/libs/layui/layui.js"></script>
</head><script>

  layui.config({
    layimPath: '/layim-v3.9.7/dist/' //配置 layim.js 所在目录
    ,layimAssetsPath: '/layim-v3.9.7/dist/layim-assets/' //layim 资源文件所在目录
  }).extend({
    layim: layui.cache.layimPath + 'layim' //配置 layim 组件所在的路径
  }).use('layim', function(layim){ //加载组件

    //演示自动回复
    var autoReplay = [
      '您好，我现在有事不在，一会再和您联系。',
      '你没发错吧？face[微笑] ',
      '这是一段演示消息 face[哈哈] ',
      '演示消息 face[心] face[心] face[心] ',
      'face[威武] face[威武] face[威武] face[威武] ',
      '<（@￣︶￣@）>',
      '你要和我说话？你真的要和我说话？你确定自己想说吗？你一定非说不可吗？那你说吧，这是自动回复。',
      'face[黑线]  你慢慢说，别急……',
      '(*^__^*) face[嘻嘻]'
    ];

    //基础配置
    layim.config({

      //初始化接口
      // init: {
      //   url: 'json/getList.json'
      //   ,data: {}
      // }

      //或采用以下方式初始化接口

      init: {
        mine: {
          "username": "LayIM体验者" //我的昵称
          ,"id": "100000123" //我的ID
          ,"status": "online" //在线状态 online：在线、hide：隐身
          ,"remark": "在深邃的编码世界，做一枚轻盈的纸飞机" //我的签名
          ,"avatar": "a.jpg" //我的头像
        }
        ,friend: []
        ,group: []
      }



      //查看群员接口
     /* ,members: {
        url: 'json/getMembers.json'
        ,data: {}
      }*/

      //上传图片接口
      ,uploadImage: {
        url: '/upload/image' //（返回的数据格式见下文）
        ,type: '' //默认post
      }

      //上传文件接口
      ,uploadFile: {
        url: '/upload/file' //（返回的数据格式见下文）
        ,type: '' //默认post
      }

      ,isAudio: true //开启聊天工具栏音频
      ,isVideo: true //开启聊天工具栏视频

      //扩展工具栏
      ,tool: [{
        alias: 'code'
        ,title: '代码'
        ,icon: '&#xe64e;'
      }]

      //,brief: true //是否简约模式（若开启则不显示主面板）

      //,title: 'WebIM' //自定义主面板最小化时的标题
      //,right: '100px' //主面板相对浏览器右侧距离
      //,minRight: '90px' //聊天面板最小化时相对浏览器右侧距离
      ,initSkin: '5.jpg' //1-5 设置初始背景
      //,skin: ['aaa.jpg'] //新增皮肤
      //,isfriend: false //是否开启好友
      //,isgroup: false //是否开启群组
      //,min: true //是否始终最小化主面板，默认false
      ,notice: true //是否开启桌面消息提醒，默认false
      //,voice: false //声音提醒，默认开启，声音文件为：default.mp3

      ,msgbox: layui.cache.layimAssetsPath + 'html/msgbox.html' //消息盒子页面地址，若不开启，剔除该项即可
      ,find: layui.cache.layimAssetsPath + 'html/find.html' //发现页面地址，若不开启，剔除该项即可
      ,chatLog: layui.cache.layimAssetsPath + 'html/chatlog.html' //聊天记录页面地址，若不开启，剔除该项即可

    });

    /*
    layim.chat({
      name: '自定义窗口-1'
      ,type: 'kefu'
      ,avatar: ''
      ,id: -1
    });
    layim.chat({
      name: '自定义窗口-2'
      ,type: 'kefu'
      ,avatar: ''
      ,id: -2
    });
    layim.setChatMin();*/

    //监听在线状态的切换事件
    layim.on('online', function(data){
      //console.log(data);
    });

    //监听签名修改
    layim.on('sign', function(value){
      //console.log(value);
    });

    //监听自定义工具栏点击，以添加代码为例
    layim.on('tool(code)', function(insert){
      layer.prompt({
        title: '插入代码'
        ,formType: 2
        ,shade: 0
      }, function(text, index){
        layer.close(index);
        insert('[pre class=layui-code]' + text + '[/pre]'); //将内容插入到编辑器
      });
    });

    //监听layim建立就绪
    layim.on('ready', function(res){

      //console.log(res.mine);

      layim.msgbox(5); //模拟消息盒子有新消息，实际使用时，一般是动态获得

      //添加好友示例（如果检测到该socket）
      layim.addList({
        type: 'group'
        ,avatar: ""
        ,groupname: 'Angular开发'
        ,id: "12333333"
        ,members: 0
      });
      layim.addList({
        type: 'friend'
        ,avatar: "http://tp2.sinaimg.cn/2386568184/180/40050524279/0"
        ,username: '测试222'
        ,groupid: 2
        ,id: "1233333312121212"
        ,remark: "XX"
      });

      setTimeout(function(){
        //接受消息（如果检测到该socket）
        layim.getMessage({
          username: "Hi 测试"
          ,avatar: layui.cache.layimAssetsPath + "images/default.png"
          ,id: "10000111"
          ,type: "friend"
          ,content: "临时："+ new Date().getTime()
        });

        /*layim.getMessage({
          username: "测试1"
          ,avatar: ""
          ,id: "100001"
          ,type: "friend"
          ,content: "嗨，你好！演示标记："+ new Date().getTime()
        });*/

      }, 3000);
    });

    //监听发送消息
    layim.on('sendMessage', function(data){
      var To = data.to;
      //console.log(data);

      if(To.type === 'friend'){
        layim.setChatStatus('<span style="color:#FF5722;">对方正在输入。。。</span>');
      }

      //演示自动回复
      setTimeout(function(){
        var obj = {};
        if(To.type === 'group'){
          obj = {
            username: '模拟群员'+(Math.random()*100|0)
            ,avatar: layui.cache.layimAssetsPath + 'images/face/'+ (Math.random()*72|0) + '.gif'
            ,id: To.id
            ,type: To.type
            ,content: autoReplay[Math.random()*9|0]
          }
        } else {
          obj = {
            username: To.name
            ,avatar: To.avatar
            ,id: To.id
            ,type: To.type
            ,content: autoReplay[Math.random()*9|0]
          }
          layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
        }
        layim.getMessage(obj);
      }, 1000);
    });

    //监听查看群员
    layim.on('members', function(data){
      //console.log(data);
    });

    //监听聊天窗口的切换
    layim.on('chatChange', function(res){
      var type = res.data.type;
      console.log(res.data.id)
      if(type === 'friend'){
        //模拟标注好友状态
        //layim.setChatStatus('<span style="color:#FF5722;">在线</span>');
      } else if(type === 'group'){
        //模拟系统消息
        layim.getMessage({
          system: true
          ,id: res.data.id
          ,type: "group"
          ,content: '模拟群员'+(Math.random()*100|0) + '加入群聊'
        });
      }
    });
  });
</script>
</body>
</html>
