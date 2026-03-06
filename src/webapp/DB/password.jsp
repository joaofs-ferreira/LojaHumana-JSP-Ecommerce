### db_password.jsp

This file handles the password reset functionality for users.

It receives the email and new password from the password recovery form, verifies if the email exists in the database, and updates the user's password in the `Clientes` table.

Main responsibilities:

- Receive the user's email and new password
- Verify if the email exists in the database
- Update the password associated with the email
- Display a success or error message depending on the operation result
- Redirect the user to the login page after a successful password update

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Process password...</title>
</head>
<body>
<% 
    String _email = request.getParameter("email");
    String _newpass = request.getParameter("pass");
    String message = "";
    
		        try {
		            Class.forName("com.mysql.cj.jdbc.Driver");
		            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");
		
		            String checkQuery = "SELECT * FROM Clientes WHERE email = ?";
		            PreparedStatement checkstmt = conn.prepareStatement(checkQuery);
		            checkstmt.setString(1, _email);
		            ResultSet rs = checkstmt.executeQuery();
		
		            if (rs.next()) {
		                
		                String updateQuery = "UPDATE Clientes SET pwd = ? WHERE email = ?";
		                PreparedStatement ps = conn.prepareStatement(updateQuery);
		                ps.setString(1, _newpass);
		                ps.setString(2, _email);
		
		                int result = ps.executeUpdate();
		
		                if (result > 0) {
		                	 message = "Palavra-passe atualizada com sucesso.";
		                } else {
		                	 message = "Ocorreu um erro ao atualizar a palavra-passe.";
		                }
		
		                ps.close();
		            } else {
		            	message = "Este email n�o est� registado.";
		            }
		
		            rs.close();
		            checkstmt.close();
		            conn.close();
		        } catch (Exception e) {
		            e.printStackTrace();
		            out.print("<h2> Ocorreu um erro: " + e.getMessage() + "</h2>");   
				}
%>
<div id="correctField"><%= message %></div>
<script>
    var messageField = document.getElementById("correctField");
    if (messageField.innerText === "Palavra-passe atualizada com sucesso.") {
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 1000);
    } else {
        setTimeout(function() {
            window.history.back();  
            window.location.reload();
        }, 1000);
    }
</script>
</body>
</html>
