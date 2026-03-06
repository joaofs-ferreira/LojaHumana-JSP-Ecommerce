##criar_loja.jsp
Purpose: Interface to add a new store. Includes strict client-side validation for the store name format.

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Loja Register</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Nova Loja</h2>
            <form id="Form" action="db_criar_loja.jsp" onsubmit="return validarFormulario()">
                <label for="loja">Loja: </label>
                <input type="text" id="loja" name="loja" size="45" required/>
                
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

    function validarFormulario() {
        const loja = document.getElementById("loja").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (loja === "") {
            errorField.innerHTML = "<b>Por favor, preencha todos os campos.</b>";
            return false; 
        }

        if (loja.length < 20) {
            errorField.innerHTML = "<b>O nome da loja deve ter pelo menos 20 caracteres.</b>";
            return false; 
        }
        
        if (!loja.includes("-") || !loja.includes("|")) {
            errorField.innerHTML = "<b>Formato de loja inv�lido. Use o formato 'Cidade - Rua | C�digo Postal'</b>";
            return false;
        }
      
        return true;
    }
    </script>
</body>
</html>
