<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="Beans.Student" %>
<%@ page import="Dao.StudentDao" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
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
    <title>数据添加</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>
</head>
<body>
<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int  id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        int age = Integer.parseInt(request.getParameter("age"));
        double weight = Double.parseDouble(request.getParameter("weight"));
        double height = Double.parseDouble(request.getParameter("height"));

        try{
            Student student=new Student(id,name,sex,age,weight,height);
            StudentDao dao=new StudentDao();
            dao.add(student);

            session.setAttribute("msg", "提交成功");
        } catch (Exception e) {
            session.setAttribute("msg", "提交失败 "+e.getMessage());
        }
        response.sendRedirect("Add.jsp");
        return;
    }
%>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Add" />
    </jsp:include>
    <div class="content">
        <h1>学生信息添加</h1>
        <form class="place" method="post" action="Add.jsp">

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
                StudentDao dao=new StudentDao();
                List<Student>students=dao.getAllStudent();

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
