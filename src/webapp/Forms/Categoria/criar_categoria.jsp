##criar_categoria.jsp
Purpose: An interface to add new classifications to the system.

Validation Logic:
Presence: The field cannot be empty.
Length: Category names must be at least 5 characters long to ensure descriptive and professional naming.

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Categoria Register</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Nova Categoria</h2>
            <form id="Form" action="db_criar_cat.jsp" onsubmit="return validarFormularioCat()">
                <label for="categoria">Categoria: </label>
                <input type="text" id="categoria" name="categoria" size="45"/>
                
                <div class="button-container">
                    <button type="submit">Criar</button>
                    <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <div id="errorField" style="color: red;"></div>
            </form>
            <div class="footer-logo">
                <img src="humana.png" alt="Humana Portugal Logo">
            </div>
        </div>
    </div>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("resetButton").addEventListener("click", function() {
            document.getElementById("errorField").innerHTML = "";
        });
    });

    function validarFormularioCat() {
        const categoria = document.getElementById("categoria").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (categoria === "") {
            errorField.innerHTML = "<b>Por favor, preencha todos os campos.</b>";
            return false; 
        }

        if (categoria.length < 5) {
            errorField.innerHTML = "<b>O nome da categoria deve ter pelo menos 5 caracteres.</b>";
            return false; 
        }

        return true;
    }
    </script>
</body>
</html>
