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
            int idUsuario = infoUsuario.getInt("id");
            String domicilio = infoUsuario.getString("domicilio");
            String tarjeta = infoUsuario.getString("tarjeta");
            
            session.setAttribute("idUsuario", idUsuario);
            session.setAttribute("direccion_envio", domicilio);
            session.setAttribute("poblacion", poblacion);
            session.setAttribute("cp", cp);
             if(!tarjeta.equals("null")){
                session.setAttribute("tarjeta", tarjeta);
            }
            else {
                session.setAttribute("tarjeta", " ");
                tarjeta = " ";
            }
            
            session.setAttribute("origen_resguardo", "resguardo.jsp");
            
        %>
        
        <h2>Paso 1 de 2: Resguardo</h2>
        
            <div class="datosEnvioTag">
                <h4>Datos de Envío y Facturación</h4>
                
                <input type="button" class="button3" name="bModificar" value="Cambiar Datos" onclick="Cargar('cambiar_direccion.jsp', 'cuerpo')"/>
              
                <p>
                    <%=nombre%> <%=apellidos%> - <%=tlf%><br>
                    <%=domicilio%> <br>
                    <%=poblacion%> <%=cp%> <br>
                    <%=provincia%><br><br>
                </p>
                
                <h4>Forma de pago</h4>
                <form method="post" onsubmit="ProcesarForm(this, 'Tramitacion', 'cuerpo'); return false;">
                    
                    <%
                        if(tarjeta.isEmpty()){
                            tarjeta = "";
                        }
                    %>
                    
                    <input type="radio" name="formaPago" id="formaPago" value="tarjeta" onclick="comprobarCampoTarjeta(this, '<%=tarjeta%>');">Tarjeta de crédito
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" name="formaPago" id="formaPago" value="contrareembolso" onclick="comprobarCampoTarjeta(this, '<%=tarjeta%>');">Contrareembolso
                    <br><br>
                    <div id="numeroTarjeta">&nbsp;</div>        
                    
                    <br><br>
                       
                    <h4>Datos de la compra</h4>
                    <table>
                        <thead><tr><th>  Nombre  </th><th>  Uds  </th><th>  Precio/Ud  </th><th>  Importe  </th></tr></thead>

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
                <input type="submit" class="button3" onclick="Cargar('carrito.jsp', 'cuerpo')" value="Cancelar"/>
            </div>  
    </body>
</html>
