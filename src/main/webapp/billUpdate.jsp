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
        <p><span>下午好！</span><span style="color: #fff21b">  ${user.username}</span> , 欢迎你！</p>
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
            <span>账单管理页面 >> 订单添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="/bill/updateBill/${billInfo.bid}/${pageNum}" method="post">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div>
                    <label for="billcode">订单编码：</label>
                    <input type="text" name="billcode" id="billcode" value="${billInfo.billcode}" readonly/>
                    <span>*</span>
                </div>
                <div>
                    <label for="productname">商品名称：</label>
                    <input type="text" name="productname" id="productname" value="${billInfo.productname}"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="productunit">商品单位：</label>
                    <input type="text" name="productunit" id="productunit" value="${billInfo.productunit}"/>
                    <span>*</span>

                </div>
                <div>
                    <label for="productcount">商品数量：</label>
                    <input type="text" name="productcount" id="productcount" value="${billInfo.productcount}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="totalprice">总金额：</label>
                    <input type="text" name="totalprice" id="totalprice" value="${billInfo.totalprice}"/>
                    <span>*</span>
                </div>
                <div>
                    <label for="providerid">供应商：</label>
                    <select id="providerId" name="providerid">
                       <%-- <option value='0'>${billInfo.smbms_provider.proname}</option>--%>
                    </select>
                   <%-- <select id="providerid" name="providerid">
                    <c:forEach var="pro" items="${proList}">
                        <c:choose>
                            <c:when test="${pro.pid==bill.smbms_provider.pid}">
                                <option value="${pro.pid}" selected>${pro.proname}</option>
                            </c:when>
                            <c:otherwise>
                                <option value="${pro.pid}">${pro.proname}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>--%>
                    <span>*</span>
                </div>
                <div>
                    <label >是否付款：</label>

                    <select name="ispayment">
                        <c:choose>
                            <c:when test="${billInfo.ispayment eq 1}">
                                <option value="1" selected>未付款</option>
                                <option value="2">已支付</option>
                            </c:when>
                            <c:otherwise>
                                <option value="1">未付款</option>
                                <option value="2" selected>已支付</option>
                            </c:otherwise>
                        </c:choose>
                    </select>
                </div>
                <div class="providerAddBtn">
                    <input type="submit" value="保存"/>
                    <a href="/bill/billView/${pageNum}">返回</a>
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
<script src="/js/jquery.pagination.js"></script>
<script type="text/javascript">
    $(function () {
        var pageNum = $("#pageNum").val();
        if(pageNum>1){
            load(pageNum);
        }else{
            load(1);
        }
    });

    function load(pageNum) {
        //获取数据
        var productName = $("#productName").val();
        var providerId = $("#providerId").val();

        $.ajax({
            url: "/bill/getBillList",
            data: {"pageNum": pageNum, "productName": productName, "providerId": providerId},
            type: "POST",
            dataType: "JSON",
            success: function (map) {
                //拼接下拉框
                $("#providerId").html("");
                $("#providerId").append("<option value='0'>${billInfo.smbms_provider.proname}</option>");
                $.each(map.proList, function (index, pro) {
                    if(pro.pid==providerId){
                        $("#providerId").append("<option value=" + pro.pid + " selected>" + pro.proname + "</option>");
                    }else{
                        $("#providerId").append("<option value=" + pro.pid + ">" + pro.proname + "</option>");
                    }

                });


            }
        })
    }
</script>
</body>
</html>