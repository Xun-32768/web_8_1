
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Beans.User" %>
<%@ page import="Dao.UserDao" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="../CSS/enter.css">
</head>
<body>
<%
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");

        try {
            if(username.isEmpty() || password.isEmpty())
            {
                throw new Exception("用户名或密码不能为空");
            }
            User user = new User(username, password, usertype);
            UserDao dao = new UserDao();
            dao.register(user);
            msg = "注册成功，请返回登录页面。";

        } catch (Exception e) {
            msg = "注册失败，"+e.getMessage();
        }
    }
%>
<form class="place" method="post" action="register.jsp">
    <h1>注册</h1>
    <label class="form-label">用户名:</label>
    <input type="text" id="username" name="username" >
    <br>
    <label class="form-label">密码： </label>
    <input type="password" id="password" name="password">

    <label class="form-label">用户类型： </label>
    <select name="usertype" id="usertype">
        <option value="管理员" name="usertype">管理员</option>
        <option value="用户" name="usertype">用户</option>
    </select>

    <div class="button-container">
        <button type="submit">注册</button>
        <button type="reset">取消 </button>
        <a href="login.jsp">登录</a>
    </div>
    <p style="color: red;"><%= msg %></p>

</form>

</body>
</html>

