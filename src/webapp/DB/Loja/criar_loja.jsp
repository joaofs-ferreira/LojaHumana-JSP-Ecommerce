### db_criar_loja.jsp

This file is responsible for creating a new store (Loja) in the database.

It receives the store location from a form, validates the format, checks if the store already exists, and inserts the new store into the database.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Load Creating Loja...</title>
</head>
<body>
<% 
    String loja = request.getParameter("loja");
    String message = "";
    Connection conn = null;
    PreparedStatement checkstmt = null;
    ResultSet rs = null;
    
    try {
        String url = "jdbc:mysql://localhost:3306/lojahumana";
        String username = "root";
        String password = "15110604web!";
             
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, username, password);
        System.out.println("Conexao com a base de dados estabelecida.");
        
        String[] parts = loja.split("\\|");
        if (parts.length != 2) {
            throw new IllegalArgumentException("Formato de loja invalido. Use o formato 'Cidade - Rua | C�digo Postal'");
        }
        String localizacao = loja.trim();
      
        String checkQuery = "SELECT * FROM Loja WHERE localizacao LIKE ?";
        checkstmt = conn.prepareStatement(checkQuery);
        checkstmt.setString(1, "%" + localizacao + "%");
        rs = checkstmt.executeQuery();

        if (rs.next()) {        
            message = "Esta Loja j� existe.";
        } else {
            String query = "INSERT INTO Loja (localizacao) VALUES (?)";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setString(1, localizacao);
           
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Nova Loja adicionada com sucesso.";
            } else {
                message = "Erro ao adicionar Loja."; 
            }

            ps.close();
        }

        rs.close();
        checkstmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
        message = "Ocorreu um erro: " + e.getMessage();
    }
%>
<div id="correctField"><%= message %></div>
<script>
    var messageField = document.getElementById("correctField");
    if (messageField.innerText === "Nova Loja adicionada com sucesso.") {
        setTimeout(function() {
            window.location.href = 'Loja.jsp';
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
