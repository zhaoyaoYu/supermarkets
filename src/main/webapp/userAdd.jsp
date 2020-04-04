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
            <span>用户管理页面 >> 用户添加页面</span>
        </div>
        <div class="providerAdd">
            <form action="/user/addUser" method="post" id="myForm">
                <!--div的class 为error是验证错误，ok是验证成功-->
                <div class="usercode">
                    <label for="usercode">用户编码：</label>
                    <input type="text" name="usercode" id="usercode"/>
                    <span id="message">*请输入用户编码，且不能重复</span>
                </div>
                <div>
                    <label for="username">用户名称：</label>
                    <input type="text" name="username" id="username"/>
                    <span >*请输入用户名称</span>
                </div>
                <div>
                    <label for="userpassword">用户密码：</label>
                    <input type="password" name="userpassword" id="userpassword"/>
                    <span>*密码长度必须大于6位小于20位</span>

                </div>
                <div>
                    <label for="userRemi">确认密码：</label>
                    <input type="password" name="userRemi" id="userRemi"/>
                    <span>*请输入确认密码</span>
                </div>
                <div>
                    <label >用户性别：</label>

                    <select name="gender">
                        <option value="1">男</option>
                        <option value="2">女</option>
                    </select>
                    <span></span>
                </div>
                <div>
                    <label for="birthdaydate">出生日期：</label>
                    <input type="date" name="birthdaydate" id="birthdaydate"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="phone">用户电话：</label>
                    <input type="text" name="phone" id="phone"/>
                    <span >*</span>
                </div>
                <div>
                    <label for="address">用户地址：</label>
                    <input type="text" name="address" id="address"/>
                </div>
                <div>
                    <label >用户类别：</label>
                    <input type="radio" name="userrole" value="1"/>管理员
                    <input type="radio" name="userrole" value="2"/>经理
                    <input type="radio" name="userrole" value="3" checked/>普通用户

                </div>
                <div class="providerAddBtn">
                    <!--<a href="#">保存</a>-->
                    <!--<a href="userList.html">返回</a>-->
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
        $("#usercode").blur(function () {
            $.ajax({
                url:"/user/checkUserCode",
                data:{"usercode":$(this).val()},
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
            }else if($("#usercode").val()==""||$("#usercode").val()==null){
                alert('用户名不能为空！');
                return flag;
            }else if($("#userpassword").val()==""||$("#userpassword").val()==null){
                alert('密码不能为空！');
                return false;
            }else if($("#userRemi").val()==""||$("#userRemi").val()==null){
                alert('确认密码不能为空！');
                return false;
            }else if($("#userpassword").val()!=$("#userRemi").val()){
                alert('两次密码不一致！');
                return false;
            }else if($("#birthdaydate").val()==""||$("#birthdaydate").val()==null){
                alert('出生日期不能为空！');
                return false;
            }else if($("#phone").val()==""||$("#phone").val()==null){
                alert('电话不能为空！');
                return false;
            }
        })


    })
</script>
</body>
</html>