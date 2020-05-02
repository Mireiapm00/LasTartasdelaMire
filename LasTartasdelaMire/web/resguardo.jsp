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
            
            
        %>
        <script>
            mostrarCarritoResguardo();
        </script>
        <h2>Paso 1 de 3: Resguardo</h2>
        
            <div class="datosEnvioTag">
                <h4>Datos de Envío y Facturación</h4>
                <p>
                    <%=nombre%> <%=apellidos%> - <%=tlf%><br>
                    <%=domicilio%> <br>
                    <%=poblacion%> <%=cp%> <br>
                    <%=provincia%><br>
                </p>
                <form method="post" onsubmit="ProcesarForm(this, '%SERVLET_MODIFICARDATOS', 'cuerpo');return false">
                    <input type="submit" class="button3" value="Cambiar Datos"/>
                </form>
                
                <h4>Forma de pago</h4>
                
            </div>
            
            <div class="datosEnvioTag2">
                <h4>Datos de la compra</h4>
                <p id="carritoTableResguardo">

                </p>
            </div
           
        
        
        
        <button class="button3">Cancelar</button>
               
    </body>
</html>
