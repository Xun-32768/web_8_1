package Servelets;

import Beans.Student;
import Dao.StudentDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/SelectServlet")
public class SelectServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String usertype = (String) session.getAttribute("usertype");
        if (username == null || usertype == null) {
            response.sendRedirect("Enter/login.jsp");
            return;
        }
        try {
            StudentDao dao = new StudentDao();
            List<Student> students = dao.getAllStudent();
            request.setAttribute("students", students);
        } catch (Exception e) {
            request.setAttribute("msg", "数据加载失败: " + e.getMessage());
        }
        request.getRequestDispatcher("Change/Select.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String studentIdStr = request.getParameter("studentId");
        String studentName = request.getParameter("studentName");
        String weightMinStr = request.getParameter("weightMin");
        String weightMaxStr = request.getParameter("weightMax");

        Integer studentId = null;
        Double weightMin = null;
        Double weightMax = null;
        try {
            if (studentIdStr != null && !studentIdStr.trim().isEmpty()) {
                studentId = Integer.parseInt(studentIdStr.trim());
            }
            if (weightMinStr != null && !weightMinStr.trim().isEmpty()) {
                weightMin = Double.parseDouble(weightMinStr.trim());
            }
            if (weightMaxStr != null && !weightMaxStr.trim().isEmpty()) {
                weightMax = Double.parseDouble(weightMaxStr.trim());
            }

            StudentDao dao = new StudentDao();
            List<Student> students = dao.findStudents(studentId, studentName, weightMin, weightMax);

            request.setAttribute("students", students);
        } catch (Exception e) {
            request.setAttribute("msg", "查询失败：" + e.getMessage());
        }

        request.setAttribute("searched", true);
        request.setAttribute("studentId", studentIdStr);
        request.setAttribute("studentName", studentName);
        request.setAttribute("weightMin", weightMinStr);
        request.setAttribute("weightMax", weightMaxStr);
        request.getRequestDispatcher("Change/Select.jsp").forward(request, response);
    }
}

