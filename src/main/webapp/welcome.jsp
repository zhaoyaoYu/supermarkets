<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <a href="/user/logOut">退出</a>
    </div>
</header>
<!--时间-->
<section class="publicTime">
    <span id="time">2015年1月1日 11:11  星期一</span>
    <a href="#">温馨提示：为了能正常浏览，请使用高版本浏览器！（IE10+）</a>
</section>
<!--主体内容-->
<section class="publicMian">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <c:choose>
                    <c:when test="${user.userrole==1 || user.userrole==2 || user.userrole==3}">
                    <li ><a href="/billList.jsp">账单管理</a></li>
                    <li><a href="/providerList.jsp">供应商管理</a></li>
                    <li><a href="/userList.jsp">用户管理</a></li>
                    </c:when>
                </c:choose>
                <li><a href="/password.jsp">密码修改</a></li>
                <li><a href="/user/logOut">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <img class="wColck" src="/img/clock.jpg" alt=""/>
        <div class="wFont">
            <h2>${user.username}</h2>
            <p>欢迎来到超市账单管理系统!</p>
        </div>
    </div>
</section>
<footer class="footer">
    版权归北大青鸟
</footer>
<script src="/js/time.js"></script>
</body>
</html>