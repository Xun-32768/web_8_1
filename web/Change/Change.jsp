<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Beans.Student" %>
<%@ page import="java.util.List" %>
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
    <title>数据修改</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>
</head>
<body>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String sex = request.getParameter("sex");
            int age = Integer.parseInt(request.getParameter("age"));
            double weight = Double.parseDouble(request.getParameter("weight"));
            double height = Double.parseDouble(request.getParameter("height"));

            Student student =new Student(id,name,sex,age,weight,height);
            StudentDao dao = new StudentDao();
            int result=dao.Change(student);
            if (result > 0) {
                session.setAttribute("msg", "修改成功");
            } else {
                session.setAttribute("msg", "修改失败，该学生不存在");
            }
        } catch (Exception e) {
            session.setAttribute("msg", "修改失败");
        }
        response.sendRedirect("Change.jsp");
        return;
    }

    // 查询要修改的学生信息
    String idToEdit = request.getParameter("edit");
    Student student =null;
    if (idToEdit != null && !idToEdit.isEmpty()) {

        try {
            int id = Integer.parseInt(idToEdit);
            StudentDao dao = new StudentDao();
            student = dao.getById(id);
        } catch (Exception e) {
            session.setAttribute("msg", "获取学生信息失败");
        }
    }
%>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Change" />
    </jsp:include>

    <div class="content">
        <h1>学生信息修改</h1>
        <form class="place" method="post" action="Change.jsp">
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
            <input type="text" name="weight"value="<%= student != null ? student.getWeight() : "" %>">
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
                <td><a href="Change.jsp?edit=<%= s.getId() %>">修改</a></td>
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