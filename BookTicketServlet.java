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
import jakarta.servlet.http.HttpSession;

@WebServlet("/BookTicketServlet")
public class BookTicketServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("user_login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        int eventId = Integer.parseInt(request.getParameter("eventId"));
        int ticketCount = Integer.parseInt(request.getParameter("ticketCount"));

        try (Connection con = DBConnection.connect()) {
            // 1️⃣ **Check ticket availability**
            PreparedStatement checkStmt = con.prepareStatement("SELECT available_tickets, ticket_price FROM Events WHERE event_id = ?");
            checkStmt.setInt(1, eventId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int availableTickets = rs.getInt("available_tickets");
                double ticketPrice = rs.getDouble("ticket_price");

                if (ticketCount > availableTickets) {
                    response.sendRedirect("book_ticket.jsp?error=not_enough_tickets");
                    return;
                }

                // 2️⃣ **Update available tickets**
                int updatedTickets = availableTickets - ticketCount;
                PreparedStatement updateStmt = con.prepareStatement("UPDATE Events SET available_tickets = ? WHERE event_id = ?");
                updateStmt.setInt(1, updatedTickets);
                updateStmt.setInt(2, eventId);
                updateStmt.executeUpdate();

                // 3️⃣ **Insert booking details**
                PreparedStatement insertStmt = con.prepareStatement("INSERT INTO Bookings (user_id, event_id, ticket_count, total_price) VALUES (?, ?, ?, ?)");
                insertStmt.setInt(1, userId);
                insertStmt.setInt(2, eventId);
                insertStmt.setInt(3, ticketCount);
                insertStmt.setDouble(4, ticketCount * ticketPrice);
                insertStmt.executeUpdate();

                // 4️⃣ **Redirect to booking confirmation**
                response.sendRedirect("view_booked_tickets.jsp?success=booked");
            } else {
                response.sendRedirect("book_ticket.jsp?error=event_not_found");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("book_ticket.jsp?error=database_error");
        }
    }
}
