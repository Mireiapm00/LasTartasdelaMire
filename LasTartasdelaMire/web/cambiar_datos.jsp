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
        <script type="text/javascript">
            function validar_clave(){
                var clave = document.f1.c6.value;
                var clave_repe = document.f1.c6_repe.value;
                if(clave === clave_repe){
                    
                    return true;
                }else{
                    alert("Las contraseñas deben de coincidir.");
                    return false;
                }
            }
        </script>
    </head>
    </head>
    <body>
        <%  
            AccesoBD con = new AccesoBD();
            ResultSet infoUsuario = con.obtenerUsuarioBD((String)session.getAttribute("usuario"));
            
            infoUsuario.next();
            
            int id = infoUsuario.getInt("id");
            session.setAttribute("id_usuario", id); //Guardar el id, para recogerlo en el servlet
            String nombre = infoUsuario.getString("nombre");
            String apellidos = infoUsuario.getString("apellidos");
            int tlf = infoUsuario.getInt("tlf");
            String poblacion = infoUsuario.getString("poblacion");
            String provincia = infoUsuario.getString("provincia");
            int cp = infoUsuario.getInt("cp");
            String pass = infoUsuario.getString("password");
            String usuario = infoUsuario.getString("usuario");
            String domicilio = infoUsuario.getString("domicilio");
            String tarjeta = infoUsuario.getString("tarjeta");
            
        %>
        
        <h2>Modificar información</h2>
        <form name='f1' method="post" onsubmit="ProcesarForm(this, 'ModificarDatosUsuario', 'cuerpo'); return false">
        <table class="cambiarDatosTable">
            <tr><td colspan="2" style="padding-bottom: 1%;"><b>Introduce la siguiente información:</b></td></tr>
            <tr>
                <td><label for="user">Usuario:</label></td>
                <td><input id="user" type="text" name="c7" value="<%=usuario%>" required  disabled></td>
            </tr>
            <tr>
                <td><label for="pass">Contraseña:</label></td>
                <td><input id="pass" type="text" name="c6" value="<%=pass%>" required onchange="validar_clave()"></td>
            </tr>
            <tr>
                <td><label for="pass">Repite la contraseña:</label></td>
                <td><input id="pass" type="text" name="c6_repe" value="<%=pass%>" required onchange="validar_clave()"></td>
            </tr>
            <tr>
                <td><label for="nombre">Nombre:</label></td>
                <td><input id="nombre" type="text" name="c0" value="<%=nombre%>" required></td>
            </tr>
            <tr>
                <td><label for="apell">Apellidos:</label></td>
                <td><input id="apell" type="text" name="c1" value="<%=apellidos%>" required></td>
            </tr>
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
             <tr>
                <td><label for="tarj">Tarjeta (opcional):</label></td>
                <td><input id="tarj" type="number" name="c9" pattern="[0-9]{16}" value="<%=tarjeta%>"></td>
            </tr>
            <tr>
                <td><label for="tlf">Teléfono:</label></td>
                <td><input id="tlf" type="tel" name="c2" pattern="[0-9]{9}" min="9" max="9" value="<%=tlf%>" required></td>
            </tr>
            <tfoot>
             <tr>
                <td colspan="2" id="botonesBar">
                    <input type="submit" class="button3" name="bModificar" value="Guardar" />
                    <input type="button" class="button3" name="bCancelar" value="Cancelar" onclick="Cargar('op_usuario.jsp','cuerpo')"/>
                </td>
             </tr>
            </tfoot>
        </table>
        </form> 
    </body>
</html>
