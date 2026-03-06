##remove_categoria.jsp
Purpose: To safely remove categories from the database. 
This page dynamically populates a dropdown menu with all existing categories currently stored in the lojahumana database.

Safety Mechanisms:
Selection Check: Ensures a category is actually chosen before allowing the delete attempt.
Confirmation Dialog: Triggers a native browser popup asking the user to confirm the deletion of the specific category name.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Categories</title>
<link rel="stylesheet" type="text/css" href="Categories_Edit.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Remover Categoria</h3>
            <form method="post" action="db_remove_cat.jsp" id="Form" onsubmit="return validarFormularioCat()">
                <label for="categoria_before">Categoria:</label>
                <select id="categoria" name="categoria_before">
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
                <div class="button-container">
                    <button type="button" onclick="confirmarRemocao()">Remover</button>
                </div>
                
                <b>
                   <p> <div id="errorField" style="color: red;"> </div> </p> 
                </b>
            </form>
            <div class="footer-logo">
                <img src="humana.png" alt="Humana Portugal Logo">
            </div>
        </div>
    </div>
   <script>
	    function validarFormularioCat() {
	        const categoria = document.getElementById("categoria").value;
	        const errorField = document.getElementById("errorField");
	
	        errorField.innerHTML = "";
	
	        if (categoria === "") {
	            errorField.innerHTML = "<b>Por favor, selecione uma categoria.</b>";
	            return false; 
	        }
	        
	        return true;
	    }
	
	    function confirmarRemocao() {
	        if (validarFormularioCat()) {
	            const categoriaSelecionada = document.getElementById("categoria").value;
	            const confirmacao = confirm("Tem certeza que deseja eliminar a categoria '" + categoriaSelecionada + "'?");
	            if (confirmacao) {
	                document.getElementById("Form").submit();
	            }
	        }
	    }
	</script>
	</body>
</html>
