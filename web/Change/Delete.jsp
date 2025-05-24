<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Dao.StudentDao" %>
<%@ page import="Beans.Student" %>
<%@ page import="java.util.List" %>
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
    <title>数据删除</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>

</head>
<body>
<%
    // 处理删除请求
    String deleteId = request.getParameter("delete");
    if (deleteId != null && !deleteId.isEmpty()) {
        try {
            int id = Integer.parseInt(deleteId);
            StudentDao dao=new StudentDao();
            boolean result=dao.DeleteById(id);

            if (result) {
                session.setAttribute("msg", "删除成功");
            } else {
                session.setAttribute("msg", "删除失败，该学生不存在");
            }

        } catch (Exception e) {
            session.setAttribute("msg", "删除失败：" + e.getMessage());
        }
        response.sendRedirect("Delete.jsp");
        return;
    }
%>

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
                try{
                    StudentDao dao=new StudentDao();
                    List<Student> students=dao.getAllStudent();

                    for(Student s:students) {
            %>
            <tr>
                <td><%= s.getId() %></td>
                <td><%= s.getName() %></td>
                <td><%= s.getSex() %></td>
                <td><%= s.getAge() %></td>
                <td><%= s.getWeight() %></td>
                <td><%= s.getHeight() %></td>
                <td><a href="Delete.jsp?delete=<%= s.getId() %>"
                       onclick="return confirm('确定要删除该学生信息吗？');">删除</a></td>
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