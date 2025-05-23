
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>注册页面</title>
    <link rel="stylesheet" href="../CSS/enter.css">
</head>
<body>
<%
    String msg = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String uname = request.getParameter("username");
        String pwd = request.getParameter("password");
        String utype = request.getParameter("usertype");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
            String user="root";
            String password="060216";
            Connection conn=DriverManager.getConnection(url,user,password);

            String sql="INSERT INTO users(username, password, usertype) VALUES (?, ?, ?)";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, uname);
            pst.setString(2, pwd);
            pst.setString(3, utype);
            pst.executeUpdate();

            msg = "注册成功，请返回登录页面。";

            pst.close();
            conn.close();
        } catch (Exception e) {
            msg = "注册失败，该用户名已存在";
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

