package net.trioxwater.tutorial;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegisterServlet() throws ClassNotFoundException {
        super();
        Class.forName("org.sqlite.JDBC");
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String qq = request.getParameter("qq");
        String nickname = request.getParameter("nickname");

        // Set up a database connection
        String jdbcUrl = "jdbc:sqlite:/Users/trioxwater/IdeaProjects/Project/tutorial/src/main/resources/contest";

        try (Connection connection = DriverManager.getConnection(jdbcUrl)) {
            // Insert user data into the database
            String sql = "INSERT INTO users (username, password, qq, nickname, register_time, last_login_time) VALUES (?, ?, ?, ?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, username);
                preparedStatement.setString(2, password);
                preparedStatement.setString(3, qq);
                preparedStatement.setString(4, nickname);
                preparedStatement.setTimestamp(5, new Timestamp(new Date().getTime()));
                preparedStatement.setTimestamp(6, new Timestamp(new Date().getTime()));

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    Cookie userCookie = new Cookie("username", username);
                    // 设置Cookie的生存时间，单位为秒
                    userCookie.setMaxAge(3600); // 1 hour
                    response.addCookie(userCookie);
                    response.sendRedirect("index.jsp");
                } else {
                    response.sendRedirect("register.jsp");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
