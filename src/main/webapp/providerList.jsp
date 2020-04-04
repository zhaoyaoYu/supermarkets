<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>超市账单管理系统</title>
    <link rel="stylesheet" href="/css/public.css"/>
    <link rel="stylesheet" href="/css/style.css"/>
    <link rel="stylesheet" href="/css/pagination.css">

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
            <span>供应商管理页面</span>
        </div>
        <div class="search">
            <span>用户名：</span>
            <input type="text" id="proName" placeholder="请输入用户名"/>
            <input type="button" onclick="load(1)" value="查询"/>
            <a href="/providerAdd.jsp">添加用户</a>
        </div>
        <!--供应商操作表格-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">供应商编码</th>
                <th width="20%">供应商名称</th>
                <th width="10%">联系人</th>
                <th width="10%">联系电话</th>
                <th width="10%">传真</th>
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
<div class="remove" id="removeProv">
   <div class="removerChid">
       <h2>提示</h2>
       <div class="removeMain" >
           <p>你确定要删除该供应商吗？</p>
           <a href="#" id="yes">确定</a>
           <a href="#" id="no">取消</a>
       </div>
   </div>
</div>

<input type="hidden" id="pageNum" value="${pageNum}"/>
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
        var pageNum=$("#pageNum").val();
        if(pageNum>1){
            load(pageNum)
        }else{
            load(1);
        }

    });
    function load(pageNum) {
        //获取用户搜索文本框的值
        var proName = $("#proName").val();


        $.ajax({
            url: "/provider/getProviderByName",
            data: {"proName": proName, "pageNum": pageNum},
            type: "POST",
            dataType: "JSON",
            success: function (pageInfo) {


                $("#tbody").html('');
                //拼接数据
                $(pageInfo.list).each(function (index, user) {
                    $("#tbody").append("<tr><td>" + user.procode + "</td><td>" + user.proname + "</td><td>" + user.procontact + "</td><td>" + user.prophone + "</td><td>" + user.profax + "</td><td>"  + (new Date(user.creationdate)).toLocaleString( )+ "</td><td><a href='/provider/getProByCode/"+user.pid+"/"+pageInfo.pageNum+"'><img src='/img/read.png' alt='查看' title='查看'/></a>\n" +
                        "                    <a href='/provider/getProviderByPIDUp/"+user.pid+"/"+pageInfo.pageNum+"'><img src='/img/xiugai.png' alt='修改' title='修改'/></a>\n" +
                        "                    <a href='/provider/deleteProvider/"+user.procode+"/"+pageInfo.pageNum+"' class='removeProvider'><img src='/img/schu.png' alt='删除' title='删除'/></a></td></tr>")
                });

                //构建分页
                $("#pageDiv").pagination({
                    pageCount : pageInfo.pages,
                    totalData : pageInfo.total, //代表总记录数
                    jump : true, //开启跳转功能
                    coping : true, //开启首页尾页
                    homePage : '首页',
                    endPage : '末页',
                    prevContent : '上页',
                    nextContent : '下页',
                    current : pageInfo.pageNum, //当前页码
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