<%-- 
    Document   : pedidoFinalizado
    Created on : 02-may-2020, 23:03:56
    Author     : Mireia
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="p2.AccesoBD"%>
<script src="js/libCapas.js" type="text/javascript"></script>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./css/estilos_carrito.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        
        <%
            AccesoBD con = new AccesoBD();
            ResultSet infoPedido = con.obtenerUltimoPedidoBD();
            infoPedido.next();
            int id_pedido = infoPedido.getInt("id_pedido");
            
            if(session.getAttribute("estadoPedido").equals("Pendiente")){
            
        %>
                <h2>Pedido finalizado</h2>
                <div class="bodyCheckPedido">
                    <img class="logo" src="./images/logos/logotienda.jpeg" alt="Logo tienda">
                    <h3>Gracias por su compra :)</h3>
                    <hl></hl>
                    <div class="insideCheckPedido">
                        <h4>Identificador del pedido: <%=id_pedido%></h4><br>
                        <p>El pedido se entregará en los próximos días!</p><br>
                        <input type="submit" class="button3" onclick="Cargar('index.html', 'cuerpo')" value="Ir al inicio"/>
                    </div>
                </div>
        <%
            }
            if(session.getAttribute("estadoPedido").equals("Cancelado")){
            //NO SE UTILIZA
        %>
                <h2>Pedido cancelado</h2>
                <div class="bodyCheckPedido">
                    <img class="logo" src="./images/logos/logotienda.jpeg" alt="Logo tienda">
                    <input type="submit" class="button3" onclick="Cargar('carrito.jsp', 'cuerpo')" value="Carrito"/>
                    <h3>Vuelva a visitarnos pronto! :)</h3><br><br>
                    <h5>En 10s se va a mover al inicio de nuestra web!</h5>
                </div>
        <%
            }

            session.removeAttribute("estadoPedido");
            session.removeAttribute("formaPago");
        %>
    </body>
</html>
