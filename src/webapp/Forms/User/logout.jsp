##logout.jsp
Purpose: Session termination. This page contains no visible UI; it clears all session data and redirects the user back to the login page.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>loading...</title>
</head>
<body>
<%
	session.removeAttribute("email");
	session.removeAttribute("pass");
	session.invalidate();
	response.sendRedirect("index.jsp");
%>
</body>
</html>
