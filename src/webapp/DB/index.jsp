### db_index.jsp

This file is responsible for processing the user login.

It receives the login credentials submitted from `index.jsp`, connects to the MySQL database and verifies if the provided email and password match an existing user in the `Clientes` table.

Main responsibilities:

- Receive the user email and password from the login form
- Establish a connection to the MySQL database
- Execute a query to validate the user credentials
- Redirect the user to the main page (`HumanaMain.jsp`) if authentication is successful
- Display an error message and redirect back to the login page if authentication fails

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Process Login...</title>
</head>
<body>
    <%
        String _email = request.getParameter("email");
        String _password = request.getParameter("pass");
        String message = "";

            try {
            	Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");
                
                String query = "SELECT * FROM Clientes WHERE email = ? AND pwd = ?";
                PreparedStatement ps = conn.prepareStatement(query);
                ps.setString(1, _email);
                ps.setString(2, _password);

                ResultSet rset = ps.executeQuery();
                
                if (rset.next()) {
                	out.print("<script>window.location.href = 'HumanaMain.jsp';</script>");
                } else {
                	 message = "Ocorreu um erro ao fazer o login";
                }
                
                rset.close();
                ps.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Ocorreu um erro: " + e.getMessage());
            }
    %>
<div id="correctField"><%= message %></div>
<script>
    var messageField = document.getElementById("correctField");
    if (messageField.innerText === "Ocorreu um erro ao fazer o login") {
        setTimeout(function() {
            window.location.href = 'index.jsp';
        }, 1000);
    }
</script>
</body>
</html>
