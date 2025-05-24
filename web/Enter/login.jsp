
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="../CSS/enter.css">
</head>
<body>
<form class="place" method="post" action="../LoginServlet">
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

    <%
        String msg = (String) session.getAttribute("msg");
        if (msg != null) {
    %>
    <p style="color: red;"><%= msg %></p>
    <%
            session.removeAttribute("msg");
        }
    %>
</form>

</body>
</html>
