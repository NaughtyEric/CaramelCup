<%--
  Created by IntelliJ IDEA.
  User: trioxwater
  Date: 2024/1/8
  Time: 21:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>焦糖杯-焦糖杯会员注册</title>
</head>
<body>
<h2>User Registration</h2>
<form action="RegisterServlet" method="post">
	<label for="username">用户名:</label>
	<input type="text" id="username" name="username" required><br>
	
	<label for="password">密码:</label>
	<input type="password" id="password" name="password" required><br>
	
	<label for="qq">QQ号:</label>
	<input type="text" id="qq" name="qq" required><br>
	
	<label for="nickname">昵称:</label>
	<input type="text" id="nickname" name="nickname" required><br>
	<!-- 长度不超过10个字符，如超出，注册按钮不会提交 -->
	<button type="submit">注册</button>
	
</form>

</body>
</html>
