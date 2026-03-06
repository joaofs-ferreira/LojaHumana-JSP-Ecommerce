### db_remove_loja.jsp

This file removes a store from the database.

It receives the store ID from the request, verifies that the store exists and deletes it from the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Removing Loja...</title>
</head>
<body>

<% 
    String loja = request.getParameter("loja");
    String message = "";
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");

        String checkQuery = "SELECT * FROM Loja WHERE id_loja = ?";
        PreparedStatement checkstmt = conn.prepareStatement(checkQuery);
        checkstmt.setInt(1, Integer.parseInt(loja));
        ResultSet rs = checkstmt.executeQuery();

        if (rs.next()) {
           
            String deleteQuery = "DELETE FROM Loja WHERE id_loja = ?";
            PreparedStatement ps = conn.prepareStatement(deleteQuery);
            ps.setInt(1, Integer.parseInt(loja));
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Loja removida com sucesso.";
            } else {
                message = "Ocorreu um erro ao remover a loja.";
            }

            ps.close();
        } else {
            message = "A Loja selecionada n�o existe.";
        }

        rs.close();
        checkstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Ocorreu um erro ao eliminar a Loja.";
    }
%>

<div id="messageField"><%= message %></div>

<script>
    var messageField = document.getElementById("messageField");
    
    if (messageField.innerText === "Loja removida com sucesso.") {
        setTimeout(function() {
            window.location.href = 'Loja.jsp';
        }, 2000);
    } else {
	    setTimeout(function() {
	        window.history.back();
	        window.location.reload();
	    }, 3000); 
	} 
</script>

</body>
</html>
