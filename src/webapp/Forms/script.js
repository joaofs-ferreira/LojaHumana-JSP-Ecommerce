### validation.js

This script contains client-side form validation for the authentication system of the application.

It validates both **login** and **registration** forms before the data is submitted to the server.  
The goal is to ensure that the user provides valid information and to prevent incomplete or invalid requests from being processed by the backend.

The script also handles the **reset button behavior**, clearing error messages when the user resets the form.

document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("resetButton").addEventListener("click", function() {
            document.getElementById("errorField").innerHTML = "";
        });
    });

function validarFormularioL() {
    
	document.getElementById("Form");
    const email = document.getElementById("email").value;
    const pass = document.getElementById("pass").value;
    const errorField = document.getElementById("errorField");

    errorField.innerHTML = "";

  
    if (email === "" || pass === "") {
        errorField.innerHTML = "<b>Por favor, preencha todos os campos.</b>";
        event.preventDefault();
        return;
    }

   
    if (!email.includes("@") || !email.includes(".com")) {
        errorField.innerHTML = "<b>Email invalido, verifique se o mesmo contem @ e .com</b>";
        event.preventDefault(); 
        return;
    }

    
    if (pass.length < 9) {
        errorField.innerHTML = "<b>A senha deve ter pelo menos 9 caracteres.</b>";
        event.preventDefault(); 
        return;
    }
}

function validarFormulariorR() {
    const email = document.getElementById("email").value;
    const pass = document.getElementById("pass").value;
    const username = document.getElementById("username").value;
    const errorField = document.getElementById("errorField");
  
    errorField.innerHTML = "";
  
    if (email === "" || pass === "" || username === "") {
        errorField.innerHTML = "<b>Por favor, preencha todos os campos.</b>";
        return false;
    }

    
    if (username.length <= 8) {
        errorField.innerHTML = "<b>Username deve ter mais de 8 caracteres.</b>";
        return false;
    }

   
    if (!email.includes("@") || !email.endsWith(".com")) {
        errorField.innerHTML = "<b>Email invalido, verifique se o mesmo contem @ e .com</b>";
        return false;
    }

  
    if (pass.length < 9) {
        errorField.innerHTML = "<b>A senha deve ter pelo menos 9 caracteres.</b>";
        return false;
    }

    return true;
}
   
