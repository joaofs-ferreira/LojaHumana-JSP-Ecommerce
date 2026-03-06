##novo_registo.jsp
Purpose: The Registration Page. It allows new users to create an account by providing a username, email, and password.

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Client Register</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Novo Registro Cliente</h2>
            <form id="Form" action="db_registo.jsp" onsubmit="return validarFormulariorR()">
                <label for="username">Username:</label>
                <input type="text" id="username" name="username" size="45" required/>
                
                <label for="email">Email:</label>
                <input type="text" id="email" name="email" size="45" required/>
                
                <label for="pass">Password:</label>
                <input type="password" id="pass" name="pass" size="45" required/>
                
                <div class="button-container">
                    <button type="submit">Criar</button>
                    <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <p> <b> Se j� est�s registado faz login!</b>
                <a href="index.jsp"> <b> Login </b> </a></p>
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
