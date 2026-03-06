##HumanaMain.jsp
Purpose: This is the Main Dashboard. 
It uses JDBC to fetch dynamic data from MySQL and displays the cheapest products and categories using a carousel.

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String nomeCliente = "";
    String emailCliente = ""; 
    
    session.setAttribute("username", nomeCliente);
    session.setAttribute("email", emailCliente);
   
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Humana Main</title>
    <link rel="stylesheet" type="text/css" href="MainPage.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick-theme.css">
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
                <li><a href="Produtos.jsp">Produtos</a></li>
                <li><a href="Categoria.jsp">Categorias</a></li>
                <li><a href="Loja.jsp">Lojas</a></li>
                <li><a href="Pedidos.jsp">Pedidos</a></li>
            </ul>
            <ul class="nav-right">
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section class="hero">
            <div class="carousel">       
                <div><img src="img/teste2.jpg" alt="Slide 1"></div>
                <div><img src="img/castanha.jpg" alt="Slide 2"></div>
                <div><img src="img/sun.jpg" alt="Slide 3"></div>       
                <div><img src="img/summer.jpg" alt="Slide 4"></div>
                <div><img src="img/teste5.jpg" alt="Slide 5"></div>
            </div>   
        </section>
        <section class="products">
            <h2>Os produtos mais baratos</h2>
            <div class="produtos-container">
                <% 
                    try {
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");
                        String sql = "SELECT nome_produto, preco, quantidade_stock FROM Produtos ORDER BY preco ASC LIMIT 4";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);
                        while (rs.next()) {
                            String nomeProduto = rs.getString("nome_produto");
                            double precoProduto = rs.getDouble("preco");
                            int quantidadeProduto = rs.getInt("quantidade_stock");
                %>
                            <div class="produto-box">
                                <div class="detalhes-produto">
                                    <p class="nome-produto"><%= nomeProduto %></p>
                                    <p class="preco-produto">Preço: <%= precoProduto %> &euro;</p>
                                    <p class="estoque-produto">Estoque: <%= quantidadeProduto %></p>
                                </div>
                            </div>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
             <h4><a href="Produtos.jsp">Todos os Produtos</a></h4>
        </section>
        <section class="categories">
            <h2>Categorias Principais</h2>
            <div class="category-images">
                <% 
                    try {
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/lojahumana", "root", "15110604web!");
                        String sql = "SELECT nome_categoria FROM Categorias LIMIT 3";
                        Statement stmt = conn.createStatement();
                        ResultSet rs = stmt.executeQuery(sql);
                        while (rs.next()) {
                            String nomeCategoria = rs.getString("nome_categoria");
                %>
                            <div class="categoria">
                                <h3><%= nomeCategoria %></h3>
                            </div>
                <%
                        }
                        rs.close();
                        stmt.close();
                        conn.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                %>
            </div>
            <h4><a href="Categoria.jsp">Todas as Categorias</a></h4>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Humana Portugal. Todos os direitos reservados.</p>
    </footer>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.8.1/slick.min.js"></script>
    <script>
        $(document).ready(function(){
            $('.carousel').slick({
                autoplay: true,
                autoplaySpeed: 2000,
                dots: true
            });
        });
    </script>
</body>
</html>
