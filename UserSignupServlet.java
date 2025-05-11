package com.localevent;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UserSignupServlet")
public class UserSignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection con = DBConnection.connect();
             PreparedStatement pst = con.prepareStatement("INSERT INTO Users (name, email, password) VALUES (?, ?, ?)")) {
            
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            int result = pst.executeUpdate();

            if (result > 0) {
                response.sendRedirect("user_login.jsp");
            } else {
                response.sendRedirect("user_signup.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user_signup.jsp?error=1");
        }
    }
}
