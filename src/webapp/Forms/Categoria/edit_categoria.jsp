##edit_categoria.jsp
Purpose: Allows administrators to rename existing categories. 
This is particularly useful for correcting typos or updating department names without losing the association with existing products.

Key Features:
Dual-Source Data: It fetches existing names from the database for the selection menu and accepts a manual string for the new name.
Persistent Associations: Since products are usually linked via categoria_id, updating the nome_categoria in the parent table ensures all related products are updated automatically in the UI.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Categories</title>
<link rel="stylesheet" type="text/css" href="Categories_Edit.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Mudar Categoria</h3>
            <form method="post" action="db_edit_cat.jsp" id="Form" onsubmit="return validarFormularioCat()">
                <label for="categoria_before">Categoria:</label>
                <select id="cat_antiga" name="categoria_before">
                    <option value="">Selecione a Categoria</option>
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
                        
                            String sql = "SELECT categoria_id, nome_categoria FROM Categorias";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);
                            
                            while (rs.next()) {
                                int categoriaId = rs.getInt("categoria_id");
                                String nomeCategoria = rs.getString("nome_categoria");
                    %>
                                <option value="<%= nomeCategoria %>"><%= nomeCategoria %></option>
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
                
                <label for="categoria_new">Atualizar Categoria:</label>
                <input type="text" id="cat_nova" name="cat_nova" size="45" required/>
                   
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

    function validarFormularioCat() {
        const categoria_antiga = document.getElementById("cat_antiga").value;
        const categoria_nova = document.getElementById("cat_nova").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (categoria_antiga === "") {
            errorField.innerHTML = "<b>Por favor, selecione uma categoria.</b>";
            return false; 
        }

        if (categoria_nova === "") {
            errorField.innerHTML = "<b>Por favor, preencha o campo de nova categoria.</b>";
            return false; 
        }

        if (categoria_nova.length < 5) {
            errorField.innerHTML = "<b>O nome da categoria deve ter pelo menos 5 caracteres.</b>";
            return false; 
        }
      
        return true;
    }

    </script>
    
</body>
</html>
