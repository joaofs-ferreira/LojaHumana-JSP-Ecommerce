### db_editar_produto.jsp

This file updates an existing product in the database.

It receives the product ID and the new product information from a form submission and updates the product record.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Updating Product...</title>
</head>
<body>
<% 
    String produtoIdStr = request.getParameter("produto_before");
    String name_product = request.getParameter("name_p");
    String precoStr = request.getParameter("preco_p");
    String qtyStr = request.getParameter("qty_p");
    String catStr = request.getParameter("categoria_nova");

    String message = "";
    Connection conn = null;
    PreparedStatement ps = null;
    PreparedStatement selectStmt = null;
    ResultSet rs = null;
    
    try {
        if (produtoIdStr != null && !produtoIdStr.isEmpty()) {
            int produtoId = Integer.parseInt(produtoIdStr);

            String url = "jdbc:mysql://localhost:3306/lojahumana";
            String username = "root";
            String password = "15110604web!";
             
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, username, password);

            // Get current product details
            String selectQuery = "SELECT nome_produto, preco, quantidade_stock, categoria_id FROM Produtos WHERE produto_id = ?";
            selectStmt = conn.prepareStatement(selectQuery);
            selectStmt.setInt(1, produtoId);
            rs = selectStmt.executeQuery();

            if (rs.next()) {
                String currentName = rs.getString("nome_produto");
                double currentPreco = rs.getDouble("preco");
                int currentQty = rs.getInt("quantidade_stock");
                int currentCat = rs.getInt("categoria_id");

                // Update only the non-empty fields
                String updateQuery = "UPDATE Produtos SET nome_produto = ?, preco = ?, quantidade_stock = ?, categoria_id = ? WHERE produto_id = ?";
                ps = conn.prepareStatement(updateQuery);
                ps.setString(1, name_product != null && !name_product.isEmpty() ? name_product : currentName);
                ps.setDouble(2, precoStr != null && !precoStr.isEmpty() ? Double.parseDouble(precoStr) : currentPreco);
                ps.setInt(3, qtyStr != null && !qtyStr.isEmpty() ? Integer.parseInt(qtyStr) : currentQty);
                ps.setInt(4, catStr != null && !catStr.isEmpty() ? Integer.parseInt(catStr) : currentCat);
                ps.setInt(5, produtoId);

                int result = ps.executeUpdate();

                if (result > 0) {
                    message = "Produto atualizado com sucesso.";
                } else {
                    message = "Erro ao atualizar o produto.";
                }
            } else {
                message = "Produto n�o encontrado.";
            }
        } else {
            message = "Erro ao atualizar o produto: par�metros inv�lidos.";
        }
    } catch (Exception e) {
        e.printStackTrace();
        message = "Erro ao atualizar o produto: " + e.getMessage();
    } finally {
        try {
            if (rs != null) rs.close();
            if (selectStmt != null) selectStmt.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>
<div id="messageField"><%= message %></div>
<script>
    var messageField = document.getElementById("messageField");
    if (messageField.innerText === "Produto atualizado com sucesso.") {
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
