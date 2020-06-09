<%@ page import="java.net.URL" %>
<%@ page import="java.net.URLConnection" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta charset="UTF-8">
    <title>疫情地图</title>
    <script type="text/javascript">
        <%!
            //用于缓存每次读取的疫情数据
            String text;//目的：高并发优化
            //时间戳：格林威治历(1970-1-1 00:00)开始到目前时间的毫秒数字
            //用于表示时间（疫情数据每10分钟更新一次）
            long time = 0;
        %>
        <%
            if(System.currentTimeMillis()-time > 600000){
                //每次获取数据前，更新时间戳
                time = System.currentTimeMillis();
                URL url = new URL("https://zaixianke.com/yq/all");
                URLConnection conn = url.openConnection();
                InputStream is = conn.getInputStream();
                BufferedReader br = new BufferedReader(new InputStreamReader(is,"UTF-8"));
                text = br.readLine();
            }
        %>
        /*将读取到的内容text输出到JS变量data位置*/
        var data = <%=text%>;
    </script>
    <script src="https://cdn.bootcss.com/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdn.bootcss.com/echarts/4.7.0/echarts.min.js"></script>
    <script src="http://cdn.zaixianke.com/china.js"></script>
    <script src="http://cdn.zaixianke.com/world.js"></script>
</head>
<body>
<div id="main" style="width: 100%;height:600px;"></div> <br>
<div style="text-align:center">
    <a style="color:#333" class="control" align="center" href="javascript:updateMap(0)">国内累计</a>
    <a style="color:#333" class="control" align="center" href="javascript:updateMap(1)">国内新增</a>
    <a style="color:#333" class="control" align="center" href="javascript:updateMap(2)">全球累计</a>
    <a style="color:#333" class="control" align="center" href="javascript:updateMap(3)">全球新增</a>
</div>
<script src="js/control.js"></script>
</body>
</html>
