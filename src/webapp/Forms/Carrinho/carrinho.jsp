##carrinho.jsp
Purpose: This page processes the logic of adding an item to the session.

Key Technical Mechanism: Session Storage
The cart is stored as a List of Maps. This allows the application to "remember" items without writing to the database yet.

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Shopping Humana</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="Carrinho.css">
</head>
<body>
    <% 
        String produtoId = request.getParameter("produto_id");
      
        List<Map<String, Object>> carrinho = (List<Map<String, Object>>) session.getAttribute("carrinho");
        if (carrinho == null) {
            
            carrinho = new ArrayList<>();
          
            session.setAttribute("carrinho", carrinho);
        }
        
        
        String quantidade = request.getParameter("quantidade");
      
        if (produtoId != null) {
            Map<String, Object> item = new HashMap<>();
            item.put("produto_id", produtoId);
            item.put("quantidade", quantidade);
            carrinho.add(item);
        }
    %>
    <p>Produto adicionado ao carrinho com sucesso.</p>
    <div class="button-container">
        <button class="btn-add"><a href="Produtos.jsp"> Continuar a Comprar </a></button>
        <button class="btn-add"><a href="carrinho_checkout.jsp"> Finalizar Compra </a></button>
    </div>
</body>
</html>
