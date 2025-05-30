
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>功能菜单</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/change.css">
    <script src="${pageContext.request.contextPath}/JS/script.js"></script>
</head>
<body>
<%
    String current = request.getParameter("current");
%>
    <div class="menu">
        <ul>
            <li><a href="${pageContext.request.contextPath}/Change/change_pwd.jsp" class=<%="change_pwd".equals(current)?"active":""%>>密码修改</a></li>
            <li><a onclick="showSubMenu(this)">数据操作</a></li>
            <ul id="subMenu" style="display: block;">
                <li><a href="${pageContext.request.contextPath}/AddServlet" class="<%= "Add".equals(current) ? "active" : "" %>">数据添加</a></li>
                <li><a href="${pageContext.request.contextPath}/DeleteServlet" class="<%= "Delete".equals(current) ? "active" : "" %>">数据删除</a></li>
                <li><a href="${pageContext.request.contextPath}/SelectServlet" class="<%= "Select".equals(current) ? "active" : "" %>">数据查询</a></li>
                <li><a href="${pageContext.request.contextPath}/ChangeServlet" class="<%= "Change".equals(current) ? "active" : "" %>">数据修改</a></li>
            </ul>
            <li><a href="${pageContext.request.contextPath}/Enter/login.jsp">退出系统</a></li>
        </ul>
    </div>

</body>
</html>
