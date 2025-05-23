
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Beans.User" %>
<%@ page import="Dao.UserDao" %>
<html>
<head>
    <title>登录</title>
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
            User user = new User(username, password, usertype);
            UserDao dao = new UserDao();
            if (dao.login(user)) {
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                session.setAttribute("usertype", usertype);
                response.sendRedirect("../Change/welcome.jsp");
                return;
            } else {
                msg = "登录失败，用户名或密码或用户类型错误";
            }
        } catch (Exception e) {
            msg = "登录失败，服务器错误" ;
        }
    }
%>

<form class="place" method="post" action="login.jsp">
    <h1>登录</h1>
    <label class="form-label">用户名:</label>
    <input type="text" id="username" name="username">
    <br>

    <label class="form-label">密码： </label>
    <input type="password" id="password" name="password">
    <br>

    <label class="form-label">用户类型： </label>
    <select name="usertype" id="usertype">
        <option value="管理员" name="usertype">管理员</option>
        <option value="用户" name="usertype">用户</option>
    </select>
    <br>

    <div class="button-container">
        <button type="submit">登录</button>
        <button type="reset">取消</button>
        <a href="register.jsp">注册</a>
    </div>

    <p style="color: red;"><%= msg %></p>
</form>

</body>
</html>
