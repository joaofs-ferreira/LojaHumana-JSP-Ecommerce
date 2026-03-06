##Loja.jsp
Purpose: The main display page for stores. 
It lists all active locations retrieved from the database and provides a navigation sub-menu for administrative actions.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Humana Lojas</title>
    <link rel="stylesheet" type="text/css" href="Categoria.css">
</head>
<body>
 <header>
    <div class="logo">
        <a href="HumanaMain.jsp">
            <img src="humana.png" alt="Humana Portugal Logo">
        </a>
    </div>
    <nav>
        <ul class="nav-left">
            <li><a href="HumanaMain.jsp">Home</a></li>
            <li><a href="Loja.jsp">Loja</a></li> 
            <li><a href="Loja_criar.jsp">Criar</a></li> 
            <li><a href="Loja_edit.jsp">Editar</a></li> 
            <li><a class="remove" href="Loja_remove.jsp">Remover</a></li>
        </ul>
        <ul class="nav-right">
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>
</header>
<main>
    <section class="categories">
        <h2>As Nossas Lojas</h2>
        <ul>
            <% 
                Connection conn = null;
                Statement stmt = null;
                ResultSet rs = null;

                try {
                    String url = "jdbc:mysql://localhost:3306/lojahumana";
                    String username = "root";
                    String password = "15110604web!";
                    
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, username, password);
                    System.out.println("Conex�o com a base de dados estabelecida.");
                
                    String sql = "SELECT id_loja, localizacao FROM Loja";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    
                    while (rs.next()) {
                        int Id_loja = rs.getInt("id_loja");
                        String local = rs.getString("localizacao");
            %>
                        <li><%= local %></li>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                   
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </ul>
    </section>
</main>
<footer>
    <p>&copy; 2024 Humana Portugal. Todos os direitos reservados.</p>
</footer>
</body>
</html>

  
