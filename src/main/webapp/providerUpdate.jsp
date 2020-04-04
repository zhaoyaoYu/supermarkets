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
                <li><a href="/user/logOut">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>供应商管理页面 >> 供应商修改页</span>
        </div>
        <div class="providerAdd">
            <form action="/provider/updateProvider/${providerInfo.pid}/${pageNum}" method="post">

                <!--div的class 为error是验证错误，ok是验证成功-->
                <div >
                    <label for="procode">供应商编码：</label>
                    <input type="text" name="procode" id="procode" value="${providerInfo.procode}"/>

                    <span>*</span>
                </div>
                <div>
                    <label for="proname">供应商名称：</label>
                    <input type="text" name="proname" id="proname" value="${providerInfo.proname}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="procontact">联系人：</label>
                    <input type="text" name="procontact" id="procontact" value="${providerInfo.procontact}"/>
                    <span>*</span>

                </div>
                <div>
                    <label for="prophone">联系电话：</label>
                    <input type="text" name="prophone" id="prophone" value="${providerInfo.prophone}"/>
                    <span></span>
                </div>
                <div>
                    <label for="proaddress">联系地址：</label>
                    <input type="text" name="proaddress" id="proaddress" value="${providerInfo.proaddress}"/>
                    <span></span>

                </div>
                <div>
                    <label for="profax">传真：</label>
                    <input type="text" name="profax" id="profax" value="${providerInfo.profax}"/>
                    <span></span>

                </div>
                <div>
                    <label for="prodesc">描述：</label>
                    <input type="text" name="prodesc" id="prodesc" value="${providerInfo.prodesc}"/>
                    <span></span>

                </div>
                <div class="providerAddBtn">
                    <input type="submit" value="保存"/>
                    <a href="/provider/providerView/${pageNum}">返回</a>
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