<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
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
    <title>数据查询</title>
    <link rel="stylesheet" href="../CSS/change.css">
    <script src="../JS/script.js"></script>

</head>
<body>
<%
    String studentId = request.getParameter("studentId");
    String studentName = request.getParameter("studentName");
    String weightMin = request.getParameter("weightMin");
    String weightMax = request.getParameter("weightMax");
    boolean isSearched = request.getMethod().equalsIgnoreCase("POST");
%>

<div class="container">
    <jsp:include page="menu.jsp">
        <jsp:param name="current" value="Select" />
    </jsp:include>
    <div class="content">
        <form class="place" method="post" action="Select.jsp">
            <h1>学生信息查询</h1>

            <label class="form-label">学号</label>
            <input type="text" name="studentId" value="<%= studentId != null ? studentId : "" %>">
            <br>

            <label class="form-label">姓名</label>
            <input type="text" name="studentName" value="<%= studentName != null ? studentName : "" %>">
            <br>

            <label class="form-label">体重</label>
            <input type="text" name="weightMin" value="<%= weightMin != null ? weightMin : "" %>">
            -
            <input type="text" name="weightMax" value="<%= weightMax != null ? weightMax : "" %>">
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
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/db02?&useSSL=false&serverTimezone=UTC";
                    String user = "root";
                    String password = "060216";
                    Connection conn = DriverManager.getConnection(url, user, password);

                    StringBuilder sqlBuilder = new StringBuilder("SELECT * FROM student WHERE 1=1");
                    // 构建参数列表
                    List<Object> params = new ArrayList<>();

                    // 添加学号条件
                    if (studentId != null && !studentId.isEmpty()) {
                        sqlBuilder.append(" AND id = ?");
                        params.add(Integer.parseInt(studentId));
                    }

                    // 添加姓名条件
                    if (studentName != null && !studentName.isEmpty()) {
                        sqlBuilder.append(" AND name LIKE ?");
                        params.add("%" + studentName + "%");
                    }

                    // 添加体重最小值条件
                    if (weightMin != null && !weightMin.isEmpty()) {
                        sqlBuilder.append(" AND weight >= ?");
                        params.add(Double.parseDouble(weightMin));
                    }

                    // 添加体重最大值条件
                    if (weightMax != null && !weightMax.isEmpty()) {
                        sqlBuilder.append(" AND weight <= ?");
                        params.add(Double.parseDouble(weightMax));
                    }

                    PreparedStatement pst = conn.prepareStatement(sqlBuilder.toString());

                    // 设置参数值
                    for (int i = 0; i < params.size(); i++) {
                        Object param = params.get(i);
                        if (param instanceof Integer) {
                            pst.setInt(i + 1, (Integer) param);
                        }
                        else if (param instanceof Double) {
                            pst.setDouble(i + 1, (Double) param);
                        }
                        else {
                            pst.setString(i + 1, (String) param);
                        }
                    }

                    ResultSet rs = pst.executeQuery();
                    boolean hasResults = false;

                    while (rs.next()) {
                        hasResults = true;
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
            </tr>
            <%
                    }

                    if (!hasResults && isSearched) {
                        out.println("<tr><td colspan='6'>无匹配的学生</td></tr>");
                    } else if (!hasResults) {
                        out.println("<tr><td colspan='6'>暂无学生数据</td></tr>");
                    }

                    rs.close();
                    pst.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='6'>查询失败</td></tr>");
                }
            %>
        </table>
    </div>
</div>


</body>
</html>