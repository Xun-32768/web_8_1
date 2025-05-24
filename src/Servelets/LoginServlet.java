package Servelets;

import Beans.User;
import Dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String usertype = request.getParameter("usertype");
        try{
            User user=new User(username,password,usertype);
            UserDao dao = new UserDao();

            if (dao.login(user)) {
                session.setAttribute("username", username);
                session.setAttribute("usertype", usertype);
                response.sendRedirect("Change/welcome.jsp");
            } else {
                session.setAttribute("msg", "登录失败，用户名或密码或用户类型错误");
                response.sendRedirect("Enter/login.jsp");
            }
        } catch (Exception e) {
                session.setAttribute("msg", "登录失败，服务器错误");
                response.sendRedirect("Enter/login.jsp");
        }
    }
}
