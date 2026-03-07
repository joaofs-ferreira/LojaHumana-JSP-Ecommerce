##finalizar_pedido.jsp 
Purpose: This file contains the logic to convert the session-based cart into permanent database rows. 

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Finalizar Pedido</title>
</head>
<body>
    <%
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        List<Map<String, Object>> carrinho = (List<Map<String, Object>>) session.getAttribute("carrinho");

        if (carrinho == null || carrinho.isEmpty()) {
    %>
            <h2>O carrinho está vazio!</h2>
    <%
        } else {
            Connection conn = null;
            PreparedStatement psPedido = null;
            PreparedStatement psItemPedido = null;
            PreparedStatement psPreco = null;
            ResultSet rsKeys = null;
            
            try {
                String url = "jdbc:mysql://localhost:3306/lojahumana";
                String username = "root";
                String password = "15110604web!";
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, username, password);
                conn.setAutoCommit(false);

                double totalReal = 0;
                String queryP = "SELECT preco FROM Produtos WHERE produto_id = ?";
                psPreco = conn.prepareStatement(queryP);

                for (Map<String, Object> item : carrinho) {
                    psPreco.setString(1, (String) item.get("produto_id"));
                    ResultSet rsP = psPreco.executeQuery();
                    if (rsP.next()) {
                        int qtd = Integer.parseInt((String) item.get("quantidade"));
                        totalReal += (rsP.getDouble("preco") * qtd);
                    }
                    rsP.close();
                }

                // Inserir Pedido
                String sqlPedido = "INSERT INTO Pedidos (data_pedido, total_pedido, cliente_id) VALUES (NOW(), ?, ?)";
                psPedido = conn.prepareStatement(sqlPedido, Statement.RETURN_GENERATED_KEYS);
                psPedido.setDouble(1, totalReal);
                psPedido.setInt(2, 1); 
                psPedido.executeUpdate();
                
                rsKeys = psPedido.getGeneratedKeys();
                int pedidoId = 0;
                if (rsKeys.next()) pedidoId = rsKeys.getInt(1);

                // Inserir Itens
                String sqlItens = "INSERT INTO ItensPedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES (?, ?, ?, ?)";
                psItemPedido = conn.prepareStatement(sqlItens);

                for (Map<String, Object> item : carrinho) {
                    String pId = (String) item.get("produto_id");
                    int q = Integer.parseInt((String) item.get("quantidade"));
                    
                    psPreco.setString(1, pId);
                    ResultSet rsP = psPreco.executeQuery();
                    double pUnit = 0;
                    if(rsP.next()) pUnit = rsP.getDouble("preco");
                    rsP.close();

                    psItemPedido.setInt(1, pedidoId);
                    psItemPedido.setString(2, pId);
                    psItemPedido.setInt(3, q);
                    psItemPedido.setDouble(4, pUnit);
                    psItemPedido.executeUpdate();
                }

                conn.commit();
                session.removeAttribute("carrinho");
    %>
                <h2>Pedido #<%= pedidoId %> finalizado com sucesso!</h2>
                <p>Obrigado pela compra, <%= nome %>.</p>
    <%
            } catch (Exception e) {
                if (conn != null) try { conn.rollback(); } catch (SQLException ex) {}
                e.printStackTrace();
    %>
                <h2>Erro ao processar pedido.</h2>
    <%
            } finally {
                if (rsKeys != null) rsKeys.close();
                if (psPreco != null) psPreco.close();
                if (psPedido != null) psPedido.close();
                if (psItemPedido != null) psItemPedido.close();
                if (conn != null) conn.close();
            }
        }
    %>
    <script>
        setTimeout(function() { window.location.href = 'HumanaMain.jsp'; }, 3000);
    </script>
</body>
</html>
