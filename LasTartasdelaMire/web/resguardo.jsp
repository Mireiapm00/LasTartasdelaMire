<%-- 
    Document   : resguardo
    Created on : 01-may-2020, 12:42:05
    Author     : Mireia
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="p2.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Resguardo</title>
        <link href="./css/estilos_carrito.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            List<ProductoBD> carrito = (List<ProductoBD>) session.getAttribute("carrito");
            AccesoBD con = new AccesoBD();
            
            ResultSet infoUsuario = con.obtenerUsuarioBD((String)session.getAttribute("usuario"));
          
            infoUsuario.next();
          
            String nombre = infoUsuario.getString("nombre");
            String apellidos = infoUsuario.getString("apellidos");
            int tlf = infoUsuario.getInt("tlf");
            String poblacion = infoUsuario.getString("poblacion");
            String provincia = infoUsuario.getString("provincia");
            int cp = infoUsuario.getInt("cp");
            String usuario = infoUsuario.getString("usuario");
            String domicilio = infoUsuario.getString("domicilio");
            String tarjeta = infoUsuario.getString("tarjeta");
            
            
        %>
        
        <h2>Paso 1 de 3: Resguardo</h2>
        
            <div class="datosEnvioTag">
                <h4>Datos de Envío y Facturación</h4>
                <form method="post" onsubmit="ProcesarForm(this, '%SERVLETMODIFICARDATOS%', 'cuerpo');return false">
                    <input type="submit" class="button3" value="Cambiar Datos"/>
                </form>
                <p>
                    <%=nombre%> <%=apellidos%> - <%=tlf%><br>
                    <%=domicilio%> <br>
                    <%=poblacion%> <%=cp%> <br>
                    <%=provincia%><br>
                </p>
                
                <br>
                <h4>Forma de pago</h4>
                <form method="post" action="Tramitacion">
                    
                    <input type="radio" name="formaPago" id="tarjeta" value="tarjeta" checked>Tarjeta de crédito
                    <input type="radio" name="formaPago" id="contrareembolso" value="contrareembolso">Contrareembolso
                    <br><br>
                    
                    <h4>Datos de la compra</h4>
                    <table>
                        <thead><tr><th>Nombre</th><th>Unidades</th><th>Precio</th><th>Importe</th></tr></thead>

                        <%
                            float importe_total = 0;
                            for (ProductoBD p : carrito) {
                                importe_total += p.getPrecio() * p.getCantidad();
                        %>
                            <tr>   
                                <td><img src=<%=p.getImagen()%> alt="<%=p.getNombre()%>"> <%=p.getNombre()%> </td>
                                <td><%=p.getCantidad()%> </td>
                                <td><%=p.getPrecio()%>€</td>
                                <td><%=(p.getPrecio() * p.getCantidad())%>€</td>
                            </tr>
                        <%}
                            session.setAttribute("importe", importe_total);
                        %>
                        <tr>
                            <td id="tag" colspan="4">Importe Total <%=importe_total%> €</td>
                        </tr>
                    </table>
                        <input type="submit" class="button3" value="Tramitar pedido"/>
                </form>
                <input type="submit" class="button3" onclick="Cargar('check_pedido.jsp', 'cuerpo')" value="Cancelar"/>
            </div>  
    </body>
</html>
