<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Beans.Student" %>
<%@ page import="Dao.StudentDao" %>
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
    <title>数据查询</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>

</head>
<body>
<%
    String studentIdStr = request.getParameter("studentId");
    String studentName = request.getParameter("studentName");
    String weightMinStr = request.getParameter("weightMin");
    String weightMaxStr = request.getParameter("weightMax");
    boolean isSearched = request.getMethod().equalsIgnoreCase("POST");
    Integer studentId = null;
    Double weightMin = null;
    Double weightMax = null;
    if (studentIdStr != null && !studentIdStr.trim().isEmpty()) {
        studentId = Integer.parseInt(studentIdStr.trim());
    }
    if (weightMinStr != null && !weightMinStr.trim().isEmpty()) {
        weightMin = Double.parseDouble(weightMinStr.trim());
    }
    if (weightMaxStr != null && !weightMaxStr.trim().isEmpty()) {
        weightMax = Double.parseDouble(weightMaxStr.trim());
    }
    List<Student> students = null;
    if (isSearched) {
        try {
            StudentDao dao = new StudentDao();
            students = dao.findStudents(studentId, studentName, weightMin, weightMax);
        } catch (Exception e) {
            out.println("<p>查询失败：" + e.getMessage() + "</p>");
        }
    }
%>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Select" />
    </jsp:include>
    <div class="content">
        <form class="place" method="post" action="Select.jsp">
            <h1>学生信息查询</h1>

            <label class="form-label">学号</label>
            <input type="text" name="studentId" value="<%= studentIdStr != null ? studentIdStr : "" %>">
            <br>

            <label class="form-label">姓名</label>
            <input type="text" name="studentName" value="<%= studentName != null ? studentName : "" %>">
            <br>

            <label class="form-label">体重</label>
            <input type="text" name="weightMin" value="<%= weightMinStr != null ? weightMinStr : "" %>">-
            <input type="text" name="weightMax" value="<%= weightMaxStr != null ? weightMaxStr: "" %>">
            <br>

            <div class="button-container">
                <button type="submit">查询</button>
                <button type="reset">取消</button>
            </div>
        </form>

        <table>
            <tr>
                <th>学号</th>
                <th>姓名</th>
                <th>性别</th>
                <th>年龄</th>
                <th>体重</th>
                <th>身高</th>
            </tr>
            <%
                if (students != null && !students.isEmpty()) {
                    for (Student s : students) {
            %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getSex() %></td>
                <td><%= s.getAge() %></td>
                <td><%= s.getWeight() %></td>
                <td><%= s.getHeight() %></td>
            </tr>
            <%
                }
            } else if (isSearched) {
            %>
            <tr><td colspan="6">无匹配的学生</td></tr>
            <%
            } else {
            %>
            <tr><td colspan="6">暂无学生数据</td></tr>
            <%
                }
            %>
        </table>
    </div>
</div>


</body>
</html>