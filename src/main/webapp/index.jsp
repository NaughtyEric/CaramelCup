<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.Cookie" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Optional" %>

<%
    // 获取所有的Cookie
    Cookie[] cookies = request.getCookies();
    
    // 删除过期的Cookie
    if (cookies != null) {
        Arrays.stream(cookies)
                .filter(cookie -> cookie.getMaxAge() <= 0)
                .forEach(cookie -> {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                });
    }
    
    // 打印所有的Cookie名称和过期时间
//    if (cookies != null) {
//        Arrays.stream(cookies)
//                .forEach(cookie -> {
//                    System.out.println(cookie.getName());
//                    System.out.println(cookie.getMaxAge());
//                });
//    }
    
    // 使用Java 8的Optional类来安全地获取Cookie值
    Optional<Cookie> usernameCookie = Optional.empty();
    if (cookies != null) {
        usernameCookie = Arrays.stream(cookies)
                .filter(cookie -> cookie.getName().equals("username"))
                .findFirst();
    }
    
    // 使用EL表达式显示用户名或登录按钮
    String username = usernameCookie.map(Cookie::getValue).orElse(null);
%>

<!DOCTYPE html>
<html>
    <head>
        <title>焦糖杯官方网站</title>
        <link rel="stylesheet" href="css/index.css">
    </head>
<body>

    <div class="header" id="home">
        <h1>焦糖杯官方网站</h1>
        <p>欢迎来到焦糖杯官方网站</p>
    </div>

    <div class="navbar">
        <a href="#home">Home</a>
        <a href="#introduction">Introduction</a>
        <a href="#contest">Contests</a>
        <a href="#about">About</a>
        <% if (username == null) { %>
            <button onclick="window.location.href='login.jsp'">登录</button>
            <button onclick="window.location.href='register.jsp'">注册</button>
        <% } else { %>
            <a style="float: right">
                欢迎您，<%= username %>
            </a>
            <script>
                function logout() {
                    console.log("logout");
                    document.cookie = "username=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;";
                    window.location.href = "index.jsp";
                }
            </script>
            <button onclick="logout()" style="float: right">
                登出
            </button>
        <% } %>
        
    </div>

    <div class="intro" id="introduction">
        <h2>焦糖杯</h2>
        <p>焦糖杯是一个汇集各种娱乐项目比赛的平台，欢迎各位玩家踊跃参与/举办！</p>
    </div>

    <div id="contest">

    </div>

    <div id="about">

    </div>
</body>
</html>