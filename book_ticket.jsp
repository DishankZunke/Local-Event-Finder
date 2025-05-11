<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.localevent.DBConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }
    int userId = (Integer) userSession.getAttribute("userId");
%>
<html>
<head>
    <title>Book Ticket</title>
    <style>
        /* Background and Styling */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            background: url('images/newyork.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 60%;
            margin: auto;
            padding: 20px;
            background: rgba(0, 0, 0, 0.7);
            backdrop-filter: blur(10px);
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(255, 255, 255, 0.2);
            margin-top: 50px;
        }

        h2, h3 {
            color: #ffcc00;
        }

        form {
            display: inline-block;
            text-align: left;
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.1);
            padding: 20px;
            border-radius: 8px;
        }

        label, input {
            display: block;
            margin: 10px 0;
            font-size: 16px;
            color: white;
        }

        input {
            width: 100%;
            padding: 8px;
            border-radius: 5px;
            border: 1px solid #fff;
            background: rgba(255, 255, 255, 0.2);
            color: white;
        }

        button {
            background-color: #28a745;
            color: white;
            border: none;
            padding: 10px 20px;
            margin-top: 10px;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }

        button:hover {
            background-color: #218838;
        }

        table {
            width: 100%;
            margin: auto;
            border-collapse: collapse;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid white;
            padding: 10px;
            text-align: center;
        }

        th {
            background-color: rgba(255, 255, 255, 0.3);
        }

        a {
            text-decoration: none;
            padding: 10px 20px;
            display: inline-block;
            margin-top: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
        }

        a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Book Your Ticket</h2>

        <form action="BookTicketServlet" method="post">
            <input type="hidden" name="userId" value="<%= userId %>">
            <label>Event ID:</label>
            <input type="number" name="eventId" required>
            <label>Number of Tickets:</label>
            <input type="number" name="ticketCount" required min="1">
            <button type="submit">Book Ticket</button>
        </form>

        <h3>Available Events</h3>
        <table>
            <tr><th>Event ID</th><th>Event Name</th><th>Venue</th><th>Time</th><th>Date</th><th>Available Tickets</th><th>Ticket Price</th></tr>
            <%
                try (Connection con = DBConnection.connect();
                     PreparedStatement pst = con.prepareStatement("SELECT * FROM Events");
                     ResultSet rs = pst.executeQuery()) {
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("event_id") %></td>
                <td><%= rs.getString("event_name") %></td>
                <td><%= rs.getString("venue") %></td>
                <td><%= rs.getString("event_time") %></td>
                <td><%= rs.getString("event_date") %></td>
                <td><%= rs.getInt("available_tickets") %></td>
                <td>₹<%= rs.getDouble("ticket_price") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>

        <br>
        <a href="user_dashboard.jsp">Back to Dashboard</a>
    </div>

</body>
</html>
