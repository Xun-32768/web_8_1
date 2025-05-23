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
            Class.forName("com.mysql.cj.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
            String user = "root";
            String password = "060216";
            Connection conn = DriverManager.getConnection(url, user, password);

            String sql = "DELETE FROM student WHERE id=?";
            PreparedStatement pst = conn.prepareStatement(sql);
            pst.setInt(1, id);

            int result = pst.executeUpdate();

            if (result > 0) {
                session.setAttribute("msg", "删除成功");
            } else {
                session.setAttribute("msg", "删除失败，该学生不存在");
            }

            pst.close();
            conn.close();
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
                <td><%= id %>
                </td>
                <td><%= name %>
                </td>
                <td><%= sex %>
                </td>
                <td><%= age %>
                </td>
                <td><%= weight %>
                </td>
                <td><%= height %>
                </td>
                <td>
                    <a href="Delete.jsp?delete=<%= id %>" onclick="return confirm('确定要删除该学生信息吗？');">删除</a>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    pst.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7'>数据加载失败</td></tr>");
                }
            %>
        </table>
    </div>
</div>


</body>
</html>