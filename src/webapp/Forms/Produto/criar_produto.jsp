##criar_produto.jsp
Purpose: Form to register new inventory items. 
It features a dynamic dropdown that pulls existing categories from the database to ensure data integrity.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Produto Register</title>
<link rel="stylesheet" type="text/css" href="add_produto.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h2>Novo Produto</h2>
            <form id="Form" action="db_criar_produto.jsp" onsubmit="return validarFormulario()">
                <label for="nomeproduto">Produto: </label>
                <input type="text" id="n_produto" name="nome_produto" size="45" required/>
                
                <label for="precoproduto">Pre�o: </label>
                <input type="number" id="p_produto" name="preco_produto" size="45" required/>
                
                <label for="qtyproduto">Quantidade: </label>
                <input type="number" id="q_produto" name="qty_produto" size="45" required/>
                
        		 <label for="categoria">Categoria:</label>
                <select id="categoria" name="categoria">
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
                                <option value="<%= categoriaId %>"><%= nomeCategoria %></option>
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
        const name_product = document.getElementById("n_produto").value;
        const preco = document.getElementById("p_produto").value;
        const qty = document.getElementById("q_produto").value;
        const categoria = document.getElementById("categoria").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (name_product === "" || preco === "" || qty === "" ) {
            errorField.innerHTML = "<b>Por favor, preencha todos os campos.</b>";
            return false; 
        }
        
        if(categoria === ""){
        	errorField.innerHTML = "<b>Seleciona uma Categoria. </b>";
            return false; 
        }
        
        if(name_product < 5){
        	errorField.innerHTML = "<b>Nome do produto deve ser maior que 5 caracteres.</b>";
            return false; 
        }
        
        if(preco <= 1 ){
        	errorField.innerHTML = "<b>Introduza um pre�o v�lido. </b>";
            return false; 
        }
        
        if(qty <= 0 ){
        	errorField.innerHTML = "<b>Introduza uma quatidade v�lida. </b>";
            return false; 
        }
        
        return true;
    }
    </script>
</body>
</html>
