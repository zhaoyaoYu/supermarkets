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
        <a href="login.html">退出</a>
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
            <span>用户管理页面</span>
        </div>
        <div class="search">
        <span>用户名：</span>
        <input type="text" id="userName" placeholder="请输入用户名"/>
        <input type="button" onclick="load(1)" value="查询"/>
            <c:choose>
                <c:when test="${user.userrole==1 || user.userrole==2}">
                    <a href="/userAdd.jsp">添加用户</a>
                </c:when>
            </c:choose>
        </div>
        <!--用户-->
        <table class="providerTable" cellpadding="0" cellspacing="0">
            <tr class="firstTr">
                <th width="10%">用户编码</th>
                <th width="20%">用户名称</th>
                <th width="10%">性别</th>
                <th width="10%">年龄</th>
                <th width="10%">电话</th>
                <th width="10%">用户类型</th>
                <th width="10%">用户状态</th>
                <th width="30%">操作</th>
            </tr>

            <tbody id="tbody" >
            </tbody>

            <div class="layui-form-item layui-form" >
                <label class="layui-form-label">开关-默认开</label>
                <div class="layui-input-block">
                    <input type="checkbox" checked="" name="open" lay-skin="switch" lay-filter="switchTest" lay-text="ON|OFF">
                </div>
            </div>



        </table>

        <div id="pageDiv" class="m-style"></div>
    </div>
</section>

<!--点击删除按钮后弹出的页面-->
<div class="zhezhao"></div>
<div class="remove" id="removeUse">
    <div class="removerChid">
        <h2>提示</h2>
        <div class="removeMain">
            <p>你确定要删除该用户吗？</p>
            <a href="#" id="yes">确定</a>
            <a href="#" id="no">取消</a>
        </div>
    </div>
</div>
<input type="hidden" value="${pageNum}" id="pageNum"/>
<input type="hidden" value="${user.userrole}" id="userrole"/>
<footer class="footer">
    版权归北大青鸟
</footer>

<script src="/js/jquery.js"></script>
<script src="/js/js.js"></script>
<script src="/js/time.js"></script>
<script src="/js/jquery-1.8.3.min.js"></script>
<script src="/js/jquery.pagination.js"></script>
<script src="css/src/layui.js" charset="utf-8"></script>
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

        //获取用户搜索文本框的值
        var userName = $("#userName").val();

        $.ajax({
            url: "/user/getUserByName",
            data: {"userName": userName, "pageNum": pageNum},
            type: "POST",
            dataType: "JSON",
            success: function (pageInfo) {

                $("#tbody").html('');
                var gender = '女';
                var isDelete="启用";
                //拼接数据
                $(pageInfo.list).each(function (index, user) {
                    if (user.gender == 1) {
                        gender = '男';
                    } else {
                        gender = '女';
                    }
                    if (user.isdelete == 0){
                        isDelete = "启用";
                    }else {
                        isDelete = "禁用";
                    }

                    var userole=$("#userrole").val();

                    if(userole==1 || userole==2){
                        if (user.isdelete == 0){
                            $("#tbody").append("<tr><td>" + user.id + "</td><td>" + user.username + "</td><td>" + gender + "</td><td>" + user.userage + "</td><td>" + user.phone + "</td><td>" + user.smbms_role.rolename + "</td><td>"+isDelete+"</td><td><a href='/user/getUserByID/"+user.id+"/"+pageInfo.pageNum+"'><img src='/img/read.png' alt='查看' title='查看'/></a><a href='/user/getUserByIDUp/"+user.id+"/"+pageInfo.pageNum+"'><img src='/img/xiugai.png' alt='修改' title='修改'/></a><a onclick='userIsStatus("+user.isdelete+","+user.id+","+pageNum+")' class='removeUser'><img src='/img/schu.png' alt='拉黑' title='拉黑'/></a></td>");
                        }else {
                            $("#tbody").append("<tr><td>" + user.id + "</td><td>" + user.username + "</td><td>" + gender + "</td><td>" + user.userage + "</td><td>" + user.phone + "</td><td>" + user.smbms_role.rolename + "</td><td>"+isDelete+"</td><td><a href='/user/getUserByID/"+user.id+"/"+pageInfo.pageNum+"'><img src='/img/read.png' alt='查看' title='查看'/></a><a href='/user/getUserByIDUp/"+user.id+"/"+pageInfo.pageNum+"'><img src='/img/xiugai.png' alt='修改' title='修改'/></a><a onclick='userIsStatus("+user.isdelete+","+user.id+","+pageNum+")' class='removeUser'><img src='/img/mm.png' alt='禁用' title='禁用'/></a></td>");

                        }

                    }else {
                        $("#tbody").append("<tr><td>" + user.id + "</td><td>" + user.username + "</td><td>" + gender + "</td><td>" + user.userage + "</td><td>" + user.phone + "</td><td>" + user.smbms_role.rolename + "</td><td>"+isDelete+"</td><td><span>抱歉，您没有权限操作~</span></td>");
                    }

                        $("#tbody").append("</tr>")

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
    function userIsStatus(isdelete,id,pageNum) {
        var userole=$("#userrole").val();
        var userName = $("#userName").val();
        if(userole==1){
            //状态改变
            if (isdelete==1){
                //启用
                var flag=confirm("您确定要启用该用户嘛？");
                if(flag){
                    location.href="http://localhost:8080/user/userIsDelete/"+id+"/"+pageNum+"/0/"+userName;
                }
            }else{
                //禁用
                var flag=confirm("您确定要禁用该用户嘛？");
                if(flag){

                    location.href="http://localhost:8080/user/userIsDelete/"+id+"/"+pageNum+"/1/"+userName;
                }
            }
        }else{
            alert("您，没有权限进行操作~");
        }
    }

    layui.use(['form'], function(){
        var form = layui.form;

        //监听指定开关
        form.on('switch(switchTest)', function(data){
            layer.msg('开关checked：'+ (this.checked ? 'true' : 'false'), {
                offset: '6px'
            });
            if (this.checked==true){
                alert("11111111111111111");
            }else {
                alert("12")
            }
        });

        //监听提交
        form.on('submit(demo1)', function(data){
            layer.alert(JSON.stringify(data.field), {
                title: '最终的提交信息'
            })
            return false;
        });

    });

</script>
</body>
</html>