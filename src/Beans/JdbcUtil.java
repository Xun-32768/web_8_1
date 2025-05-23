package Beans;
import java.sql.*;
import java.util.Properties;
public class JdbcUtil {
    private static String driver;
    private static String url;
    private static String user;
    private static String password;
    static {
        try {
            Properties pr=new Properties();
            pr.load(JdbcUtil.class.getClassLoader().getResourceAsStream("db.properties"));
            driver = pr.getProperty("driver");
            url = pr.getProperty("url");
            user = pr.getProperty("username");
            password = pr.getProperty("password");
            Class.forName(driver);
        } catch (Exception e) {
            System.err.println("数据库连接错误: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static Connection getConnection()throws SQLException{
        return DriverManager.getConnection(url,user,password);
    }
    public static void free(ResultSet rs,Statement st,Connection conn)throws Exception{
        if(rs!=null){rs.close();}
        if(st!=null){st.close();}
        if(conn!=null){conn.close();}
    }
}
