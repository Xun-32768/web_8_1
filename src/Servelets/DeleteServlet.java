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

@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String usertype = (String) session.getAttribute("usertype");
        String deleteId = request.getParameter("delete");
        if (username == null || usertype == null) {
            response.sendRedirect("Enter/login.jsp");
            return;
        }
        if (deleteId != null && !deleteId.isEmpty()) {
            try {
                int id = Integer.parseInt(deleteId);
                StudentDao dao = new StudentDao();
                boolean result = dao.DeleteById(id);
                if (result) {
                    session.setAttribute("msg", "删除成功");
                } else {
                    session.setAttribute("msg", "删除失败，该学生不存在");
                }
            } catch (Exception e) {
                session.setAttribute("msg", "删除失败：" + e.getMessage());
            }
        }

        try {
            StudentDao dao = new StudentDao();
            List<Student> students = dao.getAllStudent();
            request.setAttribute("students", students);
        } catch (Exception e) {
            request.setAttribute("msg", "数据加载失败: " + e.getMessage());
        }
        request.getRequestDispatcher("Change/Delete.jsp").forward(request, response);
    }
}
