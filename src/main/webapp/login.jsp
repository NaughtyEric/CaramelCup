<%--
  Created by IntelliJ IDEA.
  User: trioxwater
  Date: 2023/12/14
  Time: 19:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>登录-焦糖杯会员登录</title>
  <style>
    * {
      margin: auto;
      padding: 10px;
    }
    body {
      background-color: #eee;
    }
    .login-container {
      width: 400px;
      margin: 0 auto;
      padding: 20px;
      border: 1px solid #ccc;
      border-radius: 5px;
      background-color: #fff;
    }
    .login-container:hover {
      box-shadow: 0 0 5px #ccc;
    }
    .login-container h2 {
      text-align: center;
    }
    .login-container input {
      width: 80%;
      height: 30px;
      margin: 10px 0;
      padding: 0 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
    .login-container button {
      width: 25%;
      height: 30px;
      margin: 10px 0;
      padding: 0 5%;
      border: 1px solid #ccc;
      border-radius: 5px;
    }
  </style>
</head>
<body>

<div class="login-container" id="login-container" style="text-align: center">
  <h2>焦糖杯会员登录</h2>
  <form action="LoginServlet" method="post">
    <label for="username">用户名 </label>
    <input type="text" id="username" name="username" required>
    <br>
    <label for="password">密码</label>
    <input type="password" id="password" name="password" required>
    <br>
    <!-- 按钮居中等距 -->
    <%
      // url带参数error = 1 代表用户名或密码错，打印提示
        String error = request.getParameter("error");
        if (error != null && error.equals("1")) {
          out.print("<p style='text-align: center; color: red'>用户名或密码错误</p>");
        }
    %>
    <div style="text-align: center">
      <button type="submit" id="loginButton">登录</button>
	  <button type="reset" id="resetButton">重置</button>
    </div>
    
    <%
      String[] tips = {"登录即可参与或举办比赛", "请保护好您的账号", "请勿使用他人账号登录"};
      int index = (int) (Math.random() * tips.length);
      // out.print() 会将内容输出到页面上
      out.print("<p style='text-align: center'>" + tips[index] + "</p>");
    %>
  </form>
</div>

</body>
</html>

