<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Withdrawal</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #22a6b3; /* Yellow background */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            width: 400px;
            background-color: #fff; /* White container background */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            margin-top: 50px; /* Added margin-top */
        }
        h1 {
            color: #333; /* Dark gray heading color */
        }
        input[type="text"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50; /* Green button */
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green color on hover */
        }
        p {
            color: #444; /* Dark gray text color */
            margin-top: 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Withdrawal</h1>
        <form action="withdrawal.jsp" method="post">
            <label for="accountNumber">Enter Account Number:</label><br>
            <input type="text" id="accountNumber" name="accountNumber"><br>
            <label for="withdrawalAmount">Enter Withdrawal Amount:</label><br>
            <input type="text" id="withdrawalAmount" name="withdrawalAmount"><br>
            <input type="submit" value="Withdraw">
        </form>

        <%-- Your Java code for processing the withdrawal will go here --%>
        <%
            // Retrieve user input from the form
            String accountNumber = request.getParameter("accountNumber");
            String withdrawalAmountStr = request.getParameter("withdrawalAmount");

            if (accountNumber != null && !accountNumber.isEmpty() && withdrawalAmountStr != null && !withdrawalAmountStr.isEmpty()) {
                try {
                    // Parse the withdrawal amount to double
                    double withdrawalAmount = Double.parseDouble(withdrawalAmountStr);

                    // Database connection parameters
                    String url = "jdbc:mysql://localhost:3306/atm_database";
                    String user = "root";
                    String password = "";

                    // Initialize database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(url, user, password);
                    Statement statement = connection.createStatement();

                    // Check if withdrawal amount is less than or equal to balance
                    String balanceQuery = "SELECT balance FROM account WHERE account_number = ?";
                    PreparedStatement preparedStatement = connection.prepareStatement(balanceQuery);
                    preparedStatement.setString(1, accountNumber);
                    ResultSet resultSet = preparedStatement.executeQuery();

                    if (resultSet.next()) {
                        double balance = resultSet.getDouble("balance");
                        if (withdrawalAmount <= balance) {
                            // Update balance in the database
                            String updateQuery = "UPDATE account SET balance = balance - ? WHERE account_number = ?";
                            PreparedStatement updateStatement = connection.prepareStatement(updateQuery);
                            updateStatement.setDouble(1, withdrawalAmount);
                            updateStatement.setString(2, accountNumber);
                            int rowsAffected = updateStatement.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p>$" + withdrawalAmount + " withdrawn successfully.</p>");
                            } else {
                                out.println("<p>Failed to withdraw money.</p>");
                            }
                        } else {
                            out.println("<p>Insufficient balance.</p>");
                        }
                    } else {
                        out.println("<p>Account number not found.</p>");
                    }

                    // Close connections
                    resultSet.close();
                    preparedStatement.close();
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
