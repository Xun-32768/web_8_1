
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>登录</title>
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

            String sql="SELECT * FROM users WHERE username=? AND password=? AND usertype=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, uname);
            pst.setString(2, pwd);
            pst.setString(3, utype);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                session.setAttribute("username", uname);
                session.setAttribute("password", pwd);
                session.setAttribute("usertype", utype);
                response.sendRedirect("../Change/welcome.jsp");
            } else {
                msg = "登录失败，用户名或密码或用户类型错误";
            }
            rs.close();
            pst.close();
            conn.close();
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
