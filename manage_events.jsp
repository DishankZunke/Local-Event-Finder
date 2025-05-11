<%@ page import="java.sql.*" %>
<%@ page import="com.localevent.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Check if admin is logged in
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Events</title>
    <style>
        /* 🔹 Full-Page Background */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: url('images/event-planners.gif') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
        }

        /* 🔹 Container */
        .container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparent effect */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 50%;
        }

        /* 🔹 Headings */
        h2, h3 {
            color: #333;
            margin-bottom: 20px;
        }

        /* 🔹 Form Styling */
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        input {
            width: 90%;
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        /* 🔹 Buttons */
        button {
            width: 95%;
            padding: 10px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            color: white;
            cursor: pointer;
            transition: 0.3s;
        }

        button[name="action"][value="add"] {
            background-color: #28a745;
        }

        button[name="action"][value="update"] {
            background-color: #ffc107;
        }

        button[name="action"][value="delete"] {
            background-color: #dc3545;
        }

        button:hover {
            transform: scale(1.05);
        }

        /* 🔹 Table Styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
        }

        th {
            background-color: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Manage Events</h2>

        <form action="ManageEventsServlet" method="post">
            <label>Event ID (For Update/Delete):</label>
            <input type="text" name="event_id">

            <label>Event Name:</label>
            <input type="text" name="event_name" required>

            <label>Venue:</label>
            <input type="text" name="venue" required>

            <label>Time:</label>
            <input type="text" name="event_time" required>

            <label>Date:</label>
            <input type="date" name="event_date" required>

            <label>Available Tickets:</label>
            <input type="number" name="available_tickets" required>

            <label>Ticket Price:</label>
            <input type="number" step="0.01" name="ticket_price" required>

            <button type="submit" name="action" value="add">Add Event</button>
            <button type="submit" name="action" value="update">Update Event</button>
            <button type="submit" name="action" value="delete">Delete Event</button>
        </form>

        <h3>Existing Events</h3>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Venue</th>
                <th>Time</th>
                <th>Date</th>
                <th>Available Tickets</th>
                <th>Price</th>
            </tr>
            <%
                try (Connection con = DBConnection.connect();
                     Statement stmt = con.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM Events")) {
                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("event_id") %></td>
                <td><%= rs.getString("event_name") %></td>
                <td><%= rs.getString("venue") %></td>
                <td><%= rs.getString("event_time") %></td>
                <td><%= rs.getDate("event_date") %></td>
                <td><%= rs.getInt("available_tickets") %></td>
                <td><%= rs.getDouble("ticket_price") %></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </table>
          <br>
        <a href="admin_dashboard.jsp">Back to Admin Dasboard</a>
    </div>

</body>
</html>
