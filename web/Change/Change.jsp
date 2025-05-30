<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Beans.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="Dao.StudentDao" %>

<html>
<head>
    <title>数据修改</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/change.css">
    <script src="${pageContext.request.contextPath}/JS/script.js"></script>
</head>
<body>


<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Change"/>
    </jsp:include>

    <div class="content">
        <h1>学生信息修改</h1>
        <form class="place" method="post" action="ChangeServlet">
            <%
                Student student = (Student) request.getAttribute("editStudent");
            %>
            <label class="form-label">学号</label>
            <input type="text" name="id" value="<%= student != null ? student.getId() : "" %>" readonly>
            <br>

            <label class="form-label">姓名</label>
            <input type="text" name="name" value="<%= student != null ? student.getName() : "" %>">
            <br>

            <label class="form-label">性别 </label>
            <input type="text" name="sex" value="<%= student != null ? student.getSex() : "" %>">
            <br>

            <label class="form-label">年龄 </label>
            <input type="text" name="age" value="<%= student != null ? student.getAge() : "" %>">
            <br>

            <label class="form-label">体重 </label>
            <input type="text" name="weight" value="<%= student != null ? student.getWeight() : "" %>">
            <br>

            <label class="form-label">身高 </label>
            <input type="text" name="height" value="<%= student != null ? student.getHeight() : "" %>">
            <br>
            <div class="button-container">
                <button type="submit">更新</button>
                <button type="reset">取消</button>
            </div>
        </form>
        <%
            String msg = (String) request.getAttribute("msg");
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
                if (students != null) {
                    for (Student s : students) {
            %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getSex() %></td>
                <td><%= s.getAge() %></td>
                <td><%= s.getWeight() %></td>
                <td><%= s.getHeight() %></td>
                <td><a href="ChangeServlet?edit=<%= s.getId() %>">修改</a></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan='7'>暂无学生信息</td>
            </tr>
            <%
                }
            %>
        </table>

    </div>
</div>


</body>
</html>