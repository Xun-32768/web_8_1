<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Beans.Student" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>数据删除</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/change.css">
    <script src="${pageContext.request.contextPath}/JS/script.js"></script>
</head>
<body>
<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Delete"/>
    </jsp:include>

    <div class="content">
        <h1>学生信息删除</h1>

        <%
            String msg = (String) session.getAttribute("msg");
            if (msg != null) {
        %>
        <p style="color: red;"><%= msg %>
        </p>
        <%
                session.removeAttribute("msg");
            }
        %>

        <table>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>体重</th>
                <th>身高</th>
                <th>操作</th>
            </tr>
            <%

                    List<Student> students = (List<Student>) request.getAttribute("students");
                    if(students !=null&& !students.isEmpty())
                    {
                        for(Student s:students) {
            %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getSex() %></td>

                <td><%= s.getAge() %></td>
                <td><%= s.getWeight() %></td>
                <td><%= s.getHeight() %></td>
                <td><a href="${pageContext.request.contextPath}/DeleteServlet?delete=<%= s.getId() %>"
                       onclick="return confirm('确定要删除该学生信息吗？');">删除</a></td>
            </tr>
            <%
                    }
                }
                    else {
            %>
            <tr><td colspan="7">暂无学生信息</td></tr>
            <%
                }
            %>
        </table>

    </div>
</div>


</body>
</html>