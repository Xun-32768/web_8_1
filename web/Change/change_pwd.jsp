<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%
    String username = (String) session.getAttribute("username");
    String usertype = (String) session.getAttribute("usertype");
    if (username == null || usertype == null) {
        response.sendRedirect("../Enter/login.jsp");
        return;
    }
%>
<html>
<head>
    <title>密码修改</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>
</head>
<body>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            String oldPassword = request.getParameter("old_password");
            String newPassword = request.getParameter("new_password");
            String confirmPassword = request.getParameter("confirm_password");

            if (!newPassword.equals(confirmPassword)) {
                session.setAttribute("msg", "新密码和确认密码不一致");
                response.sendRedirect("change_pwd.jsp");
                return;
            }

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
            String user="root";
            String password="060216";
            Connection conn= DriverManager.getConnection(url,user,password);

            // 验证旧密码
            String checkSql = "SELECT password FROM users WHERE username=? AND password=?";
            PreparedStatement checkPst = conn.prepareStatement(checkSql);
            checkPst.setString(1, username);
            checkPst.setString(2, oldPassword);
            ResultSet rs = checkPst.executeQuery();

            if (!rs.next()) {
                session.setAttribute("msg", "原密码不正确");
                rs.close();
                checkPst.close();
                conn.close();
                response.sendRedirect("change_pwd.jsp");
                return;
            }

            rs.close();
            checkPst.close();

            // 更新密码
            String updateSql = "UPDATE users SET password=? WHERE username=?";
            PreparedStatement updatePst = conn.prepareStatement(updateSql);
            updatePst.setString(1, newPassword);
            updatePst.setString(2, username);
            updatePst.executeUpdate();

            session.setAttribute("msg", "密码修改成功");

            updatePst.close();
            conn.close();
        } catch (Exception e) {
            session.setAttribute("msg", "密码修改失败：" + e.getMessage());
        }
        response.sendRedirect("change_pwd.jsp");
        return;
    }
%>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="change_pwd" />
    </jsp:include>

    <div class="content">

        <form class="place" method="post" action="change_pwd.jsp">
            <h1>密码修改</h1>

            <label class="form-label">原密码</label>
            <input type="password" name="old_password" required>
            <br>

            <label class="form-label">新密码</label>
            <input type="password" name="new_password" required>
            <br>

            <label class="form-label">确认密码</label>
            <input type="password" name="confirm_password" required>
            <br>

            <div class="button-container">
                <button type="submit">提交</button>
                <button type="reset">取消</button>
            </div>
        </form>
        <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
        <p style="color: red;"><%= msg %></p>
        <%
                session.removeAttribute("msg");
            }
        %>
    </div>
</div>


</body>
</html>