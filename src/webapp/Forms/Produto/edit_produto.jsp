##edit_produto.jsp
Purpose: Administrative tool to update existing product info. 
It allows changing the name, price, stock, and category of a selected item.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Product...</title>
<link rel="stylesheet" type="text/css" href="add_produto.css">
</head>
<body>
    <div class="login-container">
        <div class="login-form">
            <h3>Editar Produto</h3>
            <form method="post" action="db_edit_product.jsp" id="Form" onsubmit="return validarFormulario()">
            
                <label for="Produto_before">Produto:</label>
                <select id="produto_antiga" name="produto_before">
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
                
                <label for="nom_prod">Novo Nome:</label>
                <input type="text" id="produtonome" name="name_p" size="45"/>
                
                <label for="pr_prod">Novo Pre�o:</label>
                <input type="number" id="produtopreco" name="preco_p" size="45"/>
                
                <label for="qun_prod">Nova Quantidade:</label>
                <input type="number" id="produtoqty" name="qty_p" size="45"/>
                
                <label for="categoria_new">Nova Categoria:</label>
                <select id="cat_nova" name="categoria_nova">
                    <option value="">Selecione a Categoria</option>
                    <% 
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
        const produtoId = document.getElementById("produto_antiga").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (produtoId === "") {
            errorField.innerHTML = "<b>Selecione um Produto.</b>";
            return false; 
        }

        return true;
    }
    </script>
    
</body>
</html>
