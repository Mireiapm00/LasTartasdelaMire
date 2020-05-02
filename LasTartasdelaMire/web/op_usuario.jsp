<%-- 
    Document   : op_usuario.jsp
    Created on : 12-abr-2020, 0:09:28
    Author     : Mireia
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>&nbsp;</title>
        <link href="./css/estilos_usuario.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            AccesoBD con = new AccesoBD();
            ResultSet infoUsuario = con.obtenerUsuarioBD((String)session.getAttribute("usuario"));
            
            infoUsuario.next();
            
            String nombre = infoUsuario.getString("nombre");    
        %>
        
        <h2>Usuari@: <%=nombre%><%=apellidos%></h2>
        
        <!-- MOSTRAR INFO DEL USUARIO EN CUADRITO MONO -->
        
        <div class="options">
            <a onclick="Cargar('cambiar_datos.jsp','cuerpo')" class="button1">Cambiar datos</a>
            <a onclick="Cargar('gestionar_pedidos.html','cuerpo')" class="button1"> Gestionar pedidos</a>
            <form method="post" onsubmit="ProcesarForm(this, 'CerrarSesion', 'cuerpo');return false">
                <input type="submit" class="button1" value="Cerrar sesión">
            </form>
        </div>
        <!--<div class="cuerpo"></div>-->
    </body>
</html>
