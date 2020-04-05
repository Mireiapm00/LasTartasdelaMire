<%-- 
    Document   : comprobar
    Created on : 05-abr-2020, 20:27:02
    Author     : Mireia
--%>

<%@page contentType="text/html" import="p2.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
          AccesoBD con = AccesoBD.getInstance();
          boolean res;
          res = con.comprobarAcceso();
            
        %>
        <h1><%=res%></h1>
    </body>
</html>
