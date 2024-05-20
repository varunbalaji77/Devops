<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ATM System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #22a6b3;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            text-align: center;
        }
        h1 {
            color: #fff;
            text-shadow: 2px 2px 4px #000;
            font-size: 36px; /* Increased font size */
            margin-bottom: 30px; /* Increased margin for spacing */
        }
        ul {
            list-style-type: none;
            padding: 0;
            margin: 0; /* Remove default margin */
            display: flex;
            justify-content: center; /* Center align links horizontally */
        }
        li {
            margin-bottom: 20px;
        }
        a {
            text-decoration: none;
            color: #fff;
            background-color: #4CAF50;
            padding: 15px 30px; /* Increased padding for better click area */
            border-radius: 25px;
            display: inline-block;
            transition: background-color 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
            font-size: 20px; /* Increased font size */
            margin: 0 10px; /* Add margin between links */
        }
        a:hover {
            background-color: #45a049;
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to ATM System</h1>
        <ul>
            <li><a href="balance.jsp">Check Balance</a></li>
            <li><a href="deposit.jsp">Deposit</a></li>
            <li><a href="withdrawal.jsp">Withdrawal</a></li>
        </ul>
    </div>
</body>
</html>
