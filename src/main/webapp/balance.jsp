<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Check Balance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #22a6b3; /* Blue background */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 0 auto;
            padding: 20px;
            background-color: #ffffff; /* White background */
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #ffffff; /* White heading color */
            margin-bottom: 20px;
        }
        input[type="text"] {
            width: 300px;
            padding: 15px;
            margin: 10px;
            border-radius: 25px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 15px 30px;
            background-color: #2ecc71; /* Green button */
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #27ae60; /* Darker green color on hover */
        }
        p {
            color: #6c757d; /* Gray text color */
            font-size: 18px;
            margin-top: 20px;
        }
        .check-balance-text {
            color: #333; /* Darker gray color for the Check Balance text */
            font-size: 24px; /* Larger font size for visibility */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Check Nalavee</h1>
        <h2>Check Balance</h2>
        <form action="balance.jsp" method="post">
            <label for="accountNumber">Enter Account Number:</label><br>
            <input type="text" id="accountNumber" name="accountNumber"><br>
            <input type="submit" value="Check Balance">
        </form>

        <%
            // Retrieve user input from the form
            String accountNumber = request.getParameter("accountNumber");

            if (accountNumber != null && !accountNumber.isEmpty()) {
                // Database connection parameters
                String url = "jdbc:mysql://localhost:3306/atm_database";
                String user = "root";
                String password = "";

                // Initialize database connection
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, password);
                    Statement statement = connection.createStatement();

                    // Retrieve balance from the database
                    String query = "SELECT balance FROM account WHERE account_number = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(query);
                    preparedStatement.setString(1, accountNumber);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        out.println("<p class=\"check-balance-text\">Your balance is: $" + resultSet.getDouble("balance") + "</p>");
                    } else {
                        out.println("<p class=\"check-balance-text\">Account number not found.</p>");
                    }

                    // Close connections
                    resultSet.close();
                    preparedStatement.close();
                    statement.close();
                    connection.close();
                } catch (Exception e) {
                    out.println("<p class=\"check-balance-text\">Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
