##index.jsp

Purpose: This is the entry point of the application (Login Page). 
It allows users to authenticate or navigate to registration and password recovery.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Humana Login</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Login</h2>
            <form method="post" id="Form" action="db_index.jsp" onsubmit="return validarFormularioL()" >
                <label for="email">E-mail:</label>
                <input type="text" id="email" name="email"required/> 
                
                <label for="pass">Password:</label>
                
                <input type="password" id="pass" name="pass" required/>
                
                <div class="button-container">
                    <button type="submit">Login</button>
                   <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <p><b> N�o tens conta?
                <a href="novo_registro.jsp"> Criar conta </a></b></p>
                
                <p><b> Esqueceu-se da password?
                <a href="nova_pass.jsp">Clica aqui</a></b></p>
                <div id="errorField" style="color: red;"></div>
            </form>
            
            <div class="footer-logo">
                <img src="humana.png" alt="Humana Portugal Logo">
            </div>
        </div>
    </div>
    <script src="script.js"></script>
</body>
</html>
