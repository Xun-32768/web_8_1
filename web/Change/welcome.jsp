<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String username = (String) session.getAttribute("username");
    String usertype = (String) session.getAttribute("usertype");
    if (username == null || usertype == null) {
        response.sendRedirect("Enter/login.jsp");
        return;
    }
%>
<html>
<head>
    <title>欢迎页面</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>
</head>
<body>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="welcome" />
    </jsp:include>

    <div class="content">
        <h1>欢迎，<%= username %>！</h1>
        <p>您当前的用户类型是：<%= usertype %>
        </p>
    </div>
</div>

</body>
</html>
