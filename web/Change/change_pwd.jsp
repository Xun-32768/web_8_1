<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Dao.UserDao" %>
<%@ page import="Beans.User" %>

<html>
<head>
    <title>密码修改</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/change.css">
    <script src="${pageContext.request.contextPath}/JS/script.js"></script>
</head>
<body>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="change_pwd" />
    </jsp:include>

    <div class="content">

        <form class="place" method="post" action="../Ch_pwdServlet">
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