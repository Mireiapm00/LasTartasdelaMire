<%-- 
    Document   : usuario_login
    Created on : 11-abr-2020, 23:51:13
    Author     : Mireia
--%>

<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>&nbsp;</title>
        <script src="js/libCapas.js" type="text/javascript"></script>
        <link href="./css/estilos_usuario.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h2>Accede a nuestra tienda online</h2>
        <%
            String mensaje = (String)session.getAttribute("mensaje");
            if(mensaje != null){
                session.removeAttribute("mensaje");
        %>
                <h1><%=mensaje%></h1>
        <%
            }

            String usuarioActual = (String)session.getAttribute("usuario");
            if(usuarioActual == null) { //usuario no registrado
            
        %>
                <div class="cuerpo1">
                    <form name="usuarioLogin" method="post" onsubmit="ProcesarForm(this, 'LoginUsuario', 'cuerpo');return false">
                        <table>
                            <tr> 
                                <td><label for="usuario">Usuario </label></td>
                                <td><input name="usuario" type="text"></td>
                            </tr>
                            <tr>
                                <td><label for="clave">Clave </label></td>
                                <td><input name="clave" type="password"></td>
                            </tr>
                        </table>
                        <input class="button0" type="submit" value="Acceder">
                        <input class="button0" type="button" value="Registrarse" onclick="Cargar('registrarse.jsp', 'cuerpo')">
                    </form>
                </div>
            </form>
                
        <%
            }
            else {
                response.sendRedirect("op_usuario.jsp");
            }
        %>
        <!--<div class="cuerpo"></div>-->
    </body>
</html>
