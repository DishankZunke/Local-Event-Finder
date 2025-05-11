<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null) {
        response.sendRedirect("user_login.jsp");
        return;
    }
    String userName = (String) userSession.getAttribute("userName");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Dashboard</title>
    <style>
        /* 🔹 Full-Screen Background */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            background: url('images/902965-corporate-event-wallpaper.jpg') no-repeat center center fixed;
            background-size: cover;
            color: black; /* Ensures all text remains black */
        }

        /* 🔹 Glassmorphism Container */
        .dashboard-container {
            background: rgba(255, 255, 255, 0.3); /* Transparent Effect */
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.3);
            text-align: center;
            width: 400px;
            color: black; /* Text color */
        }

        /* 🔹 Headings */
        h2 {
            margin-bottom: 20px;
            font-size: 24px;
            font-weight: bold;
            color: black;
        }

        /* 🔹 Buttons */
        button {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            background: #007bff;
            color: white;
            transition: all 0.3s ease-in-out;
        }

        button:hover {
            background: #0056b3;
            transform: scale(1.05);
        }

        /* 🔹 Forms */
        form {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

    <div class="dashboard-container">
        <h2>Welcome, <%= userName %>!</h2>
        
        <form action="ViewEventsServlet" method="post">
            <button type="submit">View Events</button>
        </form>

        <form action="book_ticket.jsp" method="post">
            <button type="submit">Book Ticket</button>
        </form>

        <form action="ViewBookedTicketsServlet" method="post">
            <button type="submit">View Booked Tickets</button>
        </form>

        <form action="LogoutServlet" method="post">
            <button type="submit" style="background: #dc3545;">Logout</button>
        </form>
    </div>

</body>
</html>
