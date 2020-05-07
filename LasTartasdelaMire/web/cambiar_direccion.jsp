<%-- 
    Document   : cambiar_direccion
    Created on : 07-may-2020, 18:57:57
    Author     : arant
--%>

<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%  
            AccesoBD con = new AccesoBD();
            ResultSet infoUsuario = con.obtenerUsuarioBD((String)session.getAttribute("usuario"));
            
            infoUsuario.next();
            
            int id = infoUsuario.getInt("id");
            session.setAttribute("id_usuario", id); //Guardar el id, para recogerlo en el servlet
            String poblacion = infoUsuario.getString("poblacion");
            String provincia = infoUsuario.getString("provincia");
            int cp = infoUsuario.getInt("cp");
            String domicilio = infoUsuario.getString("domicilio");
        %>
        <form method="post" onsubmit="ProcesarForm(this, 'ModificarDatosUsuario', 'cuerpo'); return false">
        <table class="cambiarDatosTable">
            <tr><td colspan="2" style="padding-bottom: 1%;"><b>Introduce la siguiente información:</b></td></tr>
            <tr>
                <td><label for="dom">Domicilio:</label></td>
                <td><input id="dom" type="text" name="c8" value="<%=domicilio%>" required></td>
            </tr>
            <tr>
                <td><label for="pob">Población:</label></td>
                <td><input id="pob" type="text" name="c3" value="<%=poblacion%>" required></td>
            </tr>
            <tr>
                <td><label for="pro">Provincia:</label></td>
                <td><input id="pro" type="text" name="c4" value="<%=provincia%>" required></td>
            </tr>
            <tr>
                <td><label for="cp">Código Postal:</label></td>
                <td><input id="cp" type="text" name="c5" value="<%=cp%>" required></td>
            </tr>
            <tfoot>
             <tr>
                <td colspan="2" id="botonesBar">
                    <input type="submit" class="button3" value="Guardar" />
                    <input type="button" class="button3" name="bCancelar" value="Cancelar" onclick="Cargar('resguardo.jsp','cuerpo')"/>
                </td>
             </tr>
            </tfoot>
        </table>
        </form>
    </body>
</html>
