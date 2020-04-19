<%-- 
    Document   : carrito_login
    Created on : 19-abr-2020, 19:50:56
    Author     : Mireia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="./css/estilos_carrito.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <h2>Carrito</h2>
        <%
            String mensaje = (String)session.getAttribute("mensaje");
            if(mensaje != null){
                session.removeAttribute("mensaje");
        %>
                <h1><%=mensaje%></h1>
                
        <%
            }

            String from = "carrito";
            session.setAttribute("from",from);
        %>
                <div class="cuerpo1">
                    <form name="usuarioLogin" method="post" onsubmit="ProcesarForm(this, 'LoginTienda', 'cuerpo');return false">
                        <table>
                            <tr> 
                                <td><label for="usuario">Usuario:</label></td>
                                <td><input name="usuario" type="text" ></td>
                            </tr>
                            <tr>
                                <td><label for="clave">Clave:</label></td>
                                <td><input name="clave" type="password"></td>
                            </tr>
                        </table>
                        <input class="button0" type="submit" value="Acceder">
                        <input class="button0" type="button" value="Registrarse" onclick="Cargar('registrarse.html', 'cuerpo')">
                    </form>
                </div>
       
        <div class="cuerpo" id="cuerpo">
        </div>
    </body>
</html>
