<%@ page import="java.sql.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="com.localevent.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>View Booked Tickets</title>
    <style>
        /* Background and General Styling */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background: url('images/SouthStreet.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 70%;
            margin: auto;
            padding: 20px;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.2);
            margin-top: 50px;
        }

        h2 {
            color: #ffcc00;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            text-align: left;
        }

        th, td {
            border: 1px solid white;
            padding: 12px;
            text-align: center;
        }

        th {
            background-color: rgba(255, 255, 255, 0.3);
        }

        p {
            font-size: 18px;
            margin-top: 20px;
        }

        a {
            text-decoration: none;
            padding: 10px 20px;
            display: inline-block;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            font-size: 16px;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>My Booked Tickets</h2>

        <%
            // Check if the user is logged in
            if (session == null || session.getAttribute("userId") == null) {
                response.sendRedirect("user_login.jsp");
                return;
            }

            int userId = (Integer) session.getAttribute("userId");

            try (Connection con = DBConnection.connect();
                 PreparedStatement pst = con.prepareStatement("SELECT e.event_name, e.venue, e.event_date, e.event_time, b.ticket_count, b.total_price FROM Bookings b JOIN Events e ON b.event_id = e.event_id WHERE b.user_id = ?")) {

                pst.setInt(1, userId);
                ResultSet rs = pst.executeQuery();

                if (!rs.isBeforeFirst()) { // No bookings found
                    out.println("<p>No tickets booked yet.</p>");
                } else {
        %>
                    <table>
                        <tr>
                            <th>Event Name</th>
                            <th>Venue</th>
                            <th>Date</th>
                            <th>Time</th>
                            <th>Ticket Count</th>
                            <th>Total Price</th>
                        </tr>
        <%
                    while (rs.next()) {
        %>
                        <tr>
                            <td><%= rs.getString("event_name") %></td>
                            <td><%= rs.getString("venue") %></td>
                            <td><%= rs.getDate("event_date") %></td>
                            <td><%= rs.getString("event_time") %></td>
                            <td><%= rs.getInt("ticket_count") %></td>
                            <td>₹<%= rs.getDouble("total_price") %></td>
                        </tr>
        <%
                    }
        %>
                    </table>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error retrieving booked tickets.</p>");
            }
        %>

        <br>
        <a href="user_dashboard.jsp">Back to Dashboard</a>
    </div>

</body>
</html>
