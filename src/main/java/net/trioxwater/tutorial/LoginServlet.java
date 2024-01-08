package net.trioxwater.tutorial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String URL = "jdbc:sqlite:/Users/trioxwater/IdeaProjects/Project/tutorial/src/main/resources/contest";

    public LoginServlet() throws ClassNotFoundException {
        super();
        Class.forName("org.sqlite.JDBC");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            try (Connection conn = DriverManager.getConnection(URL);
                 PreparedStatement ps = conn.prepareStatement("SELECT password FROM users WHERE username = ?")) {
                ps.setString(1, username);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        String dbPassword = rs.getString("password");
                        // 比较哈希后的密码
                        if (verifyPassword(password, dbPassword)) {
                            Cookie userCookie = new Cookie("username", username);
                            // 设置Cookie的生存时间，单位为秒
                            userCookie.setMaxAge(3600); // 1 hour
                            response.addCookie(userCookie);
                            response.sendRedirect("index.jsp");
                        } else {
                            response.sendRedirect("login.jsp?error=1");
                        }
                    } else {
                        response.sendRedirect("login.jsp?error=1");
                    }
                }
            }
        } catch (SQLException e) {
            response.sendRedirect("error.jsp");
            throw new ServletException("Database error", e);
        }
    }

    private boolean verifyPassword(String inputPassword, String storedPassword) {
        // 实现密码比较的逻辑，例如使用哈希函数
        // 这里只是简单比较，实际应用中应该使用哈希算法，例如BCrypt
        return inputPassword.equals(storedPassword);
    }
}
