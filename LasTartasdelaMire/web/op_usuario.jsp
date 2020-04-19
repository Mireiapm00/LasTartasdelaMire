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
            
            int id = infoUsuario.getInt("id");
            String nombre = infoUsuario.getString("nombre");
            String apellidos = infoUsuario.getString("apellidos");
            int tlf = infoUsuario.getInt("tlf");
            String poblacion = infoUsuario.getString("poblacion");
            String provincia = infoUsuario.getString("provincia");
            int cp = infoUsuario.getInt("cp");
            String usuario = infoUsuario.getString("usuario");
            String domicilio = infoUsuario.getString("domicilio");
            
        %>
        
        <h2>Usuari@: <%=nombre%></h2>
        
        <!-- MOSTRAR INFO DEL USUARIO EN CUADRITO MONO -->
        
        <div class="options">
            <a onclick="Cargar('cambiar_datos.html','cuerpo')" class="button1">Cambiar datos</a>
            <a onclick="Cargar('gestionar_pedidos.html','cuerpo')" class="button1"> Gestionar pedidos</a>
            <form method="post" onsubmit="ProcesarForm(this, 'CerrarSesion', 'cuerpo');return false">
                <input type="submit" class="button1" value="Cerrar sesión">
            </form>
        </div>
        <!--<div class="cuerpo"></div>-->
    </body>
</html>
