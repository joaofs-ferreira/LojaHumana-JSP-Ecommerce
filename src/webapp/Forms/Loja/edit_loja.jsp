##edit_loja.jsp
Purpose: Updates an existing store's location details. 
It dynamically populates a dropdown list from the database so the user can select which store to modify.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Loja</title>
<link rel="stylesheet" type="text/css" href="Categories_Edit.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Editar Loja</h3>
            <form method="post" action="db_edit_loja.jsp" id="Form" onsubmit="return validarFormulario()">
                <label for="loja_before">Loja:</label>
                <select id="loja_antiga" name="loja_before">
                    <option value="">Selecione a Loja</option>
                    <% 
                        Connection conn = null;
                        Statement stmt = null;
                        ResultSet rs = null;

                        try {
                            String url = "jdbc:mysql://localhost:3306/lojahumana";
                            String username = "root";
                            String password = "15110604web!";
                            
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(url, username, password);
                            System.out.println("Conex�o com a base de dados estabelecida.");
                        
                            String sql = "SELECT id_loja, localizacao FROM Loja";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);
                            
                            while (rs.next()) {
                                int IdLoja = rs.getInt("id_loja");
                                String local = rs.getString("localizacao");
                    %>
                                <option value="<%= IdLoja %>"><%= local %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                           
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
                
                <label for="loja_new">Atualizar Loja:</label>
                <input type="text" id="loja_nova" name="loja_nova" size="45" required/>
                   
                <div class="button-container">
                    <button type="submit">Atualizar</button>
                    <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <b>
                    <div id="errorField" style="color: red;"></div>
                </b>
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
        const loja_antiga = document.getElementById("loja_antiga").value;
        const loja_nova = document.getElementById("loja_nova").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (loja_antiga === "") {
            errorField.innerHTML = "<b>Por favor, selecione uma Loja.</b>";
            return false; 
        }

        if (loja_nova === "") {
            errorField.innerHTML = "<b>Por favor, preencha o campo de nova Loja.</b>";
            return false; 
        }
        
        if (loja_nova.length < 20) {
            errorField.innerHTML = "<b>O nome da loja deve ter pelo menos 20 caracteres.</b>";
            return false; 
        }
        
        if (!loja_nova.includes("-") || !loja_nova.includes("|")) {
            errorField.innerHTML = "<b>Formato de loja inv�lido. Use o formato 'Cidade - Rua | C�digo Postal'</b>";
            return false;
        }

        return true;
    }

    </script>
    
</body>
</html>
  
