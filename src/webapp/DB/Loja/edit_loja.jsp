### db_edit_loja.jsp

This file updates an existing store location in the database.

It receives the store ID and the new location from a form submission, validates the format and updates the store record in the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Change Loja...</title>
</head>
<body>
<% 
    String loja_antiga = request.getParameter("loja_before"); 
    String loja_nova = request.getParameter("loja_nova");
    
    String message = "";
    Connection conn = null;
    PreparedStatement checkstmt = null;
    ResultSet rs = null;
    
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");
        
        String[] parts = loja_nova.split("\\|");
        if (parts.length != 2) {
            throw new IllegalArgumentException("Formato de loja inv�lido. Use o formato 'Cidade - Rua | C�digo Postal'");
        }

        String[] cidadeRua = parts[0].trim().split("-");
        if (cidadeRua.length != 2) {
            throw new IllegalArgumentException("Formato de loja inv�lido. Use o formato 'Cidade - Rua | C�digo Postal'");
        }

        
        String cidade = cidadeRua[0].trim();
        String rua = cidadeRua[1].trim();
        String localizacao = cidade + " - " + rua + " | " + parts[1].trim();

        String checkQuery = "SELECT * FROM Loja WHERE localizacao = ?";
        checkstmt = conn.prepareStatement(checkQuery);
        checkstmt.setString(1, localizacao);
        rs = checkstmt.executeQuery();

        if (rs.next()) {
            message = "A Loja j� existe. N�o � poss�vel atualizar.";
        } else {
            
            String updateQuery = "UPDATE Loja SET localizacao = ? WHERE id_loja = ?";
            PreparedStatement ps = conn.prepareStatement(updateQuery);
            ps.setString(1, localizacao);
            ps.setInt(2, Integer.parseInt(loja_antiga)); 
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Loja atualizada com sucesso.";
            } else {
                message = "Ocorreu um erro ao atualizar a Loja.";
            }

            ps.close();
        }

        rs.close();
        checkstmt.close();
        conn.close();
    } catch (IllegalArgumentException e) {
        message = e.getMessage();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Ocorreu um erro ao atualizar a Loja.";
    }
%>

<div id="messageField"><%= message %></div>

<script>
    var messageField = document.getElementById("messageField");
    
    if (messageField.innerText === "Loja atualizada com sucesso.") {
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
