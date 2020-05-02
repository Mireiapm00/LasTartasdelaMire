<%-- 
    Document   : administracion
    Created on : 30-abr-2020, 16:30:23
    Author     : arant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./css/estilos_administracion.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        <%
            String adminActual = (String)session.getAttribute("admin");
            
            if(adminActual == null){ //Si adminActual no existe, se logue
                response.sendRedirect("admin_login.jsp");
            }
            else{ //si adminActual existe, tiene las opciones
        %>
            <h2>Administrador: <%=adminActual%> </h2>
            <div class="options">
                <a onclick="Cargar('gestionar_usuarios.jsp','cuerpo')" class="button1">Gestionar Usuarios</a>
                <a onclick="Cargar('gestionar_pedidos2.html','cuerpo')" class="button1">Gestionar pedidos</a>
                <a onclick="Cargar('gestionar_productos.html','cuerpo')" class="button1">Gestionar Productos</a>
                <a onclick="Cargar('admin_login.jsp','cuerpo')" class="button1" >Cerrar Sesion</a>
            </div>
        <%
           
            }

        %>
    </body>
</html>
