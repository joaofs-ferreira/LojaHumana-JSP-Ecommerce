##produto.jsp
Purpose: The catalog view. It displays all products from the database using an INNER JOIN with the Categorias table to show category names instead of IDs. 
It includes a JavaScript function to handle "Add to Cart" functionality via dynamic form submission.

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Humana Produtos</title>
    <link rel="stylesheet" type="text/css" href="Produto.css">
    <script>
	    window.onload = function() {
	        var adicionarCarrinhoBtn = document.querySelector('.btn-add');
	        var form = document.getElementById('Form');
	        var produtoIdInput = document.getElementById('produto_id');
	
	        adicionarCarrinhoBtn.addEventListener('click', function() {
	            var produtoId = this.getAttribute('data-produto-id');
	            produtoIdInput.value = produtoId;
	            form.submit();
	        });
	    };
    
        function adicionarAoCarrinho(produtoId) {
            var form = document.createElement('form');
            form.setAttribute('method', 'post');
            form.setAttribute('action', 'add_carrinho.jsp');

            var inputProdutoId = document.createElement('input');
            inputProdutoId.setAttribute('type', 'hidden');
            inputProdutoId.setAttribute('name', 'produto_id');
            inputProdutoId.setAttribute('value', produtoId);

            form.appendChild(inputProdutoId);

            document.body.appendChild(form);
            form.submit();
        }
    </script>

    </script>
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
            <li><a href="Produtos.jsp">Produtos</a></li> 
            <li><a href="produto_criar.jsp">Criar</a></li> 
            <li><a href="produto_edit.jsp">Editar</a></li> 
            <li><a class="remove" href="produto_remove.jsp">Remover</a></li> 
        </ul>
        <ul class="nav-right">
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </nav>
</header>
<main>
    <section class="produtos">
        <h2>Os nossos Produtos</h2>
        <div class="produtos-container">
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
                    System.out.println("Conexão com a base de dados estabelecida.");
                
                    String sql = "SELECT p.produto_id, p.nome_produto, p.preco, p.quantidade_stock, c.nome_categoria ";
                    sql += "FROM Produtos p ";
                    sql += "INNER JOIN Categorias c ON p.categoria_id = c.categoria_id";
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(sql);
                    
                    while (rs.next()) {
                        String produtoId = rs.getString("produto_id");
                        String nomeProduto = rs.getString("nome_produto");
                        double preco = rs.getDouble("preco");
                        int qty = rs.getInt("quantidade_stock");
                        String nomeCategoria = rs.getString("nome_categoria");
            %>
                        <div class="produto-box">
                            <div class="detalhes-produto">
                                <p class="nome-produto"><%= nomeProduto %></p>
                                <p class="preco-produto">Preço: <%= preco %> €</p>
                                <p class="estoque-produto">Estoque: <%= qty %></p>
                                <p class="categoria-produto">Categoria: <%= nomeCategoria %></p>
                                <button class="editar-btn" onclick="adicionarAoCarrinho('<%= produtoId %>')">Adicionar</button>                               
                            </div>
                        </div>
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
        </div>
    </section>
</main>
<footer>
    <p>&copy; 2024 Humana Portugal. Todos os direitos reservados.</p>
</footer>
</body>
</html>
