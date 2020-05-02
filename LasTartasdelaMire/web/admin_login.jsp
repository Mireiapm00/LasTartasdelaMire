<%-- 
    Document   : admin_login
    Created on : 30-abr-2020, 16:32:44
    Author     : arant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String adminActual = (String)session.getAttribute("admin");
            if(adminActual != null){ //Si adminActual existe, se borra(caso CerrarSesion)
                session.removeAttribute("admin");
            }
        %>
        <h2>Acceso administrador</h2>
        
        <div class="cuerpo1">
            <form method="post" onsubmit="ProcesarForm(this, 'LoginAdmin', 'cuerpo');return false"><!-- action="Cargar('op_administrador.html', 'cuerpo')" -->
                <table>
                    <tr> 
                        <td><label for="admin">Administrador </label></td>
                        <td><input name="admin" type="text"></td>
                    </tr>
                    <tr>
                        <td><label for="pass">Clave </label></td>
                        <td><input name="pass" type="password"></td>
                    </tr>
                </table>
                
                <input type="submit" value="Enviar">
            </form>
        </div>
        
    </body>
</html>
