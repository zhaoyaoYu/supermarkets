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
        <a href="/login.jsp">退出</a>
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
                <li><a href="/user/logOut">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>用户管理页面 >> 用户修改页面</span>
        </div>
        <div class="providerAdd">
            <form action="/user/updateUser/${userInfo.id}/${pageNum}" method="post">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="userName">用户名称：</label>
                    <input type="text" name="username" id="username" value="${userInfo.username}"/>
                    <span >*</span>
                </div>

                <div>
                    <label >用户性别：</label>

                    <select name="gender">
                        <c:choose>
                            <c:when test="${userInfo.gender eq 1}">
                                <option value="1" selected>男</option>
                                <option value="2">女</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">男</option>
                                <option value="2" selected>女</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <div>
                    <label for="birthdaydate">出生日期：</label>
                    <input type="date" name="birthdaydate" id="birthdaydate" value="<fmt:formatDate value="${userInfo.birthday}" pattern="yyyy-MM-dd" />"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone" value="${userInfo.phone}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                    <input type="text" name="address" id="address" value="${userInfo.address}"/>
                </div>
                <div>
                    <label >用户类别：</label>
                    <c:choose>
                        <c:when test="${userInfo.smbms_role.rid == 1 }">
                            <input type="radio" value="1" name="userrole" checked/>管理员
                            <input type="radio" value="2" name="userrole" />经理
                            <input type="radio" value="3" name="userrole"/>普通用户
                        </c:when>
                        <c:when test="${userInfo.smbms_role.rid == 2 }">
                            <input type="radio" value="1" name="userrole" />管理员
                            <input type="radio" value="2" name="userrole" checked/>经理
                            <input type="radio" value="3" name="userrole"/>普通用户
                        </c:when>
                        <c:when test="${userInfo.smbms_role.rid == 3 }">
                            <input type="radio" value="1" name="userrole" />管理员
                            <input type="radio" value="2" name="userrole" />经理
                            <input type="radio" value="3" name="userrole" checked/>普通用户
                        </c:when>
                    </c:choose>


                </div>
                <div class="providerAddBtn">
                    <input type="submit" value="保存"/>
                    <a href="/user/userView/${pageNum}">返回</a>
<%--                    <input type="button" value="返回" onclick="history.back(-1)"/>--%>
                </div>
            </form>
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

</body>
</html>