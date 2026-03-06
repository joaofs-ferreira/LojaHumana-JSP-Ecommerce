### db_remover_produto.jsp

This file removes a product from the database.

It receives the product ID from the request, checks if the product exists and deletes it from the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Removing Product...</title>
</head>
<body>

<% 
    String produtoId = request.getParameter("produto_selected");
    String message = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");

        String checkQuery = "SELECT * FROM Produtos WHERE produto_id = ?";
        PreparedStatement checkstmt = conn.prepareStatement(checkQuery);
        checkstmt.setString(1, produtoId);
        ResultSet rs = checkstmt.executeQuery();

        if (rs.next()) {
            String deleteQuery = "DELETE FROM Produtos WHERE produto_id = ?";
            PreparedStatement ps = conn.prepareStatement(deleteQuery);
            ps.setString(1, produtoId);
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Produto removido com sucesso.";
            } else {
                message = "Ocorreu um erro ao remover o produto.";
            }

            ps.close();
        } else {
            message = "O produto selecionado n�o existe.";
        }

        rs.close();
        checkstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Ocorreu um erro ao eliminar o Produto: " + e.getMessage();
    }
%>

<div id="messageField"><%= message %></div>

<script>
    var messageField = document.getElementById("messageField");

    if (messageField.innerText === "Produto removido com sucesso.") {
        setTimeout(function() {
            window.location.href = 'Produtos.jsp';
        }, 2000);
    } else {
        setTimeout(function() {
            window.history.back();
            window.location.reload();
        }, 2000);
    }
</script>

</body>
</html>
