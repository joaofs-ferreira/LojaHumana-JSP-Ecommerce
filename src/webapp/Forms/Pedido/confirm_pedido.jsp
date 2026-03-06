##confirmacao_pedido.jsp
Purpose: This is the "Review" stage before the database is modified. 
It serves two critical roles:

Summary: It recalculates the final total one last time to ensure accuracy.
User Identification: It pulls the user's name and email from the session (likely set during login) and displays them in a form.

Technical Flow:
It performs a look-up on the Produtos table to get the most recent price.
It provides a final submit button that triggers the actual database "Write" operation.

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmation Order</title>
    <link rel="stylesheet" type="text/css" href="confirm_order.css">
</head>
<body>
    <h3>Itens no Carrinho</h3>
    <table>
        <thead>
            <tr>
                <th>Produto</th>
                <th>Quantidade</th>
                <th>Preço Unitário</th>
                <th>Subtotal</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Map<String, Object>> carrinho = (List<Map<String, Object>>) session.getAttribute("carrinho");
                double total = 0;
                if (carrinho != null) {
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    try {
                        String url = "jdbc:mysql://localhost:3306/lojahumana";
                        String username = "root";
                        String password = "15110604web!";
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, username, password);
                        
                        for (Map<String, Object> item : carrinho) {
                            String produtoId = (String) item.get("produto_id");
                            int quantidade = Integer.parseInt((String) item.get("quantidade"));
                            
                            
                            String query = "SELECT preco FROM Produtos WHERE produto_id = ?";
                            pstmt = conn.prepareStatement(query);
                            pstmt.setString(1, produtoId);
                            rs = pstmt.executeQuery();
                            if (rs.next()) {
                                double precoUnitario = rs.getDouble("preco");
                                double subtotal = precoUnitario * quantidade;
                                total += subtotal;
            %>
                                <tr>
                                    <td>Produto <%= produtoId %></td>
                                    <td><%= quantidade %></td>
                                    <td><%= precoUnitario %> €</td>
                                    <td><%= subtotal %> €</td>
                                </tr>
            <% 
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                } else {
            %>
                    <tr>
                        <td colspan="4">Nenhum produto no carrinho.</td>
                    </tr>
            <% } %>
        </tbody>
    </table>
    <p>Total: <%= total %> €</p>
    
    
    <h3>Detalhes do Cliente</h3>
    <form action="finalizar_pedido.jsp" method="post">
        <label for="nome">Nome:</label>
        <input type="text" id="nome" name="nome" value="<%= session.getAttribute("nome_cliente") %>" required>
        <br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="<%= session.getAttribute("email_cliente") %>" required>
        <br>
        <input type="submit" value="Finalizar Pedido">
    </form>
    
</body>
</html>
