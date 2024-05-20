<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Scientific Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: linear-gradient(to right, #ff00cc, #333399);
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .calculator {
            width: 320px; /* Adjusted for better spacing */
            padding: 20px;
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .display {
            width: calc(100% - 40px); /* Adjusted for better spacing */
            height: 70px;
            margin: 0 auto 20px auto; /* Centered and spaced */
            font-size: 24px;
            text-align: right;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 10px;
            background-color: #f9f9f9;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px; /* Adjusted for better spacing */
        }
        .button {
            width: 60px;
            height: 60px;
            font-size: 18px;
            background-color: #4CAF50;
            border: none;
            color: white;
            border-radius: 10px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="calculator">
    <div class="display" id="display">0</div>
    <div class="row">
        <button class="button" onclick="appendToExpression('7')">7</button>
        <button class="button" onclick="appendToExpression('8')">8</button>
        <button class="button" onclick="appendToExpression('9')">9</button>
        <button class="button" onclick="appendToExpression('+')">+</button>
        <button class="button" onclick="squareRoot()">√</button>
    </div>
    <div class="row">
        <button class="button" onclick="appendToExpression('4')">4</button>
        <button class="button" onclick="appendToExpression('5')">5</button>
        <button class="button" onclick="appendToExpression('6')">6</button>
        <button class="button" onclick="appendToExpression('-')">-</button>
        <button class="button" onclick="power()">x<sup>y</sup></button>
    </div>
    <div class="row">
        <button class="button" onclick="appendToExpression('1')">1</button>
        <button class="button" onclick="appendToExpression('2')">2</button>
        <button class="button" onclick="appendToExpression('3')">3</button>
        <button class="button" onclick="appendToExpression('*')">*</button>
        <button class="button" onclick="trigonometricFunction('sin')">sin</button>
    </div>
    <div class="row">
        <button class="button" onclick="appendToExpression('0')">0</button>
        <button class="button" onclick="appendToExpression('.')">.</button>
        <button class="button" onclick="clearExpression()">C</button>
        <button class="button" onclick="calculateResult()">=</button>
        <button class="button" onclick="trigonometricFunction('cos')">cos</button>
    </div>
    <div class="row">
        <button class="button" onclick="appendToExpression('(')">(</button>
        <button class="button" onclick="appendToExpression(')')">)</button>
        <button class="button" onclick="trigonometricFunction('tan')">tan</button>
        <button class="button" onclick="appendToExpression('/')">/</button>
    </div>
</div>

<script>
    function appendToExpression(value) {
        var display = document.getElementById('display');
        if (display.textContent === '0' && value !== '.') {
            display.textContent = value;
        } else {
            display.textContent += value;
        }
    }

    function clearExpression() {
        document.getElementById('display').textContent = '0';
    }

    function calculateResult() {
        var display = document.getElementById('display');
        var expression = display.textContent;

        try {
            var result = eval(expression);
            if (result === Infinity || isNaN(result)) {
                display.textContent = 'Error';
            } else {
                display.textContent = result;
            }
        } catch (error) {
            display.textContent = 'Error';
        }
    }

    function squareRoot() {
        var display = document.getElementById('display');
        var number = parseFloat(display.textContent);
        if (number >= 0) {
            display.textContent = Math.sqrt(number);
        } else {
            display.textContent = 'Error';
        }
    }

    function power() {
        var display = document.getElementById('display');
        var expression = display.textContent.split('^');
        if (expression.length === 2) {
            display.textContent = Math.pow(parseFloat(expression[0]), parseFloat(expression[1]));
        } else {
            display.textContent = 'Error';
        }
    }

    function trigonometricFunction(func) {
        var display = document.getElementById('display');
        var number = parseFloat(display.textContent);
        switch (func) {
            case 'sin':
                display.textContent = Math.sin(number);
                break;
            case 'cos':
                display.textContent = Math.cos(number);
                break;
            case 'tan':
                display.textContent = Math.tan(number);
                break;
            default:
                display.textContent = 'Error';
        }
    }
</script>
</body>
</html>
