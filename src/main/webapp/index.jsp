<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*, javax.servlet.*, javax.servlet.http.*" %>
<%
    String num1 = request.getParameter("num1");
    String num2 = request.getParameter("num2");
    String operator = request.getParameter("operator");
    double result = 0;
    boolean valid = true;

    if (num1 != null && num2 != null && operator != null) {
        try {
            double n1 = Double.parseDouble(num1);
            double n2 = Double.parseDouble(num2);

            switch (operator) {
                case "add":
                    result = n1 + n2;
                    break;
                case "subtract":
                    result = n1 - n2;
                    break;
                case "multiply":
                    result = n1 * n2;
                    break;
                case "divide":
                    if (n2 != 0) {
                        result = n1 / n2;
                    } else {
                        valid = false;
                        out.println("<script>alert('Division by zero is not allowed');</script>");
                    }
                    break;
                default:
                    valid = false;
                    break;
            }
        } catch (NumberFormatException e) {
            valid = false;
            out.println("<script>alert('Invalid input');</script>");
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Colorful Calculator</title>
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
            text-align: center;
            padding-top: 50px;
        }
        .calculator {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
            display: inline-block;
            padding: 20px;
        }
        input[type="text"] {
            width: 80%;
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
            border: 1px solid #ccc;
            font-size: 1.2em;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.2em;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        .result {
            font-size: 1.5em;
            color: #333;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="calculator">
        <h1>Colorful Calculator</h1>
        <form method="get" action="index.jsp">
            <input type="text" name="num1" placeholder="Enter first number" value="<%= num1 != null ? num1 : "" %>"><br>
            <input type="text" name="num2" placeholder="Enter second number" value="<%= num2 != null ? num2 : "" %>"><br>
            <input type="submit" name="operator" value="add" style="background-color: #4CAF50;">
            <input type="submit" name="operator" value="subtract" style="background-color: #2196F3;">
            <input type="submit" name="operator" value="multiply" style="background-color: #ff9800;">
            <input type="submit" name="operator" value="divide" style="background-color: #f44336;">
        </form>
        <% if (num1 != null && num2 != null && operator != null && valid) { %>
            <div class="result">
                Result: <%= result %>
            </div>
        <% } %>
    </div>
</body>
</html>
