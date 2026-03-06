##carrinho_checkout.jsp
Purpose: The final review page. 
It reconciles the "IDs" stored in the session with the actual "Data" (names/prices) in the database.

Features:
Database Reconciliation: It loops through the session list and performs a SELECT for each produto_id to get current pricing.
Calculation: It calculates the Subtotal ($Preco \times Quantidade$) and a running Grand Total.
Store Selection: Before finishing, users must select a physical store location (Loja) from a dropdown menu populated from the database.

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout Carrinho</title>
    <link rel="stylesheet" type="text/css" href="Carrinho_Checkout.css">
</head>
<body>
    <h3>Lista de Compras</h3>
    <div class="container">
        <div class="cart-table">
            <table>
                <thead>
                    <tr>
                        <th>Produto</th>
                        <th>Quantidade</th>
                        <th>Preço</th>
                        <th>Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <% 
                        List<Map<String, Object>> carrinho = (List<Map<String, Object>>) session.getAttribute("carrinho");
                        double total = 0;
                        Connection conn = null;
                        PreparedStatement pstmt = null;
                        ResultSet rs = null;

                        if (carrinho != null) {
                            try {
                                String url = "jdbc:mysql://localhost:3306/lojahumana";
                                String username = "root";
                                String password = "15110604web!";

                                Class.forName("com.mysql.cj.jdbc.Driver");
                                conn = DriverManager.getConnection(url, username, password);

                                for (Map<String, Object> item : carrinho) {
                                    String produtoId = (String) item.get("produto_id");
                                    int quantidade = Integer.parseInt((String) item.get("quantidade"));

                                    String query = "SELECT nome_produto, preco FROM Produtos WHERE produto_id = ?";
                                    pstmt = conn.prepareStatement(query);
                                    pstmt.setString(1, produtoId);
                                    rs = pstmt.executeQuery();

                                    if (rs.next()) {
                                        String nomeProduto = rs.getString("nome_produto");
                                        double precoUnitario = rs.getDouble("preco");
                                        double subtotal = precoUnitario * quantidade;
                                        total += subtotal;
                    %>
                                        <tr>
                                            <td><%= nomeProduto %></td>
                                            <td><%= quantidade %></td>
                                            <td><%= precoUnitario %> €</td>
                                            <td><%= subtotal %> €</td>
                                        </tr>
                    <% 
                                    } else {
                                        System.out.println("Produto não encontrado: " + produtoId);
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
                            System.out.println("Carrinho está vazio ou não foi encontrado na sessão.");
                    %>
                            <tr>
                                <td colspan="4">Nenhum produto no carrinho.</td>
                            </tr>
                    <% } %>
                </tbody>
            </table>
            <p>Total: <%= total %> €</p>
        </div>
        <div class="login-form">
            <form method="post" action="confirmacao_pedido.jsp" id="Form" onsubmit="return validarFormulario()">
                <label for="loja">Loja:</label>
                <select id="loja" name="loja">
                    <option value="">Selecione a Loja</option>
                    <% 
                        Connection conn2 = null;
                        Statement stmt = null;
                        ResultSet rs2 = null;
                        try {
                            String url = "jdbc:mysql://localhost:3306/lojahumana";
                            String username = "root";
                            String password = "15110604web!";

                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn2 = DriverManager.getConnection(url, username, password);

                            String sql = "SELECT id_loja, localizacao FROM Loja";
                            stmt = conn2.createStatement();
                            rs2 = stmt.executeQuery(sql);

                            while (rs2.next()) {
                                int IdLoja = rs2.getInt("id_loja");
                                String local = rs2.getString("localizacao");
                    %>
                                <option value="<%= IdLoja %>"><%= local %></option>
                    <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs2 != null) try { rs2.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn2 != null) try { conn2.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
                
                <div class="button-container">
                    <button type="submit">Finalizar Compra</button>
                    <button type="reset" id="resetButton">Reset</button>
                </div>
                
                <b>
                    <div id="errorField" style="color: red;"></div>
                </b>
            </form>
        </div>
    </div>
    <footer class="footer">
        <p>© 2024 Humana Portugal. Todos os direitos reservados.</p>
    </footer>
    <script>
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById("resetButton").addEventListener("click", function() {
            document.getElementById("errorField").innerHTML = "";
        });
    });

    function validarFormulario() {
        const loja = document.getElementById("loja").value;
        const errorField = document.getElementById("errorField");

        errorField.innerHTML = "";

        if (loja === "") {
            errorField.innerHTML = "<b>Por favor, selecione uma Loja.</b>";
            return false; 
        }

        return true;
    }
    </script>
</body>
</html>
