### db_registo.jsp

This file processes the user registration.

It receives the registration form data and inserts a new user into the `Clientes` table if the email does not already exist.

Main responsibilities:

- Receive the username, email and password from the registration form
- Connect to the MySQL database
- Check if the email is already registered
- Insert a new user record into the `Clientes` table
- Display success or error messages depending on the operation result
- Redirect the user to the login page after successful registration

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Process Register...</title>
</head>
<body>
<% 
    String _username = request.getParameter("username");
    String _pwd = request.getParameter("pass");
    String _email = request.getParameter("email");
    String message="";
    
    	 try {
    	        Class.forName("com.mysql.cj.jdbc.Driver");
    	        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");

    	        String checkQuery = "SELECT * FROM Clientes WHERE email = ?";
    	        PreparedStatement checkstmt = conn.prepareStatement(checkQuery);
    	        checkstmt.setString(1, _email);
    	        ResultSet rs = checkstmt.executeQuery();

    	        if (rs.next()) {
    	            
    	        	 message = "Este email já existe.";
    	        } else {
    	            
    	            String query = "INSERT INTO Clientes (username, pwd, email) VALUES (?, ?, ?)";
    	            PreparedStatement ps = conn.prepareStatement(query);
    	            ps.setString(1, _username);
    	            ps.setString(2, _pwd);
    	            ps.setString(3, _email);

    	            int result = ps.executeUpdate();

    	            if (result > 0) {
    	            	 message = "Registo realizado com sucesso.";
    	            } else {
    	            	 message = "Erro no registo, verifique email e password"; 
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
	if (messageField.innerText === "Registo realizado com sucesso.") {
	    setTimeout(function() {
	        window.location.href = 'index.jsp';
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
