##remove_produto.jsp
Purpose: Deletion interface. 
It uses a JavaScript confirm() dialog to ensure the administrator intended to remove the specific product.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Product</title>
<link rel="stylesheet" type="text/css" href="Categories_Edit.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Remover Produto</h3>
            <form method="post" action="db_remove_product.jsp" id="Form" onsubmit="return validarFormulario()">
                <label for="produto_selected">Produto:</label>
                <select id="produto" name="produto_selected">
                    <option value="">Selecione o Produto</option>
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
                        
                            String sql = "SELECT produto_id, nome_produto FROM Produtos";
                            stmt = conn.createStatement();
                            rs = stmt.executeQuery(sql);
                            
                            while (rs.next()) {
                                int produtoId = rs.getInt("produto_id");
                                String nomeProduto = rs.getString("nome_produto");
                    %>
                                <option value="<%= produtoId %>"><%= nomeProduto %></option>
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
                    <p><div id="errorField" style="color: red;"></div></p> 
                </b>
            </form>
            <div class="footer-logo">
                <img src="humana.png" alt="Humana Portugal Logo">
            </div>
        </div>
    </div>
    <script>
        function validarFormulario() {
            const produto = document.getElementById("produto").value;
            const errorField = document.getElementById("errorField");

            errorField.innerHTML = "";

            if (produto === "") {
                errorField.innerHTML = "<b>Por favor, selecione um Produto.</b>";
                return false; 
            }
            
            return true;
        }

        function confirmarRemocao() {
            if (validarFormulario()) {
                const produtoSelect = document.getElementById("produto").options[document.getElementById("produto").selectedIndex].text;
                const confirmacao = confirm("Tem certeza que deseja eliminar o produto '" + produtoSelect + "'?");
                if (confirmacao) {
                    document.getElementById("Form").submit();
                }
            }
        }
    </script>
</body>
</html>
