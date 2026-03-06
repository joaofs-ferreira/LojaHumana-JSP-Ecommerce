##add_carrinho.jsp
Purpose: A bridge interface between the product list and the cart.
It captures the produto_id from the previous page.
It allows the user to specify a quantity (defaulting to 1).
  
JavaScript Transition: Instead of a standard form submit, it uses a custom function to append parameters to the URL:
window.location.href = 'carrinho.jsp?produto_id=' + produtoId + '&quantidade=' + quantidade;

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Adicionar ao Carrinho</title>
    <link rel="stylesheet" type="text/css" href="Carrinho.css">
</head>
<body>
  	<div class="login-container">
        <div class="login-form">
		    <h2>Adicionar ao Carrinho</h2>
		    <form id="Form">
		        <label for="quantidade">Quantidade:</label>
		        <input type="number" id="quantidade" name="quantidade" value="1" min="1">
		        <input type="hidden" id="produto_id" name="produto_id" value="<%= request.getParameter("produto_id") %>">
		        <button class="btn-add" type="button" onclick="adicionarAoCarrinho()">Adicionar ao Carrinho</button>
		    </form>
		  </div>
		</div>
	<footer>
	    <p>&copy; 2024 Humana Portugal. Todos os direitos reservados.</p>
	</footer>
    <script>
        function adicionarAoCarrinho() {
            var quantidade = document.getElementById('quantidade').value;
            var produtoId = document.getElementById('produto_id').value;
            window.location.href = 'carrinho.jsp?produto_id=' + produtoId + '&quantidade=' + quantidade;
        }
    </script>
</body>
</html>
