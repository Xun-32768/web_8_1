package Dao;

import Beans.JdbcUtil;
import Beans.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
public class UserDao {
//    public void add(User user) throws Exception {
//        boolean result = false;
//        Connection conn = null;
//        PreparedStatement ps= null;
//        conn = JdbcUtil.getConnection();
//        String sql="insert into users values(?,?,?)";
//        ps = conn.prepareStatement(sql);
//        ps.setString(1, user.getUsername());
//        ps.setString(2, user.getPassword());
//        ps.setString(3, user.getUsertype());
//        ps.executeUpdate();
//        JdbcUtil.free(null, ps, conn);
//    }
    public boolean login(User user) throws Exception {
        boolean result = false;
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
    try {
        conn = JdbcUtil.getConnection();
        String sql = "SELECT * FROM users WHERE username=? AND password=? AND usertype=?";
        ps = conn.prepareStatement(sql);
        ps.setString(1, user.getUsername());
        ps.setString(2, user.getPassword());
        ps.setString(3, user.getUsertype());

        rs = ps.executeQuery();
        result = rs.next();
        System.out.println("登录请求：" + user.getUsername() +
                " / " + user.getPassword() + " / " + user.getUsertype());
    }catch(Exception e){
        System.err.println("UserDao错误: " + e.getMessage());
        e.printStackTrace();
    }finally {
        JdbcUtil.free(rs, ps, conn);
    }
        return result;
    }
}
