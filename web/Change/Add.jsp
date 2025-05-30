<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="Beans.Student" %>
<%@ page import="Dao.StudentDao" %>
<%@ page import="java.util.List" %>

<html>
<head>
    <title>数据添加</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/change.css">
    <script src="${pageContext.request.contextPath}/JS/script.js"></script>
</head>
<body>


<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Add" />
    </jsp:include>
    <div class="content">
        <h1>学生信息添加</h1>
        <form class="place" method="post" action="AddServlet">

            <label class="form-label">学号</label>
            <input type="text" name="id" >
            <br>

            <label class="form-label">姓名</label>
            <input type="text"  name="name">
            <br>

            <label class="form-label">性别 </label>
            <input type="text" name="sex">
            <br>

            <label class="form-label">年龄 </label>
            <input type="text" name="age">
            <br>

            <label class="form-label">体重 </label>
            <input type="text" name="weight">
            <br>

            <label class="form-label">身高 </label>
            <input type="text" name="height">
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
                try{
                    List<Student> students = (List<Student>) request.getAttribute("students");
                    for(Student s:students) {
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
                }catch (Exception e) {
                    out.println("<tr><td colspan='6'>数据加载失败</td></tr>");
                }
            %>
        </table>
    </div>
</div>


</body>
</html>
