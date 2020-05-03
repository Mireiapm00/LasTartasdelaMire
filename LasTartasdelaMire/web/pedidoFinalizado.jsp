<%-- 
    Document   : pedidoFinalizado
    Created on : 02-may-2020, 23:03:56
    Author     : Mireia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./css/estilos_carrito.css" rel="stylesheet" type="text/css">
        <%
            if(session.getAttribute("estadoPedido").equals("tramitado")){
        %>
                <meta http-equiv="refresh" content='4;url=http://localhost:8080/LasTartasdelaMire/index.html'>
        <%
            }
        %>
    </head>
    <body>
        <%
        if(session.getAttribute("estadoPedido").equals("tramitado")){
            
        %>
            <h2>Pedido finalizado</h2>
            <div class="bodyCheckPedido">
                <img class="logo" src="./images/logos/logotienda.jpeg" alt="Logo tienda">
                <h3>Gracias por su compra :)</h3><br><br>
                <h5>En 3s se va a mover al inicio de nuestra web! </h5>
            </div>
        <%
            }
            if(session.getAttribute("estadoPedido").equals("cancelado")){
        %>
                <h2>Pedido cancelado</h2>
                <div class="bodyCheckPedido">
                    <img class="logo" src="./images/logos/logotienda.jpeg" alt="Logo tienda">
                    <input type="submit" class="button3" onclick="Cargar('carrito.jsp', 'cuerpo')" value="Carrito"/>
                    <h3>Vuelva a visitarnos pronto! :)</h3><br><br>
                    <h5>En 3s se va a mover al inicio de nuestra web!</h5>
                </div>
        <%
            }

            session.removeAttribute("estadoPedido");
        %>
    </body>
</html>
