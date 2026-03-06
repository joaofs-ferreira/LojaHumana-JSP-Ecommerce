### db_criar_produto.jsp

This file is responsible for creating a new product in the database.

It receives the product information from a form (category, name, price and quantity), checks if the product already exists, and inserts the new product into the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Creating Products...</title>
</head>
<body>
<% 
    String _cat = request.getParameter("categoria");
    String name_product = request.getParameter("nome_produto");
    String preco =  request.getParameter("preco_produto");
    String qty =  request.getParameter("qty_produto");

    String message="";
    Connection conn = null;
    PreparedStatement checkstmt = null;
    ResultSet rs = null;
    
    try {
        if (_cat != null && name_product != null && preco != null && qty != null) {
            int cat = Integer.parseInt(_cat);
            double precoProduto = Double.parseDouble(preco);
            int quantidade = Integer.parseInt(qty);

            String url = "jdbc:mysql://localhost:3306/lojahumana";
            String username = "root";
            String password = "15110604web!";
             
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("Conex�o com a base de dados estabelecida.");

            String checkQuery = "SELECT * FROM Produtos WHERE nome_produto = ?";
            checkstmt = conn.prepareStatement(checkQuery);
            checkstmt.setString(1, name_product);
            rs = checkstmt.executeQuery();

            if (rs.next()) {        
                message = "Este Produto j� existe.";
            } else {
                String query = "INSERT INTO Produtos (nome_produto, preco, quantidade_stock, categoria_id) VALUES (?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, name_product);
                ps.setDouble(2, precoProduto); 
                ps.setInt(3, quantidade); 
                ps.setInt(4, cat); 

                int result = ps.executeUpdate();

                if (result > 0) {
                    message = "Novo Produto adicionado com sucesso.";
                } else {
                    message = "Erro ao adicionar Produto."; 
                }

                ps.close();
            }

            rs.close();
            checkstmt.close();
            conn.close();
        } else {
            message = "Erro ao adicionar Produto: par�metros inv�lidos.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "Erro ao adicionar Produto: " + e.getMessage();
    }
%>
<div id="correctField"><%= message %></div>
<script>
    var messageField = document.getElementById("correctField");
    if (messageField.innerText === "Novo Produto adicionado com sucesso.") {
        setTimeout(function() {
            window.location.href = 'Produtos.jsp';
        }, 3000); 
    } else {
        setTimeout(function() {
            window.history.back();
            window.location.reload();
        }, 3000); 
    } 
</script>
</body>
</html>
