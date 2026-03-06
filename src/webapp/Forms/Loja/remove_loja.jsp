##remove_loja.jsp
Purpose: Handles store deletion. 
It includes a double-confirmation mechanism (JavaScript confirm) to prevent accidental data loss.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Loja</title>
<link rel="stylesheet" type="text/css" href="edit_categoria.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Remover Loja</h3>
            <form method="post" action="db_remove_loja.jsp" id="Form" onsubmit="return validarFormulario()">
                <label for="loja">Loja:</label>
                <select id="loja" name="loja">
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
                                int Idloja = rs.getInt("id_loja");
                                String local = rs.getString("localizacao");
                    %>
                                <option value="<%= Idloja %>"><%= local %></option>
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
	    function validarFormulario() {
	        const loja = document.getElementById("loja").value;
	        const errorField = document.getElementById("errorField");
	
	        errorField.innerHTML = "";
	
	        if (loja === "") {
	            errorField.innerHTML = "<b>Por favor, selecione uma Loja.</b>";
	            return false; 
	        }
	        
	        return true;
	    }
	
	    function confirmarRemocao() {
	        if (validarFormulario()) {
	            const lojaSelecionada = document.getElementById("loja").value;
	            const confirmacao = confirm("Tem certeza que deseja eliminar a Loja '" + lojaSelecionada + "'?");
	            if (confirmacao) {
	                document.getElementById("Form").submit();
	            }
	        }
	    }
	</script>
</body>
</html>
