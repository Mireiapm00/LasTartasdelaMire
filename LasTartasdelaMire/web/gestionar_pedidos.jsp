<%-- 
    Document   : gestionar_pedidos
    Created on : 04-may-2020, 12:12:40
    Author     : arant
--%>

<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.lang.String"%>
<%@page import="java.util.Date"%>
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
            String usuarioA = (String)session.getAttribute("usuario");
            ResultSet infoUsuario = con.obtenerUsuarioBD(usuarioA);
            infoUsuario.next();
            int id = infoUsuario.getInt("id");
            
            ResultSet pedidosUsuario = con.obtenerPedidosUsuarioBD(id);

        %>
        <h2>Gestionar pedidos</h2>
       
        <table class="gestionTable">
            <thead>
                <tr class="alineadoIzq">
                    <th class="alineado">Código del pedido</th>
                    <th>Fecha</th>
                    <th>Importe</th>
                    <th>Estado</th>
                    <th>Acción</th>
                </tr>
            </thead>
                <%
                    while (pedidosUsuario.next()) {
                        int codigo = pedidosUsuario.getInt("id_pedido");
                        Date fecha = pedidosUsuario.getDate("fecha");
                        float importe = pedidosUsuario.getFloat("importe");
                        String estado = pedidosUsuario.getString("estado");  
                        String carrito = pedidosUsuario.getString("carrito");
                        
                        Map<Integer, Integer> map = new HashMap<Integer,Integer>();
                        
                        String[] pairs = carrito.split("{ *:* }");
                        
                        for(int i = 0; i < pairs.length; i++){
                            String pair = pairs[i];
                            String[] keyValue = pair.split(":");
                            map.put((Integer.valueOf(keyValue[0])), (Integer.valueOf(keyValue[1])));
                        }
                        
                %>
                <tr>
                    <td class="alineado"><%=codigo%></td>
                    <td><%=fecha%></td>
                    <td><%=importe%>€</td>
                    <td><%=estado%></td>
                    <%
                        if(estado.equals("Pendiente")){
                    %>
                    <td>
                        <form method="post" onsubmit="ProcesarForm(this,'GestionarPedidosUsuario','cuerpo'); return false">
                            <input type="text" name="id_p" hidden value="<%=codigo%>"/>
                            <input type="submit" value="Eliminar pedido"  />
                        </form>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
                <tfoot>
                    <tr><td colspan="5" class="alineado"><a onclick="Cargar('op_usuario.jsp','cuerpo')" id="button2">Volver</a></td></tr>
                </tfoot>
        </table>
    </body>
</html>
