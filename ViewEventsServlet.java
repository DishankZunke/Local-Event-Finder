package com.localevent;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

@WebServlet("/ViewEventsServlet")
public class ViewEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Available Events</title>");
        out.println("<style>");
        out.println("body {");
        out.println("    font-family: Arial, sans-serif;");
        out.println("    text-align: center;");
        out.println("    background: url('images/wp7488372.webp') no-repeat center center fixed;");
        out.println("    background-size: cover;");
        out.println("    color: black;");
        out.println("}");
        out.println(".container {");
        out.println("    width: 80%;");
        out.println("    margin: auto;");
        out.println("    padding: 20px;");
        out.println("    background: rgba(255, 255, 255, 0.8);");  // Glassmorphism effect
        out.println("    backdrop-filter: blur(10px);");
        out.println("    border-radius: 10px;");
        out.println("    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.2);");
        out.println("}");
        out.println("table { width: 100%; border-collapse: collapse; margin-top: 20px; }");
        out.println("th, td { border: 1px solid black; padding: 12px; text-align: center; }");
        out.println("th { background-color: #f2f2f2; }");
        out.println("a { text-decoration: none; padding: 10px 20px; margin-top: 20px; background-color: #007bff; color: white; display: inline-block; border-radius: 5px; }");
        out.println("a:hover { background-color: #0056b3; }");
        out.println("</style></head><body>");

        out.println("<div class='container'>");
        out.println("<h2>Available Events</h2>");
        out.println("<table>");
        out.println("<tr><th>Event ID</th><th>Event Name</th><th>Venue</th><th>Time</th><th>Date</th><th>Available Tickets</th><th>Ticket Price</th></tr>");
        
        
        try (Connection con = DBConnection.connect();
             PreparedStatement pst = con.prepareStatement("SELECT * FROM Events")) {
            
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                out.println("<tr>");
                out.println("<td>" + rs.getInt("event_id") + "</td>");
                out.println("<td>" + rs.getString("event_name") + "</td>");
                out.println("<td>" + rs.getString("venue") + "</td>");
                out.println("<td>" + rs.getString("event_time") + "</td>");
                out.println("<td>" + rs.getString("event_date") + "</td>");
                out.println("<td>" + rs.getInt("available_tickets") + "</td>");
                out.println("<td>₹" + rs.getDouble("ticket_price") + "</td>");
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("<br><a href='user_dashboard.jsp'>Back to Dashboard</a>");
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p>Error fetching events.</p>");
        }
        
        out.println("</body></html>");
    }
}
