package com.localevent;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/ViewBookedTicketsServlet")
public class ViewBookedTicketsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("user_login.jsp");
            return;
        }
        int userId = (Integer) session.getAttribute("userId");

        out.println("<html><head><title>Booked Tickets</title>");
        out.println("<style>");
        out.println("body {"
                + " font-family: Arial, sans-serif; text-align: center; color: white;"
                + " background: url('images/Ted_X_Talks_you_must_watch.webp') no-repeat center center fixed;"
                + " background-size: cover; margin: 0; padding: 0;"
                + "}");
        out.println(".container {"
                + " width: 70%; margin: auto; padding: 20px; background: rgba(0, 0, 0, 0.7);"
                + " backdrop-filter: blur(10px); border-radius: 10px;"
                + " box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.2); margin-top: 50px;"
                + "}");
        out.println("h2 { color: #ffcc00; }");
        out.println("table { width: 100%; margin-top: 20px; border-collapse: collapse; background: rgba(255, 255, 255, 0.2); text-align: center; color: white; }");
        out.println("th, td { border: 1px solid white; padding: 12px; }");
        out.println("th { background-color: rgba(255, 255, 255, 0.3); }");
        out.println("p { font-size: 18px; margin-top: 20px; }");
        out.println("a { text-decoration: none; padding: 10px 20px; display: inline-block; margin-top: 20px;"
                + " background-color: #007bff; color: white; border-radius: 5px; font-size: 16px; }");
        out.println("a:hover { background-color: #0056b3; }");
        out.println("</style></head><body>");

        out.println("<div class='container'>");
        out.println("<h2>My Booked Tickets</h2>");


        try (Connection con = DBConnection.connect();
             PreparedStatement pst = con.prepareStatement("SELECT e.event_name, e.venue, e.event_date, e.event_time, b.ticket_count, b.total_price FROM Bookings b JOIN Events e ON b.event_id = e.event_id WHERE b.user_id = ?")) {

            pst.setInt(1, userId);
            ResultSet rs = pst.executeQuery();

            if (!rs.isBeforeFirst()) { // No bookings found
                out.println("<p>No tickets booked yet.</p>");
            } else {
                out.println("<table>");
                out.println("<tr><th>Event Name</th><th>Venue</th><th>Date</th><th>Time</th><th>Ticket Count</th><th>Total Price</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("event_name") + "</td>");
                    out.println("<td>" + rs.getString("venue") + "</td>");
                    out.println("<td>" + rs.getDate("event_date") + "</td>");
                    out.println("<td>" + rs.getString("event_time") + "</td>");
                    out.println("<td>" + rs.getInt("ticket_count") + "</td>");
                    out.println("<td>₹" + rs.getDouble("total_price") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error retrieving booked tickets.</p>");
        }

        out.println("<br><a href='user_dashboard.jsp'>Back to Dashboard</a>");
        out.println("</body></html>");
    }
}
