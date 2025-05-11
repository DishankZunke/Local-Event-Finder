<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        /* 🔹 Full-Page Background */
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 0;
            padding: 0;
            background: url('images/adminImg.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        /* 🔹 Container Box */
        .container {
            background: rgba(255, 255, 255, 0.9); /* Semi-transparent background */
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 0px 15px rgba(0, 0, 0, 0.2);
        }

        /* 🔹 Headings */
        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        /* 🔹 Buttons */
        .btn {
            display: inline-block;
            text-decoration: none;
            padding: 12px 25px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #007bff;
            border-radius: 5px;
            margin: 10px;
            transition: 0.3s ease;
        }

        .btn:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Welcome, Admin</h2>
        <a href="manage_events.jsp" class="btn">Manage Events</a>
        <a href="logout" class="btn">Logout</a>
    </div>



</body>
</html>
