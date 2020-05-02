<%-- 
    Document   : gestionar_usuarios
    Created on : 30-abr-2020, 18:34:26
    Author     : arant
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="./css/estilos_administracion.css" rel="stylesheet" type="text/css">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            AccesoBD con = AccesoBD.getInstance();
            List<UsuarioBD> usuarios = con.obtenerUsuariosGestionBD();
        %>
        <h2>Gestión de usuarios</h2>

        <table class="gestionusuTable">
            <%
                for(UsuarioBD usuario : usuarios){
                   int codigo = usuario.getId();
                   String user = usuario.getUsuario();
                   String pass = usuario.getPassword();
            %>
            <tr>
                <td><b>Usuario</b></td>
                <td><b>Contraseña</b></td>
                <td><b>Información de pedidos</b></td>
                <td><a onclick="Cargar('modificarUsuario.html','cuerpo')" id="button3">Modificar usuario</a></td>
            </tr>
            <tr>
                <td><%=user%></td>
                <td>*************</</td>
                <td>5 pedidos completados</td>
                <td class="alineado"><input type="checkbox"></td>
            </tr>
            <tr>
                <td colspan="4" class="alineado">
                    <a onclick="Cargar('administracion.jsp','cuerpo')" class="button2">Atrás</a>
                </td>
            </tr>
            <% 
                } 
            %>
        </table>

    </body>
</html>
