<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
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

            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
            String user="root";
            String password="060216";
            Connection conn= DriverManager.getConnection(url,user,password);

            String sql="UPDATE student SET name=?, sex=?, age=?, weight=?, height=? WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, sex);
            pst.setInt(3, age);
            pst.setDouble(4, weight);
            pst.setDouble(5, height);
            pst.setInt(6, id);

            int result = pst.executeUpdate();

            if (result > 0) {
                session.setAttribute("msg", "修改成功");
            } else {
                session.setAttribute("msg", "修改失败，该学生不存在");
            }

            pst.close();
            conn.close();
        } catch (Exception e) {
            session.setAttribute("msg", "修改失败");
        }
        response.sendRedirect("Change.jsp");
        return;
    }

    // 查询要修改的学生信息
    String idToEdit = request.getParameter("edit");
    String studentName = "";
    String studentSex = "";
    String studentAge = "";
    String studentWeight = "";
    String studentHeight = "";

    if (idToEdit != null && !idToEdit.isEmpty()) {
        try {
            int id = Integer.parseInt(idToEdit);
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
            String user="root";
            String password="060216";
            Connection conn= DriverManager.getConnection(url,user,password);

            String sql="SELECT * FROM student WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                studentName = rs.getString("name");
                studentSex = rs.getString("sex");
                studentAge = String.valueOf(rs.getInt("age"));
                studentWeight = String.valueOf(rs.getDouble("weight"));
                studentHeight = String.valueOf(rs.getDouble("height"));
            }

            rs.close();
            pst.close();
            conn.close();
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
            <input type="text" name="id" value="<%= idToEdit != null ? idToEdit : "" %>" <%= idToEdit != null ? "readonly" : "" %>>
            <br>

            <label class="form-label">姓名</label>
            <input type="text" name="name" value="<%= studentName %>">
            <br>

            <label class="form-label">性别 </label>
            <input type="text" name="sex" value="<%= studentSex %>">
            <br>

            <label class="form-label">年龄 </label>
            <input type="text" name="age" value="<%= studentAge %>">
            <br>

            <label class="form-label">体重 </label>
            <input type="text" name="weight" value="<%= studentWeight %>">
            <br>

            <label class="form-label">身高 </label>
            <input type="text" name="height" value="<%= studentHeight %>">
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
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
                    String user = "root";
                    String password = "060216";
                    Connection conn = DriverManager.getConnection(url, user, password);
                    String sql = "SELECT * FROM student";
                    PreparedStatement pst = conn.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery();

                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String name = rs.getString("name");
                        String sex = rs.getString("sex");
                        int age = rs.getInt("age");
                        double weight = rs.getDouble("weight");
                        double height = rs.getDouble("height");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= name %></td>
                <td><%= sex %></td>
                <td><%= age %></td>
                <td><%= weight %></td>
                <td><%= height %></td>
                <td><a href="Change.jsp?edit=<%= id %>">修改</a></td>
            </tr>
            <%
                    }
                    rs.close();
                    pst.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>数据加载失败</tr></td>" );
                }
            %>
        </table>
    </div>
</div>


</body>
</html>