### db_criar_cat.jsp

This file is responsible for creating a new category in the database.

It receives the category name from a form, checks if the category already exists, and inserts the new category into the database if it does not exist.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Load Creating Categories...</title>
</head>
<body>
<% 
    String _cat = request.getParameter("categoria");
    String message="";
    Connection conn = null;
    PreparedStatement checkstmt = null;
    ResultSet rs = null;
    
    
    	 try {
    		 
	    		String url = "jdbc:mysql://localhost:3306/lojahumana";
	            String username = "root";
	            String password = "15110604web!";
	             
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            conn = DriverManager.getConnection(url, username, password);
	            System.out.println("Conex�o com a base de dados estabelecida.");

    	      
    	        String checkQuery = "SELECT * FROM Categorias WHERE nome_categoria = ?";
    	        checkstmt = conn.prepareStatement(checkQuery);
    	        checkstmt.setString(1, _cat);
    	        rs = checkstmt.executeQuery();

    	        if (rs.next()) {        
    	        	 message = "Esta Categoria j� existe.";
    	        } else {
    	            
    	            String query = "INSERT INTO Categorias (nome_categoria) VALUES (?)";
    	            PreparedStatement ps = conn.prepareStatement(query);
    	            ps.setString(1, _cat);
    	           

    	            int result = ps.executeUpdate();

    	            if (result > 0) {
    	            	 message = "Nova Categoria adicionada com sucesso.";
    	            } else {
    	            	 message = "Erro ao adicionar Categoria."; 
    	            }

    	            ps.close();
    	        }

    	        rs.close();
    	        checkstmt.close();
    	        conn.close();
    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }
%>
<div id="correctField"><%= message %></div>
<script>
	var messageField = document.getElementById("correctField");
	if (messageField.innerText === "Nova Categoria adicionada com sucesso.") {
	    setTimeout(function() {
	        window.location.href = 'Categoria.jsp';
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

