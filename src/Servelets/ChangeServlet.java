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

@WebServlet("/ChangeServlet")
public class ChangeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idToEdit = request.getParameter("edit");
        try {
            StudentDao dao = new StudentDao();
            if (idToEdit != null && !idToEdit.isEmpty()) {
                int id = Integer.parseInt(idToEdit);
                Student student = dao.getById(id);
                request.setAttribute("editStudent", student);
            }
            List<Student> students = dao.getAllStudent();
            request.setAttribute("students", students);
        } catch (Exception e) {
            request.setAttribute("msg", "加载数据失败: " + e.getMessage());
        }
        request.getRequestDispatcher("Change/Change.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String sex = request.getParameter("sex");
            int age = Integer.parseInt(request.getParameter("age"));
            double weight = Double.parseDouble(request.getParameter("weight"));
            double height = Double.parseDouble(request.getParameter("height"));

            Student student = new Student(id, name, sex, age, weight, height);
            StudentDao dao = new StudentDao();
            int result = dao.Change(student);

            if (result > 0) {
                request.setAttribute("msg", "修改成功");
            } else {
                request.setAttribute("msg", "修改失败，该学生不存在");
            }
        } catch (Exception e) {
            request.setAttribute("msg", "修改失败: " + e.getMessage());
        }
        doGet(request, response);
    }
}

