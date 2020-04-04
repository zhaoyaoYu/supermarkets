<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="/css/public.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
</head>
<body>
<!--头部-->
<header class="publicHeader">
    <h1>超市账单管理系统</h1>

    <div class="publicHeaderR">
        <p><span>下午好！</span><span style="color: #fff21b"> ${user.username}</span> , 欢迎你！</p>
        <a href="login.jsp">退出</a>
    </div>
</header>
<!--时间-->
<section class="publicTime">
    <span id="time">2015年1月1日 11:11  星期一</span>
    <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
</section>
<!--主体内容-->
<section class="publicMian ">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <c:choose>
                    <c:when test="${user.userrole==1 || user.userrole==2}">
                        <li ><a href="/billList.jsp">账单管理</a></li>
                        <li><a href="/providerList.jsp">供应商管理</a></li>
                        <li><a href="/userList.jsp">用户管理</a></li>
                    </c:when>
                </c:choose>
                <li><a href="/password.jsp">密码修改</a></li>
                <li><a href="/login.jsp">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面 >> 用户信息查看页面</span>
        </div>
        <div class="providerView">
            <p><strong>用户编号：</strong><span>${user.id}</span></p>
            <p><strong>用户名称：</strong><span>${user.username}</span></p>
            <p><strong>用户性别：</strong><span id="tbody"></span></p>
            <p><strong>出生日期：</strong><span id="curDay"></span></p>
            <p><strong>用户电话：</strong><span>${user.phone}</span></p>
            <p><strong>用户地址：</strong><span>${user.address}</span></p>
            <p><strong>用户类别：</strong><span>${user.smbms_role.rolename}</span></p>

            <a href="/userList.jsp">返回</a>
        </div>
    </div>
</section>
<footer class="footer">
    版权归北大青鸟
</footer>
<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/time.js"></script>
<script src="/js/jquery-1.8.3.min.js"></script>
<script>
    $(function () {
        load(1);
    });

    function load(pageNum) {
        alert(user.smbms_role.rolename);
        const strTime=" ${user.birthday}";
        const myDate= new Date(strTime);
        const Y = myDate.getFullYear();
        const M = myDate.getMonth()+1;
        const D = myDate.getDate();
        const curDay = Y + '-'+ M + '-' + D;

        var gender=${user.gender};
        var g='';
        if (gender== 1) {
            g = '男';
        }else {
            g = '女';
        }
        $("#tbody").append("<tr><td>" + g + "</td></tr>");
        $("#curDay").append("<tr><td>" + curDay + "</td></tr>");
    }
</script>
</body>
</html>