<%-- 
    Document   : productos
    Created on : 11-abr-2020, 22:45:34
    Author     : Mireia
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="./css/estilos_productos.css" rel="stylesheet" type="text/css">
        <title>&nbsp;</title>
    </head>
    <body>
        <%
            AccesoBD con = AccesoBD.getInstance();
            List<ProductoBD> productos = con.obtenerProductosBD();
            int cont = 0;
        %>
        <h2 class="titulo">Hecha un vistazo a nuestra tienda</h2>
        <table>
            <% 
                for(ProductoBD producto : productos){
                    int codigo = producto.getId();
                    String nombre = producto.getNombre();
                    String descripcion = producto.getDescripcion();
                    float precio = producto.getPrecio();
                    int existencias = producto.getStock();
                    String imagen = producto.getImagen();
                    if(cont == 0 || cont == 3){
            %>
                        <tr>
            <%      }%>
                
                    <td>
                        <div class="card">
                            <img src=<%=imagen%> alt=<%=nombre%>>
                            <h2><%=nombre%></h2>
                            <p class="precio"><%=precio%>€</p>
                            <p><%=descripcion%></p><p>(<%=existencias%> en stock, infinitas...)</p>
                            <p>
                                <%
                                    if(existencias > 0){
                                %>
                                        <button onclick="anadirProductoCarrito('<%=codigo%>','<%=nombre%>', '<%=precio%>', '<%=imagen%>', '<%=existencias%>', '<%=descripcion%>');">Añadir al carrito</button>
                                <%
                                  }
                                    else {
                                %>
                                        &nbsp;
                                <%
                                    }
                                %>
                                
                            </p>
                        </div>
                    </td>
                
            
            
            <%      if(cont == 2 || cont == 5){%>
                        </tr>
            <%      }
                    cont++;
                }
            %>
            
        </table>
    </body>
</html>
