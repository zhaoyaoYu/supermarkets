<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="/css/public.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/pagination.css"/>
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
<section class="publicMian ">
    <div class="left">
        <h2 class="leftH2"><span class="span1"></span>功能列表 <span></span></h2>
        <nav>
            <ul class="list">
                <%--<c:choose>
                <c:when test="${user.smbms_role.rolename eq '经理' || user.smbms_role.rolename eq '系统管理员'}">--%>
                <li><a href="/billList.jsp">账单管理</a></li>
                <li><a href="/providerList.jsp">供应商管理</a></li>
                <li><a href="/userList.jsp">用户管理</a></li>
                <%--</c:when>
        </c:choose>--%>
                <li><a href="/password.jsp">密码修改</a></li>
                <li><a href="/user/logOut">退出系统</a></li>
            </ul>
        </nav>
    </div>
    <div class="right">
        <div class="location">
            <strong>你现在所在的位置是:</strong>
            <span>账单管理页面</span>
        </div>
        <div class="search">
            <span>商品名称：</span>
            <input type="text" id="productName" placeholder="请输入商品的名称"/>

            <span>供应商：</span>
            <select id="providerId" name="providerid">
                <option value='0'>请选择</option>

            </select>

            <span>是否付款：</span>
            <select id="isPayment" name="ispayment">
                <option value="0">请选择</option>
                <option value="2">已付款</option>
                <option value="1">未付款</option>
            </select>

            <input type="button" onclick="load(1)" value="查询"/>
            <c:choose>
                <c:when test="${user.userrole==1 || user.userrole==2}">
                    <a href="/billAdd.jsp">添加用户</a>
                </c:when>
            </c:choose>

        </div>
        <!--账单表格 样式和供应商公用-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">账单编码</th>
                <th width="20%">商品名称</th>
                <th width="10%">供应商</th>
                <th width="10%">账单金额</th>
                <th width="10%">是否付款</th>
                <th width="10%">创建时间</th>
                <th width="30%">操作</th>
            </tr>
            <tbody id="tbody"></tbody>


        </table>

        <div id="pageDiv" class="m-style"></div>
    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="ew" id="removePrewovider">
    <div class="ew">
        <h2>提示</h2>
        <div class="ew">
            <p>你确定要删除该订单吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>

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
        var isPayment = $("#isPayment").val();
        $.ajax({
            url: "/bill/getBillList",
            data: {"pageNum": pageNum, "productName": productName, "providerId": providerId, "isPayment": isPayment},
            type: "POST",
            dataType: "JSON",
            success: function (map) {
                //拼接下拉框
                $("#providerId").html("");
                $("#providerId").append("<option value='0'>请选择</option>");
                $.each(map.proList, function (index, pro) {
                    if(pro.pid==providerId){
                        $("#providerId").append("<option value=" + pro.pid + " selected>" + pro.proname + "</option>");
                    }else{
                        $("#providerId").append("<option value=" + pro.pid + ">" + pro.proname + "</option>");
                    }

                });


                //拼接表格数据
                $("#tbody").html('');
                $.each(map.pageInfo.list, function (index, bill) {

                    if (bill.ispayment == 1) {
                        isPayMent = "未付款";
                    } else {
                        isPayMent = "已付款";
                    }
                    $("#tbody").append("<tr><td>" + bill.billcode + "</td><td>" + bill.productname + "</td><td>" + bill.smbms_provider.proname + "</td><td>" + bill.totalprice + "</td><td>" + isPayMent + "</td><td>"+(new Date(bill.createddate)).toLocaleString()
                        + "</td><td><a href='/bill/getBillByID/"+bill.bid+"/"+map.pageInfo.pageNum+"'><img src='/img/read.png' alt='查看' title='查看'/></a>\n" +
                        "                        <a href='/bill/getBillByIDUp/"+bill.bid+"/"+map.pageInfo.pageNum+"'><img src='/img/xiugai.png' alt='修改' title='修改'/></a>\n" +
                        "                         <a href='/bill/deleteBill/"+bill.bid+"/"+map.pageInfo.pageNum+"' class='removeProvider'><img src='/img/schu.png' alt='删除' title='删除'/></a></td></tr>");
                });

                //构建分页
                $("#pageDiv").pagination({
                    pageCount : map.pageInfo.pages,
                    totalData : map.pageInfo.total, //代表总记录数
                    jump : true, //开启跳转功能
                    coping : true, //开启首页尾页
                    homePage : '首页',
                    endPage : '末页',
                    prevContent : '上页',
                    nextContent : '下页',
                    current : map.pageInfo.pageNum, //当前页码
                    callback : function(api) { //api代表整个pagination
                        load(api.getCurrent());
                    }
                });

            }
        })
    }


</script>
</body>
</html>