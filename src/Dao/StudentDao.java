package Dao;

import Beans.JdbcUtil;
import Beans.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class StudentDao {
    public void add(Student student) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "INSERT INTO student VALUES (?,?,?,?,?,?)";
            ps = conn.prepareStatement(sql);
            ps.setInt(1, student.getId());
            ps.setString(2, student.getName());
            ps.setString(3, student.getSex());
            ps.setInt(4, student.getAge());
            ps.setDouble(5, student.getWeight());
            ps.setDouble(6, student.getHeight());
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
            throw new Exception("学号重复", e);
        } finally {
            JdbcUtil.free(null, ps, conn);

        }
    }
    public int Change(Student student) throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        int result=0;
        try {
            conn = JdbcUtil.getConnection();
            String sql = "UPDATE student SET name=?, sex=?, age=?, weight=?, height=? WHERE id=?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, student.getName());
            ps.setString(2, student.getSex());
            ps.setInt(3, student.getAge());
            ps.setDouble(4, student.getWeight());
            ps.setDouble(5, student.getHeight());
            ps.setInt(6, student.getId());
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
        return result;
    }
    public Student getById(int id)throws Exception{
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs=null;
        Student student=null;
        try{
            conn= JdbcUtil.getConnection();
            String sql = "select * from student where id=?";
            ps= conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs=ps.executeQuery();
            if(rs.next()){
                student=new Student();
                student.setId(rs.getInt("id"));
                student.setName(rs.getString("name"));
                student.setSex(rs.getString("sex"));
                student.setAge(rs.getInt("age"));
                student.setWeight(rs.getDouble("weight"));
                student.setHeight(rs.getDouble("height"));

            }
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            JdbcUtil.free(rs,ps,conn);
        }
        return student;
    }

    public List<Student> getAllStudent() throws Exception {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Student> list = new ArrayList<Student>();
        try {
            conn = JdbcUtil.getConnection();
            String sql = "SELECT * FROM student";
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Student s = new Student(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("sex"),
                        rs.getInt("age"),
                        rs.getDouble("weight"),
                        rs.getDouble("height")
                );
                list.add(s);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JdbcUtil.free(null, ps, conn);
        }
        return list;
    }


}
