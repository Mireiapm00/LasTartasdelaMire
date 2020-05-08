<%-- 
    Document   : pedidoFinalizado
    Created on : 02-may-2020, 23:03:56
    Author     : Mireia
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="p2.*"%>
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
                       
            if(session.getAttribute("estadoPedido").equals("Pendiente")){
                AccesoBD con = new AccesoBD();
                ResultSet infoPedido = con.obtenerUltimoPedidoBD();
                infoPedido.next();
                int id_pedido = infoPedido.getInt("id_pedido");
        %>
                <h2>Paso 2 de 2: Pedido finalizado</h2>
                
                <div class="bodyCheckPedido">
                    <img class="logo" src="./images/logos/logotienda.jpeg" alt="Logo tienda">
                    <h3>Gracias por su compra :)</h3>
                </div>
                <div class="insideCheckPedido">
                    <h4>Identificador del pedido: <%=id_pedido%></h4>
                    
                    <%
                        if(session.getAttribute("contrareembolso").equals("contrareembolso")){
                    %>
                            <p>No olvides que debes abonar el importe cuando recibas el pedido.</p>
                    <%
                        }                    
                    %>
                          
                    <p>El pedido se entregará en los próximos días!</p>
                    <a href="index.html" onclick="borrarCarrito();" class="button3">Ir a inicio</a>
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
            
            session.removeAttribute("contrareembolso");
            session.removeAttribute("estadoPedido");
            session.removeAttribute("formaPago");
        %>
    </body>
</html>
