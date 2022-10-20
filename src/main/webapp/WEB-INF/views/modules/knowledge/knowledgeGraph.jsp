<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>知识可视化</title>
    <script type="text/javascript" src="/layui/assets/libs/visjs/vis-network.min.js"></script>
</head>
<body>
<div id="mynetwork" style="width: 100%"></div>

<script type="text/javascript">
    // create an array with nodes
    var nodes = [${nodes}];

    // create an array with edges
    var edges = [${edges}];

    // create a network
    var container = document.getElementById('mynetwork');
    var data = {
        nodes: nodes,
        edges: edges
    };
    var options = {};
    var network = new vis.Network(container, data, options);
</script>
</body>
</html>
