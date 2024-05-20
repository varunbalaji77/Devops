<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Deposit</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #22a6b3; /* Light gray background */
            margin: 0;
            padding: 0;
        }
        .container {
            width: 50%;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff; /* White background */
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        h1 {
            color: #333; /* Dark gray heading color */
            margin-bottom: 30px;
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
            background-color: #4CAF50; /* Green button */
            color: white;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green color on hover */
        }
        p {
            color: #888; /* Gray text color */
            font-size: 18px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Deposit</h1>
        <form action="deposit.jsp" method="post">
            <label for="accountNumber">Enter Account Number:</label><br>
            <input type="text" id="accountNumber" name="accountNumber"><br>
            <label for="depositAmount">Enter Deposit Amount:</label><br>
            <input type="text" id="depositAmount" name="depositAmount"><br>
            <input type="submit" value="Deposit">
        </form>

        <%
            // Retrieve user input from the form
            String accountNumber = request.getParameter("accountNumber");
            String depositAmountStr = request.getParameter("depositAmount");

            if (accountNumber != null && depositAmountStr != null) {
                try {
                    // Parse the deposit amount to double
                    double depositAmount = Double.parseDouble(depositAmountStr);

                    // Database connection parameters
                    String url = "jdbc:mysql://localhost:3306/atm_database";
                    String user = "root";
                    String password = "";

                    // Initialize database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, password);
                    Statement statement = connection.createStatement();

                    // Update balance in the database
                    String updateQuery = "UPDATE account SET balance = balance + " + depositAmount + " WHERE account_number = '" + accountNumber + "'";
                    int rowsAffected = statement.executeUpdate(updateQuery);

                    if (rowsAffected > 0) {
                        out.println("<p>$" + depositAmount + " deposited successfully.</p>");
                    } else {
                        out.println("<p>Failed to deposit money.</p>");
                    }

                    // Close connections
                    statement.close();
                    connection.close();
                } catch (Exception e) {
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                }
            }
        %>
    </div>
</body>
</html>
