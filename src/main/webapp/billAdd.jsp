<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="/css/public.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/pagination.css"/>
    <link rel="stylesheet" href="css/src/css/layui.css" media="all">
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
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>账单管理页面 >> 订单添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="/bill/addBill" method="post" id="myForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div >
                    <label for="billcode">订单编码：</label>
                    <input type="text" name="billcode" id="billcode" required/>
                    <span id="message">*请输入订单编码</span>
                </div>
                <div>
                    <label for="productname">商品名称：</label>
                    <input type="text" name="productname" id="productname" required/>
                    <span >*请输入商品名称</span>
                </div>
                <div>
                    <label for="productunit">商品单位：</label>
                    <input type="text" name="productunit" id="productunit" required/>
                    <span>*请输入商品单位</span>

                </div>
                <div>
                    <label for="productcount">商品数量：</label>
                    <input type="text" name="productcount" id="productcount" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label for="totalprice">总金额：</label>
                    <input type="text" name="totalprice" id="totalprice" required/>
                    <span>*请输入大于0的正自然数，小数点后保留2位</span>
                </div>
                <div>
                    <label for="providerid">供应商：</label>
                    <select id="providerId" name="providerid">
                        <option value="">--请选择相应的提供商--</option>

                    </select>
                    <span>*请选择供应商</span>
                </div>
                <div>
                    <label >是否付款：</label>

                    <select name="ispayment">
                        <option value="1">未付款</option>
                        <option value="2">已付款</option>
                    </select>
                    <span></span>
                </div>
                <div class="providerAddBtn">
                    <input type="submit" value="保存"/>
                    <input type="button" value="返回" onclick="history.back(-1)"/>
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
<script>
    $(function () {
        var flag=true;
        //验证用户编码是否存在
        $("#billcode").blur(function () {
            $.ajax({
                url:"/bill/checkBillCode",
                data:{"billCode":$(this).val()},
                type:"POST",
                success:function (result) {
                    if(result=="false"){
                        $("#message").text("*该编码已经存在，请更换~");
                        flag=false;
                    }else{
                        $("#message").text("*该编码不存在，可以注册~");
                        flag=true;
                    }

                }
            });
        });

        $("#myForm").submit(function () {
            if(!flag){
                alert("*该编码已经存在，请更换~");
                return flag;
            }else if($("#billcode").val()==""||$("#billcode").val()==null){
                alert('code不能为空！');
                return false;
            }else if($("#productname").val()==""||$("#productname").val()==null){
                alert('商品名不能为空！');
                return false;
            }else if($("#productunit").val()==""||$("#productunit").val()==null){
                alert('单位不能为空！');
                return false;
            }else if($("#totalprice").val()==""||$("#totalprice").val()==null){
                alert('价格不能为空！');
                return false;
            }
        })


    })
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