##Pedidos.jsp
Purpose: This acts as the user's order history dashboard.
Current State: It provides the visual framework (header/footer) for the user to view their past transactions.
Database Integration: To make this functional, you will eventually need a SELECT query that filters the Pedidos table by the current user's cliente_id.

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Humana Pedidos</title>
    <link rel="stylesheet" type="text/css" href="Pedidos.css">
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
                <li><a href="Pedidos.jsp">Pedidos</a></li> 
            </ul>
            <ul class="nav-right">
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <section class="products">
            <h2> Seus Pedidos </h2>
        </section>
    </main>
    <footer>
        <p>&copy; 2024 Humana Portugal. Todos os direitos reservados.</p>
    </footer>
</body>
</html>
