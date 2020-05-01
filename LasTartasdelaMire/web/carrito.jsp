<%-- 
    Document   : carrito
    Created on : 19-abr-2020, 19:28:24
    Author     : Mireia
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="./css/estilos_carrito.css" rel="stylesheet" type="text/css">
    </head>
    <body>
        
        <%
            
        String usuarioActual = (String)session.getAttribute("usuario");
        if(usuarioActual == null) { //usuario no registrado  
            response.sendRedirect("carrito_login.jsp");
        }
        else {
            String mensajeP = (String) session.getAttribute("mensajeProducto");
            if(mensajeP == null){
                mensajeP = "";
            }
            else{
                session.removeAttribute("mensajeProducto");
            }
        %>
            <h2>Carrito</h2>
            <h4><%=mensajeP%></h4>
            <table class="carritoTable" id="carritoTable" style="text-align: center;">
                <script>
                    crearProductosCarritoPage();
                </script>
            </table>

            <div class="cuerpo" id="cuerpo">
            </div>
        <%
        }
        %>
        
        
    </body>
</html>
