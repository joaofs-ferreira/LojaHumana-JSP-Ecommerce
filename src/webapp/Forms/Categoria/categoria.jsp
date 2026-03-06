##categoria.jsp
Purpose: This page functions as a catalog view that emphasizes the relationship between products and their categories. 
It displays all current products and their assigned category names using a SQL INNER JOIN.

Key Technical Detail: The query uses c.nome_categoria from the Categorias table linked via categoria_id. 
This ensures that if a category name is updated, it reflects instantly across all products in this view.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Humana Categorias</title>
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
            <li><a href="Categoria.jsp">Categoria</a></li> 
            <li><a href="categoria_criar.jsp">Criar</a></li> 
            <li><a href="categoria_edit.jsp">Editar</a></li> 
            <li><a class="remove" href="categoria_remove.jsp">Remover</a></li>
        </ul>
        <ul class="nav-right">
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>
</header>
<main>
    <section class="categories">
        <h2>As Nossas Categorias</h2>
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
                
                    String sql = "SELECT categoria_id, nome_categoria FROM Categorias";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    
                    while (rs.next()) {
                        int categoriaId = rs.getInt("categoria_id");
                        String nomeCategoria = rs.getString("nome_categoria");
            %>
                        <li><%= nomeCategoria %></li>
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
