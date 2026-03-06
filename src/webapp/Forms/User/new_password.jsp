##nova_pass.jsp
Purpose: The Password Recovery Page. It allows users to update their password by submitting their email to the backend processor.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Forgot Password</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>New Password</h3>
            <form method="post" action="db_password.jsp" id="Form" onsubmit="return validarFormularioL()">
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" size="45" required/>
                
                <label for="pass">New Password:</label>
                <input type="password" id="pass" name="pass" size="45" required/>
                   
                <div class="button-container">
                    <button type="submit">Atualizar</button>
                    <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <b>
                    <p>Se j� est�s registado faz login! 
                    <a href="index.jsp">Login</a></p>
                    <div id="errorField" style="color: red;"></div>
                </b>
            </form>
            <div class="footer-logo">
                <img src="humana.png" alt="Humana Portugal Logo">
            </div>
        </div>
    </div>
    <script src="script.js"></script>
</body>
</html>
