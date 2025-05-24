package Dao;

import Beans.JdbcUtil;
import Beans.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.*;
public class UserDao {
    public void register(User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps= null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "insert into users values(?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getUsertype());
            ps.executeUpdate();
            System.out.println("注册请求：" + user.getUsername() +
                    " / " + user.getPassword() + " / " + user.getUsertype());
        }catch (Exception e) {
            e.printStackTrace();
            throw new Exception("该用户名已存在", e);
        }finally{
            JdbcUtil.free(null, ps, conn);

        }
    }

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

    public boolean checkPassword(User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try{
            conn = JdbcUtil.getConnection();
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            rs = ps.executeQuery();
            return rs.next();
        }catch(Exception e){
            e.printStackTrace();
            throw new Exception("原密码错误 "+e);
        }finally {
            JdbcUtil.free(rs, ps, conn);
        }
    }
    public boolean updatePassword(User user) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        int result = 0;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "UPDATE users SET password=? WHERE username=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, user.getPassword());
            ps.setString(2, user.getUsername());
            result = ps.executeUpdate();
        }catch(Exception e){
            e.printStackTrace();
        }finally {
            JdbcUtil.free(null, ps, conn);
        }
        return result > 0;
    }
}
