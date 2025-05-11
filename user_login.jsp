<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>User Login</title>
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
            background: url('images/newimage.jpg') no-repeat center center fixed;
            background-size: cover;
        }

        /* 🔹 Glassmorphism Login Box */
        .login-container {
            background: rgba(255, 255, 255, 0.2); /* Transparent Effect */
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0px 0px 15px rgba(255, 255, 255, 0.2);
            text-align: center;
            width: 350px;
            color: #000; /* Set text color to black */
        }

        /* 🔹 Headings */
        h2 {
            margin-bottom: 20px;
            color: #000; /* Set heading text color to black */
        }

        /* 🔹 Error Message */
        .error-message {
            color: #ff4d4d;
            font-weight: bold;
            margin-bottom: 15px;
        }

        /* 🔹 Input Fields */
        input {
            width: 90%;
            padding: 12px;
            margin: 10px 0;
            border: 2px solid rgba(0, 0, 0, 0.3); /* Change border to black */
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.2);
            color: #000; /* Set input text color to black */
            outline: none;
            transition: all 0.3s;
        }

        input::placeholder {
            color: rgba(0, 0, 0, 0.6); /* Change placeholder text color to black */
        }

        input:focus {
            border-color: #ffdd57;
            background: rgba(255, 255, 255, 0.3);
        }

        /* 🔹 Login Button */
        button {
            width: 95%;
            padding: 12px;
            margin-top: 10px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            background: #28a745;
            color: white;
            transition: 0.3s;
        }

        button:hover {
            background: #218838;
            transform: scale(1.05);
        }

        /* 🔹 Signup Link */
        p {
            margin-top: 15px;
            font-size: 14px;
            color: #000; /* Set paragraph text color to black */
        }

        a {
            color: #000; /* Set link text color to black */
            text-decoration: none;
            font-weight: bold;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="login-container">
        <h2>User Login</h2>

        <% if (request.getParameter("error") != null) { %>
            <p class="error-message">Invalid Email or Password!</p>
        <% } %>

        <form action="UserLoginServlet" method="post">
            <input type="email" name="email" placeholder="Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>

        <p>Don't have an account? <a href="user_signup.jsp">Signup here</a></p>
    </div>

</body>
</html>
