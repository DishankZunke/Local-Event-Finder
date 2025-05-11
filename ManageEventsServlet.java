package com.localevent;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ManageEventsServlet")
public class ManageEventsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String eventId = request.getParameter("event_id");
        String eventName = request.getParameter("event_name");
        String venue = request.getParameter("venue");
        String eventTime = request.getParameter("event_time");
        String eventDate = request.getParameter("event_date");
        String availableTickets = request.getParameter("available_tickets");
        String ticketPrice = request.getParameter("ticket_price");

        try (Connection con = DBConnection.connect()) {
            if ("add".equals(action)) {
                addEvent(con, eventName, venue, eventTime, eventDate, availableTickets, ticketPrice);
            } else if ("update".equals(action) && eventId != null && !eventId.isEmpty()) {
                updateEvent(con, eventId, eventName, venue, eventTime, eventDate, availableTickets, ticketPrice);
            } else if ("delete".equals(action) && eventId != null && !eventId.isEmpty()) {
                deleteEvent(con, eventId);
            }
            response.sendRedirect("manage_events.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("manage_events.jsp?error=1");
        }
    }

    private void addEvent(Connection con, String eventName, String venue, String eventTime, String eventDate, String availableTickets, String ticketPrice) throws SQLException {
        String query = "INSERT INTO Events (event_name, venue, event_time, event_date, available_tickets, ticket_price) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, eventName);
            pst.setString(2, venue);
            pst.setString(3, eventTime);
            pst.setString(4, eventDate);
            pst.setInt(5, Integer.parseInt(availableTickets));
            pst.setDouble(6, Double.parseDouble(ticketPrice));
            pst.executeUpdate();
        }
    }

    private void updateEvent(Connection con, String eventId, String eventName, String venue, String eventTime, String eventDate, String availableTickets, String ticketPrice) throws SQLException {
        String query = "UPDATE Events SET event_name=?, venue=?, event_time=?, event_date=?, available_tickets=?, ticket_price=? WHERE event_id=?";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setString(1, eventName);
            pst.setString(2, venue);
            pst.setString(3, eventTime);
            pst.setString(4, eventDate);
            pst.setInt(5, Integer.parseInt(availableTickets));
            pst.setDouble(6, Double.parseDouble(ticketPrice));
            pst.setInt(7, Integer.parseInt(eventId));
            pst.executeUpdate();
        }
    }

    private void deleteEvent(Connection con, String eventId) throws SQLException {
        String query = "DELETE FROM Events WHERE event_id=?";
        try (PreparedStatement pst = con.prepareStatement(query)) {
            pst.setInt(1, Integer.parseInt(eventId));
            pst.executeUpdate();
        }
    }
}
