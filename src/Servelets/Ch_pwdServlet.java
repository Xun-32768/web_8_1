package Servelets;

import Beans.User;
import Dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/Ch_pwdServlet")
public class Ch_pwdServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String oldPassword = request.getParameter("old_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        String username = (String) session.getAttribute("username");
        String usertype = (String) session.getAttribute("usertype");
        if (username == null || usertype == null) {
            session.setAttribute("msg", "用户未登录");
            response.sendRedirect("Change/change_pwd.jsp");
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("msg", "新密码和确认密码不一致");
            response.sendRedirect("Change/change_pwd.jsp");
            return;
        }

        try {
            User oldUser = new User(username, oldPassword, usertype);
            User newUser = new User(username, newPassword, usertype);
            UserDao dao = new UserDao();

            boolean isCorrect = dao.checkPassword(oldUser);
            if (isCorrect) {
                boolean updated = dao.updatePassword(newUser);
                session.setAttribute("msg", updated ? "密码修改成功" : "密码修改失败");
            } else {
                session.setAttribute("msg", "原密码不正确");
            }

        } catch (Exception e) {
            session.setAttribute("msg", "密码修改失败：" + e.getMessage());
        }

        response.sendRedirect("Change/change_pwd.jsp");
    }

}
