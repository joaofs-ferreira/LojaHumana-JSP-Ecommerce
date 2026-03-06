### db_remove_categoria.jsp

This file removes a category from the database.

It checks if the selected category exists and deletes it from the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Removing Categories...</title>
</head>
<body>

<% 
    String categoria = request.getParameter("categoria_before");
    String message = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");

        String checkQuery = "SELECT * FROM Categorias WHERE nome_categoria = ?";
        PreparedStatement checkstmt = conn.prepareStatement(checkQuery);
        checkstmt.setString(1, categoria);
        ResultSet rs = checkstmt.executeQuery();

        if (rs.next()) {
           
            String deleteQuery = "DELETE FROM Categorias WHERE nome_categoria = ?";
            PreparedStatement ps = conn.prepareStatement(deleteQuery);
            ps.setString(1, categoria);
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Categoria removida com sucesso.";
            } else {
                message = "Ocorreu um erro ao remover a categoria.";
            }

            ps.close();
        } else {
            message = "A categoria selecionada n�o existe.";
        }

        rs.close();
        checkstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Ocorreu um erro ao eliminar a Categoria.";
    }
%>

<div id="messageField"><%= message %></div>

<script>
    var messageField = document.getElementById("messageField");
    
    if (messageField.innerText === "Categoria removida com sucesso.") {
        setTimeout(function() {
            window.location.href = 'Categoria.jsp';
        }, 2000);
    }
</script>

</body>
</html>
