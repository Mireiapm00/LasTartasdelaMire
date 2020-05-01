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
        <h2>Paso 1 de 3: Resguardo</h2>
        <table>
            
            
        </table>
        
    </body>
</html>
