package Servelets;

import Beans.User;
import Dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");
        HttpSession session = request.getSession();
        try {
            if (username.isEmpty() || password.isEmpty()) {
                throw new Exception("用户名或密码不能为空");
            }
            User user = new User(username, password, usertype);
            UserDao dao = new UserDao();
            dao.register(user);
            session.setAttribute("msg", "注册成功，请返回登录页面。");
        } catch (Exception e) {
            session.setAttribute("msg", "注册失败");
        }
        response.sendRedirect("Enter/register.jsp");
    }
}
