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
                <span>密码修改页面</span>
            </div>
            <div class="providerAdd">
                <form id="myForm" action="/user/updatePassword" method="post">
                    <!--div的class 为error是验证错误，ok是验证成功-->
                    <div class="">
                        <label for="oldPassword">旧密码：</label>
                        <input type="password" name="oldPassword" id="oldPassword" required/>
                        <span id="checkPassWordResult">*请输入原密码</span>
                    </div>
                    <div>
                        <label for="newPassword">新密码：</label>
                        <input type="password" name="newPassword" id="newPassword" required/>
                        <span >*请输入新密码</span>
                    </div>
                    <div>
                        <label for="reNewPassword">确认新密码：</label>
                        <input type="password" name="reNewPassword" id="reNewPassword" required/>
                        <span >*请输入新确认密码，保证和新密码一致</span>
                    </div>
                    <div class="providerAddBtn">
                        <!--<a href="#">保存</a>-->
                        <input type="submit" value="保存"/>
                    </div>
                </form>
            </div>
        </div>
    </section>
    <footer class="footer">
        版权归北大青鸟
    </footer>

<script src="/js/time.js"></script>
<script src="/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript">
    $(function () {
        //用来判断旧密码是否正确
        var flag=true;

        //验证旧密码,获取旧密码文本框的焦点
        $("#oldPassword").blur(function () {
            //获取旧密码的值
            var oldPass=$(this).val();
            $.ajax({
                url:"/user/checkPassword",
                data:{"oldPass":oldPass},

                type:"POST",
                success:function (result) {
                    if(result=="success"){
                        $("#checkPassWordResult").text("*原密码正确~");
                        flag=true;
                    }else{
                        $("#checkPassWordResult").text("*原密码错误~");
                        flag=false;
                    }
                }
            });

            /**
             * 表单提交验证
             */
            $("#myForm").submit(function () {
               //验证旧密码是否正确
                if(flag==false){
                    alert('旧密码不正确，请验证后提交~');
                    return false;
                }else if($("#newPassword").val()!=$("#reNewPassword").val()){
                    alert('新密码和确认密码不正确，请校验后重试~');
                    return false;
                }
            });
        });
    });
</script>
</body>
</html>