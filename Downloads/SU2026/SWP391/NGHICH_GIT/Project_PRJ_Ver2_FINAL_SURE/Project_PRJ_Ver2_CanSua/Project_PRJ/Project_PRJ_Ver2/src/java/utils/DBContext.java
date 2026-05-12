package utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Quản lý kết nối SQL Server
 */
public class DBContext {

    private static final String URL = "jdbc:sqlserver://localhost:1433;"
            + "databaseName=TTGShop8;"
            + "encrypt=true;"
            + "trustServerCertificate=true;"
            + "characterEncoding=UTF-8;"
            + "useUnicode=true;";

    private static final String USER = "sa";
    private static final String PASS = "123";

    static {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            System.out.println(">>> SQL Server Driver loaded.");
        } catch (ClassNotFoundException e) {
            System.err.println(">>> Không tìm thấy driver SQL Server JDBC!");
            e.printStackTrace();
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Đóng một connection
    public static void closeQuietly(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ignored) {
            }
        }
    }

    // Đóng nhiều resource (Connection, PreparedStatement, ResultSet)
    public static void closeQuietly(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}