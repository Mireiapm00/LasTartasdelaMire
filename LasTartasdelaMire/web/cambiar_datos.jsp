<%-- 
    Document   : cambiar_datos
    Created on : 02-may-2020, 1:25:04
    Author     : arant
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./css/estilos_usuario.css" rel="stylesheet" type="text/css">
    </head>
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
            String pass = infoUsuario.getString("password");
            String usuario = infoUsuario.getString("usuario");
            String domicilio = infoUsuario.getString("domicilio");
        %>
        
        <h2>Modificar información</h2>
        <form>
        <table class="cambiarDatosTable">
            <tr><td colspan="2" style="padding-bottom: 1%;"><b>Introduce la siguiente información:</b></td></tr>
            <tr>
                <td><label for="user">Usuario:</label></td>
                <td><input id="user" type="text" name="user" value="<%=usuario%>" required autofocus></td>
            </tr>
            <tr>
                <td><label for="pass">Clave:</label></td>
                <td><input id="pass" type="text" name="pass" value="<%=pass%>" required></td>
            </tr>

            <tr>
                <td><label for="nombre">Nombre:</label></td>
                <td><input id="nombre" type="text" name="nombre" pattern="[A-Za-z]{0,50}" value="<%=nombre%>" required></td>
            </tr>
            <tr>
                <td><label for="apell">Apellidos:</label></td>
                <td><input id="apell" type="text" name="apell" value="<%=apellidos%>" required></td>
            </tr>
            <tr>
                <td><label for="dom">Domicilio:</label></td>
                <td><input id="dom" type="text" name="dom" value="<%=domicilio%>" required></td>
            </tr>
            <tr>
                <td><label for="pob">Población:</label></td>
                <td><input id="pob" type="text" name="pob" value="<%=poblacion%>" required></td>
            </tr>
            <tr>
                <td><label for="pro">Provincia:</label></td>
                <td><input id="pro" type="text" name="pro" value="<%=provincia%>" required></td>
            </tr>
            <tr>
                <td><label for="cp">Código Postal:</label></td>
                <td><input id="cp" type="text" name="cp" value="<%=cp%>" required></td>
            </tr>
            <tr>
                <td><label for="tlf">Teléfono:</label></td>
                <td><input id="tlf" type="tel" name="tlf" pattern="[0-9]{9}" value="<%=tlf%>" required></td>
            </tr>
            <tfoot>
             <tr>
                <td colspan="2" id="botonesBar">
                    <a onclick="Cargar('op_usuario.jsp','cuerpo')" class="button3">Cambiar</a>
                    <a onclick="Cargar('op_usuario.jsp','cuerpo')" class="button3">Cancelar</a>
                </td>
             </tr>
            </tfoot>
        </table>
        </form> 
    </body>
</html>
