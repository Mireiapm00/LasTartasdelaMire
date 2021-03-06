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
            session.setAttribute("origen_resguardo", null);
            
            AccesoBD con = new AccesoBD();
            ResultSet infoUsuario = con.obtenerUsuarioBD((String)session.getAttribute("usuario"));
            
            infoUsuario.next();
            
            String nombre = infoUsuario.getString("nombre");   
            String apellidos = infoUsuario.getString("apellidos");
        %>
        
        <h2>Usuari@: <%=nombre%> <%=apellidos%></h2>
                
        <div class="options">
            <a onclick="Cargar('cambiar_datos.jsp','cuerpo')" class="button1">Cambiar datos</a>
            <a onclick="Cargar('gestionar_pedidos.jsp','cuerpo')" class="button1"> Gestionar pedidos</a>
            <form method="post" onsubmit="ProcesarForm(this, 'CerrarSesion', 'cuerpo');return false">
                <input type="submit" class="button1" value="Cerrar sesión">
            </form>
        </div>
    </body>
</html>
